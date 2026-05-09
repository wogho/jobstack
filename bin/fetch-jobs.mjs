#!/usr/bin/env node
/**
 * Playwright-based job listing fetcher for JS-rendered platforms.
 * Usage: node fetch-jobs.mjs <platform> <keyword> [limit]
 * Platform: jumpit | jobkorea | saramin
 * Outputs JSON array to stdout.
 *
 * saramin: Uses official Saramin Open API (oapi.saramin.co.kr)
 *   Requires SARAMIN_API_KEY env var. Apply free at: https://oapi.saramin.co.kr/join
 *   Falls back to empty array if key not set.
 */

import { chromium } from 'playwright';

const [, , platform, keyword, limitArg] = process.argv;
const limit = parseInt(limitArg || '20', 10);

if (!platform || !keyword) {
  process.stderr.write('Usage: fetch-jobs.mjs <platform> <keyword> [limit]\n');
  process.exit(1);
}

const PLATFORMS = ['jumpit', 'programmers', 'jobkorea', 'saramin'];
if (!PLATFORMS.includes(platform)) {
  process.stderr.write(`Unknown platform: ${platform}. Supported: ${PLATFORMS.join(', ')}\n`);
  process.exit(1);
}

// ─── saramin: uses official JSON API, no browser needed ───────────────────────
if (platform === 'saramin') {
  const apiKey = process.env.SARAMIN_API_KEY || '';
  if (!apiKey) {
    process.stderr.write('SARAMIN_API_KEY not set. Get free key at https://oapi.saramin.co.kr/join\n');
    process.stdout.write(JSON.stringify([]) + '\n');
    process.exit(0);
  }

  const params = new URLSearchParams({
    'access-key': apiKey,
    keywords: keyword,
    job_mid_cd: '2', // IT 직종
    count: String(Math.min(limit, 110)),
    sort: 'pd', // 등록일순
    fields: 'posting-date,expiration-date,keyword,position,salary,company',
  });
  const url = `https://oapi.saramin.co.kr/job-search?${params.toString()}`;

  try {
    const res = await fetch(url, { headers: { Accept: 'application/json' } });
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    const json = await res.json();
    const jobs = (json?.jobs?.job || []).map(j => {
      const exp = j['expiration-date'];
      const company = j.company?.['detail']?.name || j.company?.name || '';
      const title = j.position?.title || '';
      const href = j.url || '';
      return {
        platform: 'saramin',
        company,
        title,
        deadline: exp ? exp.replace('T', ' ').slice(0, 10) : '상시채용',
        dRemaining: '',
        link: href,
      };
    });
    process.stdout.write(JSON.stringify(jobs, null, 2) + '\n');
  } catch (err) {
    process.stderr.write(`saramin API error: ${err.message}\n`);
    process.stdout.write(JSON.stringify([]) + '\n');
  }
  process.exit(0);
}

// ─── Playwright-based platforms ────────────────────────────────────────────────
const browser = await chromium.launch({
  headless: true,
  args: ['--no-sandbox', '--disable-dev-shm-usage'],
});

const context = await browser.newContext({
  userAgent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
  locale: 'ko-KR',
});

const page = await context.newPage();
let jobs = [];

try {
  if (platform === 'jumpit') {
    const url = `https://jumpit.saramin.co.kr/search?sort=rsp_rate&keyword=${encodeURIComponent(keyword)}`;
    await page.goto(url, { waitUntil: 'commit', timeout: 15000 });
    await page.waitForTimeout(5000);

    jobs = await page.evaluate((lim) => {
      const links = Array.from(document.querySelectorAll('a[href*="/position/"]'));
      return links.slice(0, lim).map(a => {
        const rawTitle = a.getAttribute('title') || '';
        const title = rawTitle.replace(/<[^>]+>/g, '').trim();
        const lines = a.innerText.split('\n').map(l => l.trim()).filter(Boolean);
        const dLine = lines[0] || '';
        const company = lines[1] || '';
        let deadline = '마감일 미확인';
        if (dLine === 'D-day') deadline = '오늘 마감!';
        else if (dLine.startsWith('D-')) deadline = `${dLine.replace('D-', '')}일 후 마감`;
        else if (dLine === '상시채용') deadline = '상시채용';
        return { platform: 'jumpit', company, title, deadline, dRemaining: dLine, link: a.href };
      }).filter(j => j.title && j.company);
    }, limit);

  } else if (platform === 'programmers') {
    const url = `https://career.programmers.co.kr/job_positions?query=${encodeURIComponent(keyword)}`;
    await page.goto(url, { waitUntil: 'commit', timeout: 15000 });
    await page.waitForTimeout(5000);

    jobs = await page.evaluate((lim) => {
      const items = document.querySelectorAll('[class*="List"] li, article, [class*="job-item"]');
      return Array.from(items).slice(0, lim).map(item => {
        const titleEl = item.querySelector('h2, h3, [class*="title"]');
        const companyEl = item.querySelector('[class*="company"]');
        const deadlineEl = item.querySelector('[class*="due"], [class*="deadline"], time');
        const link = item.querySelector('a')?.href || '';
        return {
          platform: 'programmers',
          company: companyEl?.innerText?.trim() || '',
          title: titleEl?.innerText?.trim() || '',
          deadline: deadlineEl?.innerText?.trim() || '마감일 미확인',
          link,
        };
      }).filter(j => j.title);
    }, limit);

  } else if (platform === 'jobkorea') {
    // jobkorea redesigned with Tailwind CSS — use link-based approach
    const url = `https://www.jobkorea.co.kr/Search/?stext=${encodeURIComponent(keyword)}&posted=7&ord=RegDate`;
    try {
      await page.goto(url, { waitUntil: 'networkidle', timeout: 25000 });
      await page.waitForTimeout(3000);

      jobs = await page.evaluate((lim) => {
        const seen = new Set();
        const results = [];

        // Find all anchor links to job detail pages (title links have text)
        const titleLinks = Array.from(document.querySelectorAll('a[href*="/Recruit/GI_Read/"]'))
          .filter(a => a.innerText?.trim().length > 3);

        for (const titleLink of titleLinks) {
          const baseHref = titleLink.href.split('?')[0];
          if (seen.has(baseHref)) continue;
          seen.add(baseHref);

          // Walk up to find the card container that has deadline info
          let card = titleLink.parentElement;
          for (let i = 0; i < 6; i++) {
            if (!card) break;
            const txt = card.innerText || '';
            if (txt.includes('마감') || txt.includes('채용') || txt.includes('등록')) break;
            card = card.parentElement;
          }

          const fullText = card?.innerText || '';

          // Extract company name — try CSS selector first, then text heuristic
          const companySpan = card?.querySelector('span a[href*="/company/"], span a[href*="/corp/"]');
          let companyText = companySpan?.innerText?.trim() || '';
          if (!companyText) {
            // Heuristic: title is in the link text, company is usually the line after it in the card
            const lines = fullText.split('\n').map(l => l.trim()).filter(Boolean);
            const titleIdx = lines.findIndex(l => l === titleLink.innerText.trim());
            if (titleIdx >= 0 && titleIdx + 1 < lines.length) {
              const candidate = lines[titleIdx + 1];
              // Company names are short and don't contain slashes or Korean location suffixes
              if (candidate.length < 40 && !candidate.includes('/') && !candidate.includes('마감')) {
                companyText = candidate;
              }
            }
          }

          // Extract deadline from text: "MM/DD(요일) 마감" or "상시채용"
          const dMatch = fullText.match(/(\d{2})\/(\d{2})\([월화수목금토일]\)\s*마감/);
          const deadline = dMatch ? dMatch[0]
            : fullText.includes('상시채용') ? '상시채용'
            : fullText.includes('채용시') ? '채용시마감'
            : '마감일 미확인';

          results.push({
            platform: 'jobkorea',
            company: companyText,
            title: titleLink.innerText.trim(),
            deadline,
            dRemaining: '',
            link: baseHref,
          });

          if (results.length >= lim) break;
        }
        return results;
      }, limit);
    } catch (err) {
      process.stderr.write(`jobkorea scrape error: ${err.message}\n`);
    }
  }
} catch (err) {
  process.stderr.write(`Error fetching ${platform}: ${err.message}\n`);
} finally {
  await browser.close();
}

process.stdout.write(JSON.stringify(jobs, null, 2) + '\n');
