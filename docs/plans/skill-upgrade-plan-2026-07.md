# jobstack 스킬 전면 업그레이드 계획

- **작성일**: 2026-07-03 · **기준 커밋**: `main @ 0559ba1` (PR#10 봇 경계 정리 머지 직후)
- **지식 소스**: tea-agent(헤르메스) Obsidian vault · hindsight Cloud · 발행 콘텐츠(네이버 블로그/스레드/인스타) · jobclaw 제품과 실사용 데이터 · 웹 리서치 9주제
- **분석 규모**: 4개 워크플로우 라운드, 총 **79개 에이전트**, 인사이트 **371건+**, 적대적 검증 → main 델타 재조정까지 완료

---

## 1. 요약

tea-agent가 축적한 지식 자산과 2026년 채용시장 트렌드를 대조한 결과, jobstack 13개 스킬 전체에 걸쳐 **126건의 업그레이드 항목**(P0 28 / P1 52 / P2 46)과 **신규 스킬 3개**(experience-bank, career-history, scout-profile), **공유 인프라 10건**이 확정됐다. 검증 과정에서 제안 52건은 기각·병합·기구현으로 정리했고(사유 보존), 오너 결정이 필요한 사항 7건은 4자 에이전트 협의체(Council #1)로 전건 확정했다.

핵심 방향 세 가지:

1. **낡은 전제 교정** — 스킬들이 공채 중심·대졸 신입 전제 위에 있다. [사실] 2026년 공채만 채용은 10.2%(경총 500개사), 대기업 신입의 28.1%가 중고신입. 시장 수치는 스킬 본문에 박지 않고 "실행 시 WebSearch 확인" 규칙으로 전환한다.
2. **검증된 지식의 이식** — 발행 콘텐츠(블로그 day5~21)와 jobclaw 실코드에 이미 검증된 방법론(수정 우선순위 3단계, 추상어→질문 전환표, 수치 폴백 5기준, 꼬리질문 공통 5세트, 6축 채점)이 있다. 이것을 공유 템플릿 3종으로 단일화해 스킬들이 참조한다.
3. **완성 조건의 재정의** — [사실] 실사용 데이터(41명/695건)의 JTBD는 "진단→수정→재리뷰→제출 파일화" 루프다. 1회 첨삭이 아니라 제출 가능한 산출물까지가 완성이다.

**총 공수 추정**: S(30분 내) 93건 + M(1~2시간) 32건 + L(반나절+) 1건 + 인프라 10건 → **1인 기준 약 8~11일** (마일스톤 6개로 분할).

---

## 2. 분석 방법론

| 라운드 | 에이전트 | 내용 |
|---|---|---|
| R1 채굴·설계 | 49 | vault 발행 콘텐츠·도메인·결정·드림 회고 + hindsight recall 10쿼리 + jobclaw 제품 + 웹 6주제 → 다이제스트 → 13개 스킬 갭 분석 → 신규 스킬 3관점 생성·심사 → 항목별 적대적 검증 → 완결성 비평 |
| R2 보강 | 9 | 비평가 지적 공백: 미채굴 소스 5종(결정기록 전수, 실사용 덤프, 면접 PoC 저장소, 테스트 베이스라인, hindsight 8쿼리) + 웹 3주제(공공기관, 법제도, 비개발 직군) + 누락 신규 스킬 후보 4종 심사 |
| R3 확정 | 15 | 검증 수정방향을 반영한 스킬별 최종 지시서 + 공유 인프라 10건 스펙 + 신규 스킬 구현 스펙 |
| R4 재조정 | 6 | 분석 중 main에 머지된 15커밋(프리앰블 핫픽스·날조가드·출처강제·봇 경계·docx 산출)과 전 항목 대조 — 기구현 제거, 표기·정합 조정 |

모든 제안은 **근거(내부 자산 파일 또는 URL) 없이는 채택하지 않았고**, 항목마다 검증 가능한 완료 판정 기준(acceptance)을 붙였다.

---

## 3. 핵심 발견

### 3-1. 시장 전제가 바뀌었다 — 스킬은 아직 옛 전제

- [사실] 수시만 54.8% + 병행 35.0% = 수시 관여 89.8%, 공채만 10.2% (경총 2026, 500개사). 삼성만 정기 공채 유지.
- [사실] 중고신입(경력 6개월~3년)이 대기업 신입의 28.1%, 중고신입 선호가 HR 이슈 1위(33.5%). 경력은 숨기지 않고 무기화하는 게 표준.
- [사실] 다이렉트소싱 51.2% — "발견되는 채널"(프로필 상시 노출)이 지원 여정의 새 축인데 기존 13개 스킬은 전부 지원자 주도 여정만 커버.
- 스킬 영향: strategy의 "신입+대기업→공채 중심" 분기 삭제(STR-3), resume 증명사진 "공채는 필수" 교정(RES-3), tracker에 상시 모니터링 개념(TRK-2), 신규 scout-profile.

### 3-2. AI 전형 시대 — 탐지·검증·이원화

- [사실] 자소서 89만건 중 48.5% AI 의심(무하유), 적발 시 감점 42.2%+탈락 23.2%(고용정보원 500대 기업). 합격 공식은 "AI 초안 → 본인 경험·수치로 인간화 → 탐지 검사 → 전문가 첨삭" 4단계.
- [사실] 코딩테스트는 AI 금지·기본기 검증, 면접·과제는 AI 활용력 평가로 이원화(2026 카카오 등).
- 스킬 영향: 치환 테스트 2종 + AI풍 신호 진단을 공유 모듈(INFRA-3)로 만들어 cover-letter·review에 탑재. "탐지 리스크 진단" 같은 검증 불가 표현은 금지하고 "AI풍 신호 진단"으로 한정.

### 3-3. 실사용 데이터가 우선순위를 정한다

- [사실] jobclaw 실사용(41명/695건): 서류 197 > 회사분석 126 > 공고 104 > **파일출력 56** > 면접 33. 별도 355개 프롬프트 집계: 이력서·경력기술서 77건 1위, 그런데 resume SKILL.md에 "경력기술서" 언급 0건.
- 스킬 영향: auto 추천 순서 재정렬(AUTO-3), 신규 career-history(수요 1위 실증), 파일화 루프(INFRA-6 + review 파일화 단계).

### 3-4. 실사고에서 나온 가드레일

- [사실] jobclaw에서 사실 날조(JLPT 급수·재직사 추정 기입)·운영자 이메일 자동 삽입 실사고 2건. "세션 제공 사실만 사용, 미확보는 placeholder + 1회 질문"이 검증된 대응.
- [사실] PIPA상 옵트아웃 동의는 무효(변리사 자문), PII는 3등급 체계(서비스 사용자=익명·집계만).
- 스킬 영향: templates/guardrails.md(INFRA-1)로 단일화. main에 이미 들어간 인라인 날조가드(#113, #121)와 중복 없이 참조로 수렴.

### 3-5. 교차 원칙 4가지 (검증에서 반복 확인)

1. **시점성 수치 하드코딩 금지** — 도입률·감점률·연봉 통계를 SKILL.md에 박으면 1~2년 내 그 자체가 "낡은 전제"가 된다. 수치는 rationale에만, 본문엔 "WebSearch로 당일 확인 + 출처·기준일 병기" 규칙.
2. **상태 어휘 통일** — tracker 한글 7상태 vs 제안된 영문 8상태 충돌. canonical 모델(INFRA-5, 저장=영문 키·표시=한글 라벨) 확정이 auto/retro/job-search 작업의 선행 조건.
3. **크로스 스킬 규칙은 배치 위치가 생명** — CLI 스킬 구조상 A스킬 프롬프트에 쓴 규칙은 B스킬 세션에 존재하지 않는다. 핸드오프 규칙은 산출 측 스킬에, 소비 규칙은 소비 측 스킬에.
4. **봇 경계 준수** — main의 새 lint 3종(test-preambles.sh, test-command-style.sh, test-no-home-paths.sh)이 게이트. 사용자 노출 명령은 언더스코어(`/cover_letter`), 본문 경로는 `$_JS_STATE`, `/tracker`·`/ncs` 추천 금지.

### 3-6. main 15커밋으로 이미 해결된 것 (재작업 금지)

프리앰블 문법 핫픽스 13/13 + test-preambles.sh 신설, auto 파일 미감지 날조가드(#113), company-research 출처 강제(#121)·스코어 결정성(#122), resume/cover-letter [추정] 표기·샘플 PII 경고(#130)·봇 docx 자동산출(#118b), 표기 lint 2종. → 원래 계획 중 3건 already_done 제거, 5건은 잔여 갭만 남김, 27건은 표기·정합 조정 완료.

---

## 4. 신규 스킬 결정

3개 관점(지식 커버리지/사용자 여정/시장 벤치마킹) 생성 → 심사 → 적대적 검증 → 2차 심사(근거 원본 확인)를 거친 최종 로스터:

| 결정 | 스킬 | tier | 착수 | 근거 요약 |
|---|---|---|---|---|
| ✅ 신설 | **experience-bank** (경험 뱅크) | 2 | M3 (P0) | 유일하게 2개 관점에서 독립 도출. 방법론 전체가 내부 자산. strategy(진단)와 문서 스킬(출력) 사이의 "입력 자산" 공백. 소비 배선을 MVP에 포함하는 조건부 |
| ✅ 신설 | **career-history** (경력기술서) | 3 | M4 (P1) | [사실] 실사용 수요 1위(77건)인데 resume에 경력기술서 0건 — 자체 데이터로 실증. 3문서(이력서-경력기술서-자소서) 역할 혼란도 반복 관측 |
| ✅ 신설 | **scout-profile** (스카우트 프로필) | 3 | M5 (P2) | 다이렉트소싱 시대 "발견되는 채널" 공백. 스코프 3개로 축소(진단·리라이팅·가드레일), 정합성 대조는 review로 이관, "검색 노출 보장" 표현 금지 |
| 🔀 병합 | humanize | — | M1+M4 | 진단 5종 중 4종이 cover-letter에 기존재 → templates/humanize-check.md(INFRA-3) + cover-letter/review 업그레이드로 |
| 🔀 병합 | followup-defense | — | M4 | 미끼 인벤토리가 이미 3곳에 존재 → review Phase 4 심화 + defense-map 데이터 계약(INFRA-9) + mock-interview 소비로 |
| 🔀 병합 | doc-export | — | M1 | 유틸리티는 bin/ 관례 → bin/jobstack-export(INFRA-6) + review 파일화 단계로 |

**기각 10건** (사유 보존 — 부록 B): job-fit, assessment-prep, coding-test, ai-assessment, offer-compare, job-mbti, onboarding, profile-optimize(병합), interview-followup(근거 오독 판명 — 원본 확인 결과 다른 주제), aptitude-test(자산 부재 일관 기각).

기각 원칙(2차 심사에서 확립): **"갭 존재 ≠ 스킬 신설"** — 근거 자산의 원본 확인을 통과하고, 축적 자산이 실재하는 후보만 신설한다. 웹 통계만 있는 시험 대비류는 ETHOS(설득 문서 철학)와 접점이 없어 일관 기각.

---

## 5. 마일스톤 로드맵

의존 관계: 인프라(M1) → P0(M2) → 신규 스킬·P1(M3·M4) → P2(M5) → 품질 게이트(M6). 마일스톤마다 feature 브랜치 + PR + lint 3종 통과를 게이트로 한다.

| 마일스톤 | 내용 | 규모 | 추정 |
|---|---|---|---|
| **M1 공유 인프라** | INFRA-1(guardrails)·2(experience-methods)·4(preamble 템플릿 역반영)·5(tracker 상태 모델)·6(jobstack-export) [P0] + INFRA-3(humanize-check)·7(컨벤션 린트)·9(defense-map)·10(텔레메트리) [P1] + 오너 결정 7건 ✅확정(Council #1) | 인프라 9건 | 1.5~2일 |
| **M2 P0 웨이브** | 13개 스킬의 P0 28건 — 날조·PII 가드레일 연결, 낡은 전제 교정(공채·ATS·검색 소스), 점수 산출 게이트, 한계 노출→자료 요청 전환 | 28건 (S 위주) | 1.5~2일 |
| **M3 experience-bank** | 신규 스킬 v0.1.0 + 소비 배선(resume/cover-letter/mock-interview benefits-from + cover-letter Phase 2 카드 우선 제시) + test-preambles.sh SKILLS 목록 갱신 | 신규 1 + 배선 | 0.5~1일 |
| **M4 P1 웨이브 + career-history** | 스킬 P1 52건(defense-map 산출·소비, 2차 점검 루프, 중고신입 트랙, 모드 확장 등) + career-history v0.1.0 + templates/three-docs-guide.md | 52건 + 신규 1 | 2.5~3일 |
| **M5 P2 웨이브 + scout-profile** | 스킬 P2 46건(텔레메트리 이벤트, 직군 분기, 법제도 안내 등) + scout-profile v0.1.0 | 46건 + 신규 1 | 1.5~2일 |
| **M6 품질 게이트·릴리스** | INFRA-8 골든 테스트(우선 5스킬) + E2E 체크리스트 갱신 + CHANGELOG·VERSION·install.sh 심링크·CLAUDE.md tier 표(13→16개) 갱신 | 마감 | 1일 |

> **주의**: 원래 "즉시 핫픽스"였던 프리앰블 bash 문법 오류는 main에서 이미 수정 완료(13/13 PASS). M1의 INFRA-4는 templates/preamble.md 역반영 + run-integration-test.sh 연결의 잔여분만.

---

## 6. 오너 결정 사항 — ✅ Council #1로 전건 확정 (2026-07-03)

4자 협의체(Claude + codex + grok + antigravity)가 토론·투표로 확정했다. 안건·투표 원문: `jobclaw/.agentea/council_1*.md`.

| # | 안건 | 확정 | 표결 | 근거 요약 |
|---|---|---|---|---|
| 1 | tracker `watching` 상태 | **미포함 (9상태)** | 3:1 | watching은 파이프라인 상태가 아닌 북마크 개념 — canonical은 최소로 고정. 관심 공고는 v0.3+에서 job-search 북마크 축으로 분리 설계 (Claude가 소수의견 A에서 승복) |
| 2 | `preparing` 유지 | **유지** | 4:0 | 실데이터에 '준비중' 실존 — 데이터 안전 1순위. jobclaw 동기화 시 preparing→applied 단방향 매핑 |
| 3 | applications.jsonl 마이그레이션 | **읽기 정규화 + 최초 실행 시 .bak 백업·사용자 승인 후 재작성 제안** | 4:0 | 무단 변경 없이 파일 단일화 |
| 4 | `withdrawn` 한글 라벨 | **"지원취소"** | 4:0 | 행위 중립·직관적. "중도포기"는 낙인 뉘앙스 |
| 5 | ats-reference.docx 폰트 | **Noto Sans KR 지정** | 4:0 | jobclaw 컨테이너 렌더링 일관성 — 폰트 설치 스텝 추가, 로컬 미설치 시 시스템 폰트 폴백 |
| 6 | 린트 수치 검사 기본 모드 | **strict fail 기본 (--warn 완화 옵션)** | 4:0 | 드리프트 원천 차단이 규칙의 목적 — 오탐은 lint-allowlist.txt로 관리 |
| 7 | 텔레메트리 동의 | **CLI 로컬 무고지 + jobclaw 배포 시 consent_type 전제** | 3:1 | 로컬 파일은 PIPA 비대상, 옵트인은 퍼널 표본 붕괴. codex 소수의견(옵트인) 반영해 README에 로컬 기록 사실 1줄 고지 추가 |

**결정 여파 (착수 시 반영)**:

- **TRK-2**: watching 상태 전제 삭제 — v0.3+ 백로그로 이동, job-search 북마크 축으로 분리 설계
- **INFRA-5**: canonical 9상태 확정 — preparing / applied / document_pass / interview_1 / interview_2 / final / offer | rejected / withdrawn("지원취소"). preparing→applied 동기화 매핑 명시
- **INFRA-6**: templates/export/ats-reference.docx에 Noto Sans KR 지정 + jobclaw 컨테이너 폰트 설치 스텝 + 폴백 문구
- **INFRA-7**: lint-conventions.sh 수치 검사 기본 fail, `--warn` 옵션, lint-allowlist.txt
- **INFRA-10**: telemetry-events.md에 "CLI 로컬 한정·전송 없음" 명시 + README 고지 1줄 + jobclaw 배포 시 consent_type 필수 전제

**→ 선행 결정이 모두 확정되어 M1 즉시 착수 가능.**

---

## 7. 리스크와 완화

| 리스크 | 완화 |
|---|---|
| 시점성 수치 드리프트 — 통계를 본문에 박으면 1~2년 내 낡음 | 교차 원칙 1 전면 적용 + INFRA-7 린트의 수치 하드코딩 검사 |
| 품질 게이트 없는 대량 수정 — 프리앰블 회귀 전례 있음 | main의 lint 3종을 모든 PR 게이트로 + 마일스톤 단위 분할 + M6 골든 테스트 |
| 스킬 수 팽창(13→16)으로 라우팅 혼선 | 신규 3개 모두 description에 경계 명시(라우팅 문구 검증 완료) + auto 라우팅 예외 규칙(AUTO-5) |
| PII 유출 — 실사용 덤프·실명 폴더의 스킬 예시 유입 | 채굴 단계부터 익명·집계만 사용(적용됨) + INFRA-1 PII 3등급 |
| 기각 스킬 재논쟁 | 기각 10건 사유를 본 문서 부록 B에 보존 |
| 봇/CLI 이중 경로 분열(docx 산출 등) | 환경 분기 규칙(봇=#118b render-docx.sh, CLI=jobstack-export)으로 단일 지점 통합 |

---

## 8. 실행 방식

- **브랜치**: 마일스톤당 `feat/upgrade-m1-infra` 형식 feature 브랜치 → PR → 머지. P0 웨이브는 스킬 3~4개 단위로 PR 분할.
- **게이트**: 모든 PR에서 `test/test-preambles.sh`, `test/test-command-style.sh`, `test/test-no-home-paths.sh` + (M1 이후) `test/lint-conventions.sh` 통과.
- **표기 규칙**: 사용자 노출 명령 언더스코어(`/cover_letter`), 본문 경로 `$_JS_STATE`, `/tracker`·`/ncs` 추천 금지(봇 미노출), AI 만능 표현 금지.
- **버전**: 스킬별 semver bump(부록 C의 target_version) + VERSION·CHANGELOG는 마일스톤 단위 갱신.
- **검증**: 부록 C의 항목별 acceptance를 PR 설명에 체크리스트로 복사해 사용.

---

# 부록 A. 공유 인프라 스펙 (10건)

## INFRA-1 · templates/guardrails.md 신설 — 공유 가드레일 템플릿  `[P0/S]`
**소비 스킬**: auto, strategy, tracker, company-research, portfolio, job-search, ncs, salary, retro, resume, cover-letter, mock-interview, review

파일: /Users/teasunkim/work/jobstack/templates/guardrails.md. 섹션 6개: ①사실 날조·PII 자동 채우기 금지 — 세션 제공 사실만 사용, 미확보 정보는 placeholder("[이메일 입력 필요]")+해당 항목 1회만 질문(jobclaw 실사고 2건: JLPT/재직사 날조, 운영자 이메일 삽입) ②한계 노출 금지→자료 요청 전환 — "네트워크 차단" 대신 "공고 본문·인재상 페이지를 붙여주세요" 전환 예시표 ③시장 수치 하드코딩 금지 — 시점성 수치(도입률·감점률·평균연봉 등)는 SKILL.md에 박지 말고 WebSearch로 당일 확인, 인용 시 출처+기준일 병기, 미확보 시 "(출처 미확보)" ④KST 날짜 확인 — 마감일·D-day 계산 전 `date` 로 오늘(KST) 확정, 마감 지난 공고 제시 절대 금지 ⑤훈련데이터 시간민감 정보 금지 — 공고·연봉·채용일정은 실시간 조회값만 단정 ⑥금지 표현 — 합격 보장/무조건 통과/전문가가 직접 첨삭/AI 대체 불가(→"대체 압력 낮다") + AI 만능 표현(다각적·포괄적·심층적·혁신적·체계적). 참조 방식: 각 SKILL.md 프롬프트 서두에 "작업 시작 전 ${CLAUDE_SKILL_DIR}/../templates/guardrails.md 를 Read하고 전 규칙을 준수하라" 1줄 추가(bin/jobstack-view와 동일한 상대경로 관례, 심링크 경유 동작 확인됨). gen-skill-docs.sh에 GUARDRAILS=$(cat ...) + {{GUARDRAILS}} 치환 추가(향후 tmpl 전환 대비).

> ⚠️ **main 재조정 (partially_done)**: templates/guardrails.md 미생성. 단 규칙 일부가 main 300a2aa/d6c7da4로 인라인 선반영: auto #113(미감지 날조 금지), company-research #121(출처강제·(출처 미확보)), cover-letter/resume [추정] 표기·Phase 6 날조 금지·#130 샘플 PII 경고. 템플릿 신설 시 이 인라인 블록들과 중복 없이 참조로 수렴하고, 본문 lint는 신설된 test-no-home-paths.sh·test-command-style.sh도 통과해야 함.

**완료 판정:**
- templates/guardrails.md 존재, 6개 섹션 헤더 모두 포함
- 13개 SKILL.md 전부에 guardrails.md Read 지시 1줄 존재 (grep 'templates/guardrails.md' 13건)
- 본문 자체가 INFRA-7 린트 통과 (금지 표현은 인용 예시로만, 린트 allowlist 처리)
- gen-skill-docs.sh에 {{GUARDRAILS}} 치환 로직 추가

## INFRA-2 · templates/experience-methods.md 신설 — 경험 소재화 공유 방법론  `[P0/M]`
**소비 스킬**: resume, cover-letter, portfolio, review, mock-interview, ncs, retro

파일: /Users/teasunkim/work/jobstack/templates/experience-methods.md. 섹션 6개(지식 다이제스트 §1·§4 원문 이식): ①경험 전환 6단계 — 이름→문제→역할→바꾼 행동→검증가능 변화→직무 연결 ②문제·역할·행동·결과 4분리 원칙(피할 표현 5종: 다양한 경험/책임감을 가지고/소통 능력/많은 것을 배움/팀에 기여 포함) ③수치 폴백 5기준 — 전후 변화/역할 범위 분리/정성 근거(피드백·계속 쓰인 양식)/작은 검증가능 숫자(예: 3주 12건 문의 유형 정리)/면접 설명 가능성 + 수치 대체 4종(범위·빈도·전후비교·담당규모) ④추상어→질문 전환표 — 책임감→끝까지 맡은 일? / 소통→누구의 이해차를 줄였나? / 꼼꼼함→어떤 오류·누락을 줄였나? / 문제해결력→문제를 어떻게 정의했나? / 성장→무엇이 달라졌나? ⑤약한 문장 5유형+보강 — 좋아합니다→행동 사례 / 열심히→역할 구체화 / 성장→전후 비교 / 소통→차이 조율 유형(전달·정리·설득·조정) / 책임감→범위+처리 기준 ⑥어조 전환 3공식 — 희망→실행 / 감정→행동 / 과정→결과(350ms→15ms). 형식: 표 중심, 각 섹션에 적용 시점 명시(초안/첨삭/면접대비). 참조 방식: INFRA-1과 동일 — 소비 스킬 SKILL.md의 해당 Phase에 "${CLAUDE_SKILL_DIR}/../templates/experience-methods.md 의 §N을 적용하라" 형태로 섹션 단위 인용. ETHOS.md의 어조 전환 공식과 문구 일치 유지(중복 정의 금지, ETHOS는 철학·본 템플릿은 실행 절차).

**완료 판정:**
- 6개 섹션 전부 존재하고 표 형식으로 즉시 적용 가능
- resume/cover-letter/portfolio/review/mock-interview SKILL.md에서 최소 1회 이상 참조
- ETHOS.md 어조 전환 공식과 문구 충돌 없음
- INFRA-7 린트 통과

## INFRA-3 · templates/humanize-check.md 신설 — AI스러움 진단·인간화 공유 모듈  `[P1/S]`
**소비 스킬**: cover-letter, review, resume

파일: /Users/teasunkim/work/jobstack/templates/humanize-check.md. 배경: cover-letter와 review에 치환 테스트가 각각 별도 정의된 3중 중복을 단일 소스로 통합. 섹션 3개: ①치환 테스트 2종 — (a)회사명 치환: 회사명을 경쟁사로 바꿔도 성립하면 실패, (b)타 지원자 치환: 지원자 이름을 바꿔도 성립하면 실패. 각각 판정 기준+실패 시 처방(기업 키워드/개인 경험 근거 주입) ②AI풍 신호 진단 5종 — (a)AI 만능 표현(다각적·포괄적·심층적·혁신적·체계적) (b)근거 없는 일반문장("급변하는 시대에") (c)수치 없는 성과 서술 (d)접속어 과다(그리고·또한·이를 통해·그 결과 2개↑ 연속) (e)모든 문항 동일 문체·문단 구조. 각 신호별 grep 가능한 패턴 예시 포함 ③날조 금지 리라이팅 절차 — 진단→해당 문장에 필요한 실제 경험을 질문으로 요청→사용자 답변 기반으로만 재작성→재진단(없는 사실 생성 절대 금지, INFRA-1 §1 준수 명시). 부록: AI 탐지 리스크 고지 문구(적발 시 감점+불합격 65.4% 불이익 — 단, 이 수치는 출처·기준일 병기 예시로만 수록). 참조 방식: cover-letter Phase(첨삭 마지막 단계)·review·resume SKILL.md에서 런타임 Read 지시. 기존 두 스킬의 자체 정의 문단은 이 템플릿 참조 1줄로 교체(중복 제거).

**완료 판정:**
- 3개 섹션+판정 기준 존재
- cover-letter/review의 기존 자체 정의가 템플릿 참조로 교체되어 중복 0건
- 리라이팅 절차에 '사용자 답변 기반으로만 재작성' 명시 (guardrails §1 링크)
- INFRA-7 린트 통과

## INFRA-4 · templates/preamble.md 신 패턴 역반영 + 문법 오류 핫픽스 + test/test-preambles.sh 신설  `[P0/M]`
**소비 스킬**: auto, strategy, tracker, company-research, portfolio, job-search, ncs, salary, retro, resume, cover-letter, mock-interview, review

즉시 핫픽스 포함(P0 최우선). 현황: 최신 커밋(eea3c6c)이 4개 스킬(auto/cover-letter/mock-interview/review)에 넣은 stale PID 루프 `for _f in "$_JS_STATE/sessions/"* 2>/dev/null; do` 는 bash 문법 오류(bash -n으로 확인, 스킬 실행 차단 수준). templates/preamble.md는 trap EXIT/stale 정리 미반영 구버전. 작업: ①canonical 패턴 확정 — trap 'rm -f "$_JS_STATE/sessions/$$"' EXIT + stale 루프를 `for _f in "$_JS_STATE/sessions/"*; do [ -f "$_f" ] || continue; kill -0 "$(basename "$_f")" 2>/dev/null || rm -f "$_f"; done` 로 수정(리다이렉트를 for 리스트에서 제거) ②3변수 불변식 명시: ACTIVE_SESSIONS/PROACTIVE/SKILL_NAME 3개 echo 필수(2026-05-25 결정기록, PR#4 회귀 이력). SKILL_NAME은 최신 관례대로 리터럴 하드코딩, 템플릿에는 `__SKILL_NAME__` 플레이스홀더+주석 ③mkdir 6개 디렉토리(analytics/profiles/tracker/company-cache/interview-history/sessions) 유지, JOBSTACK_STATE_DIR fallback 유지(jobclaw per-user 격리 의존) ④templates/preamble.md 갱신 후 13개 SKILL.md 프리앰블 블록 전부 canonical로 재동기화 ⑤test/test-preambles.sh 신설: 스킬별로 (a)bash -n 문법 검사 (b)3변수 echo 존재 (c)trap EXIT 존재 (d)stale PID 루프 존재 (e)6개 mkdir (f)JOBSTACK_STATE_DIR fallback — 6항목 grep 검증, 실패 시 exit 1. run-integration-test.sh에서 호출.

> ⚠️ **main 재조정 (partially_done)**: 완료분: 13개 SKILL.md 문법 핫픽스+trap EXIT+stale 루프 수정(main), test/test-preambles.sh 신설·13/13 PASS(3변수+세션 정리 실행 검증). 잔여: templates/preamble.md는 여전히 trap/stale 루프 미반영 구버전(grep 확인), run-integration-test.sh가 test-preambles.sh를 호출하지 않음, 스펙의 grep 6항목(6 mkdir·STATE_DIR fallback) 검증 미포함.

**완료 판정:**
- 13개 SKILL.md 프리앰블 전부 bash -n 통과 (현재 4개 실패)
- templates/preamble.md에 trap EXIT + 수정된 stale PID 루프 + 3변수 반영
- test/test-preambles.sh 존재, 13개 스킬 x 6항목 전부 PASS
- run-integration-test.sh가 test-preambles.sh를 호출

## INFRA-5 · tracker canonical 상태 모델 확정 + 마이그레이션 규칙  `[P0/M]`
**소비 스킬**: tracker, retro, auto, strategy, job-search

파일: tracker/SKILL.md 상태 정의 섹션 개정 + docs/tracker-states.md(단일 정의 문서) 신설. 충돌 해소 결정안: 저장은 영문 키, 표시는 한글 라벨. canonical 상태(파이프라인 7+종결 2=9): preparing(준비중)→applied(지원완료·서류전형중)→document_pass(서류합격)→interview_1(1차면접)→interview_2(2차면접)→final(최종면접)→offer(최종합격) | rejected(불합격), withdrawn(지원취소). final/offer 중복 해소: final=최종'면접 단계', offer=최종'합격 결과'로 의미 분리 — 기존 한글 '최종합격'은 offer로 매핑, '서류전형'은 applied로 매핑, 최종면접·지원취소는 신규 한글 라벨. watching(관심 공고)은 10번째 상태로 추가 가능하나 오너 결정 사항(decisions_needed). 매핑표를 docs/tracker-states.md에 단일 정의하고 tracker/retro/auto SKILL.md는 이 문서를 참조. 마이그레이션: ~/.jobstack/tracker/applications.jsonl 은 한글 status 문자열 저장 중 → (a)읽기 시 정규화: 한글 값이면 매핑표로 영문 변환(하위호환, 구버전 파일 그대로 동작) (b)쓰기 시 항상 영문 키+schema_version:2 필드 추가 (c)tracker 스킬 최초 실행 시 v1 라인 발견하면 일괄 재작성 제안(원본 .bak 백업). 넛지 규칙: applied 7일+ 정체 시 리마인더(jobclaw 검증 설계) — retro 퍼널 분석이 이 영문 키를 집계 기준으로 사용.

> ⚠️ **main 재조정 (needs_adjust)**: 상태 모델 미착수(applications.jsonl 예시 여전히 한글 '서류전형') — 작업 유효. 단 전제 변경: 봇에서 지원현황 관리 주체가 네이티브 /track·/myapps로 일원화(retro·job-search 문구 교체됨, tracker 스킬은 CLI 잔존). canonical 상태 어휘는 봇 네이티브 명령 측과의 정합·소비자 문구의 /tracker 추천 금지를 스펙에 반영.

**완료 판정:**
- docs/tracker-states.md에 9(+1)개 상태 x (영문 키·한글 라벨·진입/이탈 조건) 매핑표 존재
- tracker/SKILL.md의 선택지·목록·통계 예시가 전부 새 모델과 일치
- 한글 status가 든 기존 applications.jsonl을 읽어도 오류 없이 정규화 (하위호환 시나리오 골든 테스트)
- 신규 기록은 영문 status+schema_version:2로 저장

## INFRA-6 · bin/jobstack-export — md→docx 변환 유틸 (ATS-safe)  `[P0/M]`
**소비 스킬**: resume, cover-letter, review, portfolio, mock-interview, ncs

파일: /Users/teasunkim/work/jobstack/bin/jobstack-export (bash, +x) + templates/export/ats-reference.docx (pandoc 레퍼런스 문서 1종, 커밋 포함). 근거: 파일 산출 실수요 4위 56건·포맷 요청 37건, '파일 변환 도구 없음' 사과 2건 — resume Phase 10·review Phase 7의 전제. 사용법: `jobstack-export <in.md> [out.docx]`. 동작: ①pandoc 존재 확인(command -v) ②있으면 `pandoc in.md -o out.docx --reference-doc=$SCRIPT_DIR/../templates/export/ats-reference.docx` 실행, 성공 시 절대경로 출력 ③없으면 exit 2 + stderr에 폴백 안내("pandoc 미설치 — brew install pandoc 후 재시도하거나, 아래 마크다운을 문서 앱에 복사해 저장하세요") — 호출 스킬은 exit 2를 받으면 md 원문 복붙 폴백으로 전환. ATS-safe 레퍼런스 스타일: 표·이미지·텍스트박스 없음, 표준 제목 스타일(Heading1/2), 본문 11pt 단일 컬럼, 한글 폰트는 시스템 기본(맑은고딕/AppleGothic 계열) — 파싱 4단계(수집→파싱→키워드→순위화) 통과 최적화. 참조 방식: 스킬에서 `"${CLAUDE_SKILL_DIR}/../bin/jobstack-export" 결과.md` 호출(jobstack-config와 동일 관례). 산출 파일은 작업 디렉토리에 두고 SendUserFile/경로 안내. pdf는 스코프 외(추후 weasyprint, 한글 폰트 이슈 별도).

> ⚠️ **main 재조정 (needs_adjust)**: bin/jobstack-export 미생성(작업 자체는 잔존). 단 main d6c7da4(#118b)가 resume/cover-letter에 봇 File output protocol([OUTPUT_FILE:]+render-docx.sh) 기반 .docx 자동산출을 도입 — 스킬 호출 지시는 환경 분기(봇=#118b 블록 유지, CLI=jobstack-export)로 기존 블록과 이중 지시 없이 통합해야. acceptance의 'resume/cover-letter/review 호출 지시' 항목 재정의 필요.

**완료 판정:**
- sample-data/이력서_홍길동.md → docx 변환 성공, Word/Pages에서 열림
- pandoc 미설치 환경(PATH 조작 테스트)에서 exit 2 + 복붙 안내 출력
- 생성 docx에 표·이미지 0개 (ATS-safe 검증: unzip 후 document.xml에 <w:tbl> 부재)
- resume/cover-letter/review SKILL.md에 파일화 단계로 호출 지시 존재

## INFRA-7 · test/lint-conventions.sh — 컨벤션 린트 스크립트  `[P1/S]`
**소비 스킬**: 전체 SKILL.md 품질 게이트, INFRA-1, INFRA-2, INFRA-3

파일: /Users/teasunkim/work/jobstack/test/lint-conventions.sh (+x) + test/lint-allowlist.txt (예외 목록: 파일:라인패턴 형식). 검사 대상: */SKILL.md + templates/*.md + ETHOS.md + CLAUDE.md. 검사 3종: ①AI 만능 표현 — grep -nE '다각적|포괄적|심층적|혁신적|체계적' (CLAUDE.md 컨벤션의 금지 5어) ②금지 표현 — '합격 보장|무조건 통과|전문가가 직접 첨삭|AI 대체 불가' ③시장 수치 하드코딩 휴리스틱 — SKILL.md 본문에서 `[0-9]+(\.[0-9]+)?%` 또는 `[0-9,]+만원` 매칭 라인 중 같은 라인에 '출처'·'기준'·'WebSearch'·'예:' 가 없는 경우 경고(guardrails §3의 '출처+기준일 병기' 규칙 집행). 출력: 파일:라인:유형:매칭문자열, allowlist 매칭 라인은 스킵(금지 표현을 '금지'로 인용하는 guardrails/humanize-check 자체가 대표 예외). 위반 1건 이상이면 exit 1. run-integration-test.sh 인프라 섹션에서 호출 + 대량 SKILL.md 수정 작업의 커밋 전 게이트로 사용(100건+ 업그레이드 시 위반 유입 방지 목적). ①②는 하드 fail, ③은 기본 warn(--strict 플래그로 fail 승격) — 오탐 관리.

**완료 판정:**
- 현재 repo 전체를 스캔해 결과가 결정적으로 재현됨 (동일 입력→동일 출력)
- 금지 표현이 든 테스트 픽스처에 대해 exit 1
- guardrails.md/humanize-check.md의 인용부가 allowlist로 통과
- run-integration-test.sh에 통합

## INFRA-8 · 골든 테스트 케이스 + E2E 체크리스트 갱신  `[P2/L]`
**소비 스킬**: resume, cover-letter, review, tracker, job-search, 전 스킬 회귀 기준선

구조: test/golden/<skill>/<case>/ 디렉토리(1스킬 1케이스 이상, 우선순위: resume/cover-letter/review/tracker/job-search 5종 먼저). 각 케이스: input/ (기존 test/sample-data 3종 재사용+공고 텍스트), expected-traits.yaml — LLM 산출물이라 exact match 불가하므로 특성(trait) 기반 판정: {must_contain: [섹션명·키워드 목록], must_not_contain: [AI 만능 표현, 금지 표현, 날조 신호(입력에 없는 자격증명 등)], structure: [결이요 순서(결론 선행), 문단당 키워드 1개, 수치 병기 여부], format: [모바일 프로토콜(표 금지) 또는 파일 산출 여부]}. 판정 스크립트: test/run-golden.sh — 산출 md를 받아 traits를 grep/구조 검사(①②는 자동, structure는 체크리스트 출력으로 반수동). tracker 케이스는 결정적: 한글 status v1 jsonl 입력→영문 정규화 출력 비교(INFRA-5 하위호환 검증). E2E 체크리스트: docs/E2E-CHECKLIST.md 갱신 — 기존 docs/E2E-TEST-REPORT.md의 파이프라인 체인(기업분석→이력서→자소서→면접 변환 추적)을 단계별 체크 항목으로 재구성 + 신규 인프라 항목(guardrails Read 수행, 프리앰블 3변수 출력, export 파일 생성, defense-map 산출) 추가. 목적: 업그레이드 전/후 동일 입력 비교 프로토콜의 기준선.

**완료 판정:**
- test/golden/에 5개 스킬 케이스 존재, 각각 input+expected-traits.yaml 완비
- run-golden.sh가 must_contain/must_not_contain을 자동 판정
- tracker 케이스는 완전 자동(결정적) PASS
- docs/E2E-CHECKLIST.md에 신규 인프라 4항목 반영

## INFRA-9 · defense-map 데이터 계약 — 문장↔꼬리질문 맵 YAML 스키마  `[P1/M]`
**소비 스킬**: cover-letter(산출), review(산출), mock-interview(소비), retro(방어 준비율 집계, 선택)

저장: ~/.jobstack/defense-maps/<회사명>_<직무>_<YYYYMMDD>.yaml (회사명·직무는 공백→하이픈 정규화). 스키마 정의 문서: docs/defense-map-schema.md + templates/defense-map-example.yaml. 필드: schema_version(1), source_skill(cover-letter|review), created_at(KST ISO), company, position, document_ref(원문 파일 경로 또는 문항 식별), entries[] — 각 entry: {id(dm-001…), sentence(미끼 문장 원문), location(문항 번호·단락), bait_type(수치|기술선택|역할범위|성과|갈등·판단 중 1), questions[](2개 이상) — {q(예상 꼬리질문), intent(검증 의도), difficulty(mild|normal|hard)}, answer_hint(1분 답변 골자, 사용자 확인 전이면 null), defense_status(ready|weak|unprepared)}. 산출 규칙: cover-letter는 미끼 5개 배치 원칙에 따라 entries≥5, review는 자소서 15+공고 10 예상질문을 entry로 귀속(통합 32개 정합). 소비 규칙: mock-interview가 개인화 질문 소스로 사용 — 회사명 느슨 매칭(공백 제거+소문자 부분일치, jobclaw interview-context.ts 패턴), 최신 파일 1개 선택, 주입 상한 1500자, defense_status=weak|unprepared 항목 우선 출제, 면접 종료 후 defense_status 갱신(양방향). 파일 부재 시 프리셋 질문 폴백(계약 위반 아님). 스킬 참조: 3개 SKILL.md에 스키마 문서 Read 지시+산출/소비 Phase 명기.

> ⚠️ **main 재조정 (needs_adjust)**: 스키마 작업 유효하나 SKILL.md 본문 경로 표기는 ~/.jobstack/defense-maps가 아닌 $_JS_STATE/defense-maps(test-no-home-paths.sh FAIL 회피). 또한 mock-interview가 main에서 '면접 답변은 자유서술, AskUserQuestion은 선택지형만'으로 개정 — 소비 Phase 명기 시 이 규칙과 정합.

**완료 판정:**
- docs/defense-map-schema.md + 예시 YAML 존재, 필드 전부 정의
- cover-letter/review 산출물이 스키마 그대로 ~/.jobstack/defense-maps/에 저장 (entries≥5)
- mock-interview가 예시 YAML을 읽어 꼬리질문 세션 구성 (E2E 체크리스트 항목)
- 파일 부재 시 프리셋 폴백 동작

## INFRA-10 · 텔레메트리 확장 — skill-usage.jsonl 후속 이벤트 규격  `[P1/S]`
**소비 스킬**: auto(detected), resume, cover-letter, review(퍼널 이벤트), retro(집계 소비), tracker

정의 문서: docs/telemetry-events.md. 현행: 프리앰블이 {skill, ts, pid}를 ~/.jobstack/analytics/skill-usage.jsonl에 자동 append(=entry 이벤트, event 필드 없음=v1 entry로 해석하는 하위호환 규칙). 확장: Claude가 스킬 진행 중 Bash로 append하는 후속 이벤트 — 공통 필드 {skill, ts(UTC ISO), pid($$로 entry와 세션 연결), event}. 이벤트 어휘 6종: ①entry(프리앰블 자동, event 필드 생략 허용) ②detected — Phase/단계 감지 완료 시: +phase(감지된 단계), +no_arg(true|false, no-arg 진입 별도 bucket 규칙), +mode(스킬별 세부 모드, 예: mock-interview 페르소나) ③submitted — 사용자 문서 제출 ④diagnosed — 1차 진단 완료 ⑤second_review — 2차 점검(재리뷰) 요청 ⑥exported — jobstack-export 파일 산출 성공. append 관례는 프리앰블과 동일: `echo '{...}' >> "$_JS_STATE/analytics/skill-usage.jsonl" 2>/dev/null || true` (실패 무해). PII 금지: 문서 내용·회사명·사용자 식별정보 기록 금지(3등급 PII 정책 — 이벤트 메타만). 소비: retro가 퍼널 2지표 산출 — 문서 제출률=submitted/entry, 2차 점검 요청률=second_review/diagnosed (1차 유입 캠페인 지표 정의와 일치). 스킬 참조: 각 SKILL.md의 해당 Phase 종료 지점에 append 지시 1줄. auto는 detected 필수(라우팅 결과 기록).

**완료 판정:**
- docs/telemetry-events.md에 6종 이벤트+필드+예시 JSONL 존재
- 기존 v1 라인(event 필드 없음)과 혼재해도 retro 집계가 동작 (하위호환)
- auto/cover-letter/review에 detected/submitted/diagnosed/second_review append 지시 반영
- 이벤트에 회사명·문서 내용 등 PII 필드 없음 (스키마 검사)

---

# 부록 B. 신규 스킬 스펙

## experience-bank (tier 2, P0)

**description 초안**: 경험 소재 발굴·카드화 스킬. 대화형 인터뷰로 학업/프로젝트/알바/대외활동 경험을 '경험 전환 6단계'와 문제·역할·행동·결과 4분리로 카드화하고, 수치 폴백 5기준과 추상어→질문 전환표로 약한 소재를 보강해 ~/.jobstack/profiles/experiences.yaml에 저장한다. "경험 정리해줘", "자소서 소재 발굴", "내 경험 뭐 쓰지" 요청 시 활용. 경계: 문서 작성 자체는 resume/cover-letter/career-history, NCS 능력단위 매핑은 ncs 담당 — 이 스킬은 일반 직무 연결 태그까지만 붙인다.

**benefits-from**: strategy

**Phase 골격**:

Phase 0: 모드 선택 (A 신규 카드 추가 / B 기존 카드 조회·보강 / C 뱅크 목록·커버리지) — AskUserQuestion 규칙 준수. Phase 1: 인벤토리 스캔 — default.yaml의 experience 항목과 기존 experiences.yaml 로드, 카드화 후보 경험 나열. Phase 2: 카드 인터뷰 — 경험 1건씩 templates/experience-methods.md(INFRA-2)의 전환 6단계(이름→문제→역할→바꾼 행동→검증 가능한 변화→직무 연결)와 4분리 질문으로 구조화. Phase 3: 수치 보강 — 수치 폴백 5기준(범위·빈도·전후비교·담당규모·면접 설명 가능성) 적용, 추상어→질문 전환표 재질문, 피해야 할 표현 5종 감지. 수치 부재 시 날조 금지(placeholder+1회 질문). Phase 4: 저장 — experiences.yaml에 카드 append, 직무 연결 태그 부여. Phase 5: 뱅크 요약 — 카드 목록·직무별 부족 영역 출력, 다음 추천(/resume, /cover-letter, /career-history).

**저장**: ~/.jobstack/profiles/experiences.yaml — append형 카드 배열(id, title, problem, role, action, change(before→after), numbers, job_link_tags, created_at). default.yaml과의 관계를 SKILL.md에 한 줄 문서화: 프로필(default.yaml)=정적 속성, 경험뱅크(experiences.yaml)=append형 카드. 기존 프리앰블의 profiles/ 자동 로딩 관례와 동일 패턴으로 존재 여부를 프리앰블에서 echo.

**소비 배선**: 소비(MVP 포함): resume/cover-letter/mock-interview frontmatter에 benefits-from: [experience-bank] 추가 + cover-letter Phase 2(소재 발굴) 앞에 'experiences.yaml 존재 시 저장 카드를 먼저 제시하고 부족분만 질문' 단락 삽입. 방법론(전환 6단계·수치 폴백 5기준·전환표)은 INFRA-2 templates/experience-methods.md 단일 소스로 두고 cover-letter Phase 2/Phase 6이 참조해 이중 인코딩 방지. ncs Phase 4는 이 카드를 입력으로 NCS 능력단위 매핑을 이어받는다. career-history Phase 2도 카드를 우선 제시.

**MVP(v0.1.0)**: v0.1.0: ①카드 인터뷰(전환 6단계+4분리) ②수치 폴백 5기준·추상어→질문 전환표·피해야 할 표현 5종 감지 ③experiences.yaml append 저장과 목록/조회 ④최소 소비 배선 — 3개 스킬 benefits-from 선언 + cover-letter Phase 2 카드 우선 제시 단락(이것 없이는 출시 가치가 0에 수렴한다는 검증 결론 반영). 제외: 직무별 태그 자동 분류 고도화, resume/mock-interview 본문 내 소비 로직(선언만), NCS 능력단위 매핑(ncs 담당).

> ⚠️ **main 재조정**: 충돌 없음, 단 3건 반영: ①storage 경로를 SKILL.md 본문에서 $_JS_STATE/profiles/experiences.yaml로 표기(test-no-home-paths.sh) ②프리앰블은 main 확정 수정본(trap EXIT+리다이렉트 없는 stale 루프) 채택 ③test-preambles.sh의 SKILLS 하드코딩 목록에 신 스킬 추가 필요(현재 13개 고정). 봇 노출 시 추천 표기는 언더스코어(/experience_bank).

**완료 판정:**
- 경험 1건 인터뷰 완료 시 experiences.yaml에 6단계 필드가 채워진 카드 1건이 append된다
- 수치 없는 경험 입력 시 폴백 5기준 질문이 제시되고, 사용자가 답하지 못하면 날조 없이 placeholder로 남긴다
- cover-letter 실행 시 experiences.yaml이 존재하면 저장 카드가 먼저 제시되고 부족분만 질문한다
- 전환 6단계·폴백 5기준 본문이 templates/experience-methods.md 한 곳에만 존재한다 (grep으로 중복 부재 확인)
- resume/cover-letter/mock-interview frontmatter에 experience-bank가 benefits-from으로 선언되어 있다
- 프리앰블이 표준 패턴(세션 추적, trap EXIT, SKILL_NAME=experience-bank, 텔레메트리)을 따른다

## career-history (tier 3, P1)

**description 초안**: 경력기술서 작성/첨삭 스킬. 프로젝트 단위 성과 서술(역할·기여도·before→after 수치), 중고신입/경력직 분기 템플릿, 이력서-경력기술서-자소서 3문서 역할 구분과 중복 제거 가이드. "경력기술서 써줘", "경력기술서 첨삭", "이력서랑 경력기술서 뭐가 달라" 요청 시 활용. 경계: 이력서 본문은 resume, 자소서 서사는 cover-letter, 플랫폼 프로필 텍스트는 scout-profile 담당 — 이 스킬은 프로젝트 상세 성과 문서만 다룬다.

**benefits-from**: strategy, company-research, experience-bank, resume

**Phase 골격**:

Phase 0: 모드 선택 (A 신규 작성 / B 첨삭 / C 3문서 역할 진단). Phase 1: 대상 분기 — 경력직 vs 중고신입 확인, 직무·연차 파악, default.yaml/experiences.yaml 로드. Phase 2: 프로젝트 인벤토리 — 프로젝트 단위로 역할·기여도·기간 정리, 팀 성과와 본인 기여 분리(experience-bank 카드 존재 시 우선 제시). Phase 3: 성과 서술 — before→after 수치화, 기능 서술→성과 서술 전환, 기술 키워드 배치(부하테스트·대용량 트래픽 등 도메인 질문으로 깊이 발굴). Phase 4: 3문서 정합 — templates/three-docs-guide.md의 역할 구분표(이력서=요약, 경력기술서=프로젝트 상세, 자소서=서사) 적용, 문서 간 중복 문장 제거. Phase 5: 첨삭 점검 — 5초 규칙 헤드라인, '바로 써보고 싶은 실무자' 포지셔닝, 미끼 포인트 표시. Phase 6: 저장·안내 — jobstack-view/jobstack-export 안내, 다음 추천(/review, /mock-interview).

**저장**: 산출물은 현재 디렉토리 markdown 파일(jobstack-view로 HTML/PDF, jobstack-export로 docx 안내). 신규 상태 파일 없음 — profiles/default.yaml과 experiences.yaml을 읽기 전용 소비. 3문서 역할 구분 가이드는 templates/three-docs-guide.md 공유 블록으로 두어 resume/cover-letter도 동일 소스를 참조.

**소비 배선**: benefits-from: [strategy, company-research, experience-bank, resume]. experience-bank 카드가 있으면 Phase 2 인벤토리에 우선 제시. resume/cover-letter는 templates/three-docs-guide.md를 공통 참조(3문서 혼란 반복 질문 해소). review의 서류 일관성 점검 대상에 '경력기술서' 유형 추가. Phase 5의 미끼 포인트는 INFRA-9 defense-map YAML 포맷으로 저장해 mock-interview가 질문 소스로 소비 가능.

**MVP(v0.1.0)**: v0.1.0: ①경력기술서 신규 작성+첨삭(프로젝트 단위 성과 서술, ETHOS 수치화·before→after 직접 이전) ②3문서 역할 구분·중복 제거 가이드(templates/three-docs-guide.md 공유 블록) ③중고신입/경력직 분기 템플릿. 제외: 채용공고 키워드 자동 매핑(v0.2), 기술 도메인별 심화 예시 라이브러리 — 카프카·부하테스트 등(v0.2, 실사용 수요 확인됨), docx 직접 생성(bin/jobstack-export 안내로 대체).

> ⚠️ **main 재조정**: 충돌 없음, 동일 3건: 프리앰블 canonical(main 수정본), test-preambles.sh SKILLS 목록 추가, 사용자 노출 추천 표기는 하이픈 금지 원칙상 /career_history(BOT-COMMAND-STYLE 확장 + test-command-style.sh CMDS 목록 갱신 검토). defense-map 저장 경로도 $_JS_STATE 표기.

**완료 판정:**
- 경력직 입력 시 프로젝트 단위 역할·기여도·before→after 수치가 포함된 경력기술서 초안이 생성된다
- 중고신입 선택 시 짧은 경력 프레이밍용 분기 템플릿이 적용된다
- '이력서와 경력기술서 차이' 질문에 3문서 역할 구분표가 출력되고, 해당 가이드가 templates/three-docs-guide.md 단일 소스로 존재한다
- 수치 없는 성과는 날조 없이 사용자 질문으로 발굴하거나 placeholder 처리한다
- 완료 상태(DONE/DONE_WITH_CONCERNS/NEEDS_CONTEXT)와 결과물 뷰어 안내가 기존 tier-3 관례를 따른다

## scout-profile (tier 3, P2)

**description 초안**: 스카우트 프로필 첨삭 스킬. 링크드인/원티드/리멤버 프로필 텍스트를 헤드라인 5초 규칙, 리크루터 검색 키워드 배치 휴리스틱, 기능 서술→성과 서술 전환 기준으로 진단하고 before→after 리라이팅한다(날조 금지 가드레일). "링크드인 프로필 봐줘", "스카우트 제안이 안 와요" 요청 시 활용. 경계: GitHub 레포·README는 portfolio, 이력서 문서는 resume, 서류 간 사실 정합성 대조는 review 담당. 검색 노출 순위 개선을 보장하지 않는다.

**benefits-from**: resume, portfolio, strategy, experience-bank

**Phase 골격**:

Phase 0: 플랫폼·직무 확인, 프로필 텍스트 복붙 입력 (파일/텍스트 모두 허용). Phase 1: 3영역 진단 — 헤드라인(5초 규칙: 직무+차별 성과 1개), 한 줄 소개(before→after 수치 유무), 경력 요약(기능 서술→성과 서술 전환 필요 문장 표시) + 리크루터 검색 키워드 배치 휴리스틱 점검(직무 핵심 키워드가 헤드라인·요약에 문맥으로 배치됐는지). Phase 2: before→after 리라이팅 — 항목별 개선안 제시, 사실 확인이 필요한 수치·직함은 사용자에게 질문(placeholder+1회 질문, 날조 금지). Phase 3: 마무리 — 개선 전후 대비표 출력, resume 산출물이 있으면 /review의 정합성 대조 안내, 다음 추천(/portfolio, /tracker).

**저장**: 신규 상태 파일 없음. 산출물은 현재 디렉토리 markdown. profiles/default.yaml과 experiences.yaml을 읽기 전용 소비(키워드·수치 근거 소스).

**소비 배선**: benefits-from: [resume, portfolio, strategy, experience-bank]. 이력서↔프로필 사실 정합성(경력 기간·직함) 대조는 review에 '프로필' 서류 유형을 추가해 이관하고 review의 benefits-from에 scout-profile을 추가. portfolio와의 대상 분리(레포/README vs 플랫폼 프로필 텍스트)를 양쪽 description에 명시.

**MVP(v0.1.0)**: 권장안: 2단계 경로(resume 프로필 모드로 시작) 대신 축소 MVP 즉시 신설. 근거 — 3개 기능은 프롬프트 전용이라 유지비가 낮고, resume에 프로필 모드를 넣으면 문서 유형이 다른 두 입력이 한 스킬에 섞여 라우팅이 흐려지며 추후 분리 비용이 더 크다. 대신 P2로 마지막에 착수하고 analytics/skill-usage.jsonl 사용량으로 v0.2 확장을 판단한다. v0.1.0: ①3영역 진단 ②before→after 리라이팅 ③날조 금지 가드레일. 제외: 정합성 대조(review 이관), 플랫폼별 세부 최적화 분기, 항목별 점수화 리포트, 스카우트 응답 템플릿·tracker 기록.

> ⚠️ **main 재조정**: 충돌 없음, 동일 3건: 프리앰블 canonical(main 수정본), test-preambles.sh SKILLS 목록 추가, 사용자 노출 표기 /scout_profile(하이픈 금지). review 연계·경계 설계는 main 변경과 무충돌.

**완료 판정:**
- 프로필 텍스트 입력 시 헤드라인/소개/경력 요약 3영역 진단표가 출력된다
- 항목별 before→after 개선안이 제시되고, 근거 없는 수치·직함이 생성되지 않는다(placeholder+1회 질문)
- description에 '검색 노출 순위 보장 없음'과 portfolio/resume/review 라우팅 경계가 명시되어 있다
- 정합성 대조 요청 시 /review로 안내하고 자체 수행하지 않는다

## 병합 3건

- **humanize** → INFRA-3 templates/humanize-check.md + cover-letter/review 업그레이드
  - 순수 신규 자산(회사명·타 지원자 치환 테스트 절차, 날조 금지 가드레일 placeholder+1회 질문, 추상어→질문 전환표)을 INFRA-3 templates/humanize-check.md 공유 모듈로 신설. cover-letter Phase 4B에 '⑧ 치환 테스트 실패' 진단 추가 + Phase 6 날조 금지 명시(마이너 버전 업). review Phase 5 체크리스트에 'AI풍 신호 잔존' 항목 추가. '탐지 리스크 진단' 표현은 검증 불가하므로 'AI풍 신호 진단'으로 축소하고 외부 탐지기 결과 미보장 한계 명시. 단독 호출 수요가 analytics로 실측되면 tier-3 독립 승격 재검토.

- **followup-defense** → review Phase 4 심화 + INFRA-9 데이터 계약 + mock-interview 소비
  - review Phase 4 미끼 포인트 인벤토리를 심화: 문장을 '의도적 미끼 vs 방어 취약'으로 구분(1분 설명 가능 기준), 공통 5세트 프레임(어떤 문제/왜 그 방법/역할 범위/결과 확인/다시 한다면)으로 문장별 꼬리질문 2개 생성, [방어 답변 초안|문장 수정] 택일 플로우 추가. 결과는 INFRA-9 defense-map YAML(~/.jobstack/interview-history/)로 저장하고 mock-interview가 자체 추출 대신 이 저장본을 우선 질문 소스로 소비. cover-letter Phase 8 인벤토리도 동일 YAML 포맷으로 통일해 3중 중복을 단일 데이터 계약으로 수렴.

- **doc-export** → INFRA-6 bin/jobstack-export + review 파일화 phase
  - pandoc md→docx 변환(ATS 안전 reference.docx 템플릿 1종, 미설치/실패 시 복붙 fallback 메시지)을 INFRA-6 bin/jobstack-export 유틸리티로 구현 — jobstack-view/jobstack-config와 동일한 bin/ 관례. review에 최종 '파일화' phase 추가: 점검 통과 후 jobstack-export 호출 안내, PII placeholder 잔존·파일명 규칙 체크는 review 기존 제출 전 체크리스트에 통합. resume/cover-letter/career-history의 completion-status에 jobstack-view(PDF)와 jobstack-export(docx)를 함께 안내해 출력 경로를 단일 지점화. 단독 호출 수요 반복 확인 시 독립 스킬 승격 재검토.

## 기각 기록 (재논쟁 방지용 사유 보존)

- **profile-optimize**: scout-profile와 동일 컨셉(3개 관점 중복 도출)으로 병합 채택. 항목별 점수화(Careerflow식) 아이디어는 scout-profile v0.2 기능으로 이관.

- **job-fit**: company-research의 적합도 스코어링, review의 서류 일관성 점검과 중복(기준 3 위반). 키워드 반영률 85% 로직은 ETHOS 자산이므로 신규 스킬이 아닌 기존 워크플로우 개선으로 흡수. 채택하려면 company-research 범위 축소 리팩터링 선행 필요 — v0.1.0 대상 아님.

- **assessment-prep**: 코테/역검/인적성은 4년/60건+ 첨삭 자산이 커버하지 않는 영역으로 근거가 전부 웹 소스(기준 1 위반). ETHOS(설득 문서 철학) 접점 약하고, 알고리즘 학습 플랜은 프로그래머스 등 전문 도구 대비 차별점 없음. coding-test/ai-assessment와 함께 기각.

- **coding-test**: assessment-prep과 동일 사유(축적 자산 미비, ETHOS 접점 약함). '코테는 AI 없이, 과제는 AI 활용력' 분기 판단 하나로 스킬을 지탱하기 부족. 과제 전형 리뷰는 portfolio의 증거 6종 관점으로 이미 커버 가능.

- **ai-assessment**: mock-interview 'AI면접 모드'와 경계가 겹쳐 채택 시 기존 스킬 리팩터링 선행 필요. 게임형 검사·비언어 지표는 텍스트 CLI로 연습 불가(기준 5 위반). 검사 일정·환경 체크리스트 수준이면 tracker+mock-interview 보강으로 충분.

- **offer-compare**: salary(세후 환산·협상 전략)와 접점이 커 경계 관리 비용 발생, '복수 오퍼 보유자' 대상이 좁아 실사용 빈도 낮음. v0.1.0은 salary에 '복수 오퍼 비교표' 모드 추가를 권장. tracker offer 이후 단계는 onboarding과 함께 차기 로드맵 재검토.

- **job-mbti**: T/A×S/F×I/C×Q/G 4축 유형론은 첨삭 자산에 근거 없는 자체 개발 프레임(기준 1 위반)으로, '수치가 없으면 성과가 아니다' ETHOS와 긴장 관계. strategy 역량 진단과 사용자 혼동 위험. 검증 안 된 진단 도구는 제품 신뢰 리스크. 유입 퍼널 가치는 마케팅 장치로 별도 검토.

- **onboarding**: 오퍼 수락 이후~입사 90일은 tracker 8상태 모델이 offer에서 끝나듯 현재 제품 경계(취업 준비 도구) 밖. '이미 팀원처럼' 자산 재사용과 중고신입 데이터는 유효하므로 기각이 아닌 이연 — 이직 사이클을 제품 범위로 확장하는 결정과 함께 차기 메이저 버전 재상정.

- **interview-followup**: 근거 오독 판명: vault 'day5 interview followup' 원본 확인 결과 실제 주제는 '자소서 기반 꼬리질문 대비'로 면접 후 커뮤니케이션이 아님. 꼬리질문 대비는 review Phase 4 심화(구 followup-defense 병합)가 담당. 감사메일은 한국 채용 관행 표준이 아니고 355건 실사용 집계에 수요 신호 없음. 결과 대기 리마인드는 tracker 개선 백로그로 충분.

- **aptitude-test**: assessment-prep/coding-test 기각 논리 일관 적용: 근거가 웹 통계뿐, vault 전수 검색에서 GSAT/인적성 지식 자산 부재(뉴스 인용 1줄), 355건 실사용 집계 순위권 밖(NCS도 4건 저수요). GSAT 문제은행은 저작권 문제로 SKILL.md 기반 CLI 스킬 실현 가능성 낮음. 삼성 유일 공채는 시장 협소의 반증.

---

# 부록 C. 스킬별 작업 지시서 (126건)

## auto → v0.2.0 (9건)

### AUTO-1 · 프로필 자동 추출 사실 날조·PII 가드레일 추가  `[P0/S]` · 의존: INFRA-1

Phase 2 Case B의 자동 추출 항목 목록('이름, 연락처, 이메일...') 바로 아래에 가드레일 블록 삽입: (1) 이력서에 명시된 사실만 프로필에 기록 — 어학 급수·재직사 등 추정 기입 절대 금지 (2) 이력서에 없는 필드는 빈 값이나 추정값이 아니라 "[이메일 입력 필요]" 형태 placeholder로 저장 (3) 누락 필드는 AskUserQuestion 1회로만 질문, 반복 요구 금지 (4) 세션 외부 출처(훈련 데이터, 다른 사용자 문서)의 개인정보를 프로필에 넣지 않는다는 금지 조항 (5) 예외: 이력서에 명시된 기간 데이터에서 산술적으로 파생된 필드(총 경력 개월 수, positioning 등)는 파생 근거를 함께 기록하는 조건으로 허용 — AUTO-7과 정합. 공통 규칙은 templates/guardrails.md 참조 문구로 연결. (근거는 rationale: jobclaw JLPT/재직사 날조·운영자 이메일 자동 삽입 실사고 2건)

> ⚠️ **main 재조정 (partially_done)**: main 300a2aa(#113)가 auto Phase 3에 '파일 미감지 시 읽은 척 금지 + 제공 안 된 경력·사실 채우기 금지' 가드를 이미 추가. Case B의 5규칙(placeholder/1회 질문/외부 출처 금지/산술 파생 예외)과 guardrails.md 참조는 잔여 — 신규 문구는 #113 블록과 중복 없이 통합. 경로는 $_JS_STATE 표기(test-no-home-paths.sh).

**완료 판정:**
- SKILL.md Phase 2 Case B에 5개 가드레일 규칙(추정 금지/placeholder/1회 질문/외부 출처 금지/산술 파생 예외)이 존재한다
- 이메일이 없는 이력서로 재실행 시 default.yaml에 "[이메일 입력 필요]" placeholder가 저장되도록 지시가 명시되어 있다
- templates/guardrails.md 참조 문구가 Case B에 존재한다

### AUTO-2 · Case 5(no-arg)를 페인포인트 훅 + 메뉴판 진입 경로로 재설계  `[P0/M]`

Phase 4 Case 5 전면 교체: (1) '파일이 없습니다→전략 수립' 단일 안내를 폐기하고, 검증 페인포인트 5종(내 문서가 괜찮은지 모름/왜 떨어지는지 모름/첨삭 부탁할 사람 없음/유료 첨삭 비용 부담/AI 초안이 내 경험을 지웠는지 불안) 중 해당 항목을 고르게 하는 훅 + '어디가 약한지 3분 안에 진단' 카피로 시작 (2) 다음 입력 3경로(파일 드래그/텍스트 복붙/전략 수립부터) 안내 (3) 인사말·능력 질문("안녕", "뭐 할 수 있어")에는 즉시 메뉴판(할 수 있는 것 목록 + 첫 액션 제안)을 제시하는 규칙 추가. 파일 읽기 실패 fallback("읽을 수 없습니다" 대신 "내용을 복붙해 주세요" 요청)은 Case 5가 아니라 Phase 1 분류 절차에 추가한다 — 읽기 실패는 파일이 감지된 경우에만 발생하기 때문. entry 텔레메트리는 AUTO-8로 통합(이 항목에서는 다루지 않음). no-arg는 오류가 아닌 정상 진입 경로임을 본문에 명시.

**완료 판정:**
- Case 5에 페인포인트 5종 선택 훅과 입력 3경로 안내가 존재하고 기존 단일 안내 문구가 제거되었다
- Phase 1 분류 절차에 읽기 실패→복붙 요청 fallback 문장이 존재한다 (Case 5에는 없음)
- 인사·능력 질문 시 메뉴판 즉시 제시 규칙이 존재한다

### AUTO-3 · 추천 순서 실수요 재정렬 + '서류합격 패키지'·파일화 선택지 추가  `[P1/M]` · 의존: INFRA-6

Phase 4 Case 3·4 선택지 개편: (1) Case 4 최상단 결합안 "통합 리뷰 + 모의면접"을 "서류합격 패키지(이력서+자소서+통합리뷰 결합 리포트)"로 교체하고 모의면접은 후순위 선택지로 이동 (2) 모든 Case에 "최종 파일 출력(.docx)" 선택지 추가 — bin/jobstack-export(INFRA-6) 존재 시 pandoc 변환, 미설치 시 markdown 복붙 폴백 경로를 본문에 명시 (3) 추천 순서를 서류(이력서·자소서) > 기업분석·공고 > 파일 출력 > 면접으로 정렬하되 수요 수치는 본문에 쓰지 않는다 (4) Phase 5 완료 조건에 "1회 첨삭이 아니라 진단→수정→재리뷰→파일화 루프까지가 완성" 명시. (수요 근거는 rationale에만: jobclaw 41명/695건 서류 197>회사분석 126>공고 104>파일출력 56>면접 33, 별도 355건 프롬프트 집계에서도 이력서 77>공고 57~59>자소서 39>면접 23으로 서류 최우선·면접 최하위 일치. 정정: 현행 최상단은 모의면접 단독이 아니라 '통합 리뷰+모의면접' 결합안임)

> ⚠️ **main 재조정 (needs_adjust)**: 전제 변경: main d6c7da4가 resume/cover-letter에 봇 File output protocol(#118b, [OUTPUT_FILE:]+render-docx.sh) 기반 .docx 자동산출을 도입. '최종 파일 출력' 선택지는 봇(#118b)/CLI(bin/jobstack-export) 이원 경로로 재설계 필요. 사용자 노출 명령은 /mock_interview 언더스코어 표기(test-command-style.sh).

**완료 판정:**
- Case 4 A안이 '서류합격 패키지'이고 모의면접이 후순위 선택지로 이동했다
- 모든 Case에 파일 출력 선택지와 pandoc 미설치 시 markdown 폴백 문구가 존재한다
- Phase 5에 진단→수정→재리뷰→파일화 루프 완성 조건 문장이 존재한다

### AUTO-4 · 채용공고 감지 시 서류 요구 형태 진단 분기 추가  `[P1/S]`

Phase 4 Case 2 첫 단계로 "서류 형태 진단" 삽입: 감지된 채용공고 본문에서 요구 서류를 파싱해 자소서형/이력서·경력기술서형/영상·과제형/자소서 없음 4분기로 판별. 자소서를 요구하지 않는 전형이면 자소서 작성 대신 이력서·포트폴리오 방향으로 추천을 전환하고, 선택지 C "채용공고에 맞춰 자소서 작성"은 자소서 요구가 확인된 경우에만 노출. 영상·과제형은 라우팅할 스킬이 없으므로 auto 인라인 안내(영상 스크립트 구조 조언 수준) 범위임을 본문에 명시 — 별도 스킬 위임 금지. 특정 기업의 전형 방식·자소서 폐지 여부는 본문에 하드코딩하지 않고 필요 시 실행 중 WebSearch로 확인한다는 규칙 병기. (근거는 rationale에만: 자소서 폐지·1분 영상 전형 등 2026 전형 다변화 흐름)

**완료 판정:**
- Case 2에 4분기 서류 형태 진단 단계가 존재한다
- 자소서 미요구 공고 입력 시 자소서 작성 선택지가 노출되지 않는 조건 분기가 명시되어 있다
- 영상·과제형은 auto 인라인 처리 범위라는 문장과 WebSearch 동적 확인 규칙이 존재한다

### AUTO-5 · deep_strategy 감지 라우팅 예외 규칙 추가 (원안 유지)  `[P1/S]`

Phase 4 앞에 "라우팅 예외" 섹션 신설: 사용자 요청이 25자 이상이면서 전략|로드맵|갭 분석|AI 시대|다음 1년|살아남 등의 패턴에 걸리면 파일 감지 결과와 무관하게 /strategy로 위임한다고 명시. false negative는 무해(auto 기본 흐름으로 진행)하므로 패턴을 보수적으로 유지한다는 원칙도 함께 기술. verdict에서 지적 사항 없어 원안 그대로 채택.

**완료 판정:**
- SKILL.md에 '라우팅 예외' 섹션과 25자+패턴 조건이 존재한다
- "AI 시대에 살아남을 커리어 전략 짜줘" 입력 시 /strategy 위임 흐름이 명시되어 있다
- false negative 무해 원칙 문장이 존재한다

### AUTO-6 · 대시보드에 tracker 상태·7일 정체 넛지 통합 + 세션 연속성 카피  `[P1/M]` · 의존: INFRA-5

Phase 3 체크 기준에 tracker 항목 추가: ~/.jobstack/tracker/applications.jsonl을 읽어 대시보드 하단에 "지원 현황: N건 진행 중" 줄을 출력하고, updated_at 기준 7일 이상 상태 변화 없는 건에 넛지("○○ 지원 7일째 변화 없음 — 후속 확인?")를 출력. 상태 어휘는 제안 원안의 영어 8상태(applied→document_pass 등)가 아니라 INFRA-5에서 확정하는 canonical 모델(현행 tracker의 한국어 7상태: 준비중/서류전형/서류합격/1차면접/2차면접/최종합격/불합격 기반)을 그대로 사용해 auto·tracker 간 상태 어휘 불일치를 만들지 않는다. Phase 2 Case A에 세션 연속성 카피 추가: 기존 프로필·기존 감지 파일이 있으면 "이전에 보내주신 <파일명> 기억하고 있어요"로 시작하고 재업로드를 요구하지 않는다. "내 정보 기억해?"류 질문에는 프로필 요약으로 응답하는 규칙 추가(실사용 프로필 기억 확인 수요 반영).

> ⚠️ **main 재조정 (needs_adjust)**: tracker는 봇 미노출·CLI 잔존(BOT-COMMAND-STYLE §2) — 대시보드에서 /tracker 추천 금지, 봇 문맥 안내는 /track·/myapps. applications.jsonl 읽기 자체는 유지 가능하나 경로는 $_JS_STATE/tracker/ 표기(test-no-home-paths.sh, main이 auto 본문 경로를 이미 $_JS_STATE로 치환).

**완료 판정:**
- Phase 3에 applications.jsonl 읽기 + updated_at 7일 기준 넛지 규칙이 존재한다
- 상태 어휘가 INFRA-5 canonical 모델과 일치하고 영어 8상태 표기가 본문에 없다
- Case A에 재업로드 요구 금지 카피와 기억 확인 응답 규칙이 존재한다

### AUTO-7 · 프로필 추출 시 중고신입 감지·포지셔닝 안내  `[P2/S]` · 의존: AUTO-1

Phase 2 Case B 추출 항목에 판정 로직 추가: 이력서에 명시된 경력·인턴 기간 합산이 6개월~3년이면 프로필에 positioning: 중고신입 필드를 기록하되, AUTO-1의 산술 파생 예외 규정에 따라 파생 근거(합산 개월 수, 출처: 이력서 기재 기간)를 함께 기록한다 — 명시 사실이 아닌 추론 필드가 아니라 산술 파생 필드임을 본문에 명시해 가드레일과 모순 없앰. 확인 요청 메시지에 "경력 N개월은 숨길 게 아니라 무기입니다 — 이력서·자소서에서 경력 중심으로 재구성하겠습니다" 한 줄 추가. Phase 5 스킬 실행 시 이 필드를 컨텍스트로 전달. 시장 비율 수치(중고신입 비중 등)는 본문에 하드코딩하지 않는다. (근거는 rationale에만: 대기업 신입 중 중고신입 비중 상당, 중고신입 선호 HR이슈 1위, 범위 경력 6개월~3년)

**완료 판정:**
- Case B에 6개월~3년 합산 판정 로직과 파생 근거 표기 규칙이 존재한다
- 경력 18개월 이력서 입력 시 positioning: 중고신입 필드가 default.yaml에 기록되도록 지시가 명시되어 있다
- Phase 5에 positioning 컨텍스트 전달 규칙이 존재한다

### AUTO-8 · 진단 퍼널 후속 이벤트 텔레메트리 (제안 2·8 통합 재설계)  `[P2/S]` · 의존: INFRA-10

프리앰블 bash는 수정하지 않는다(프리앰블은 Phase 1 감지 이전에 실행되므로 entry/detected를 알 수 없음). 대신 Phase 1 감지 완료 직후 Claude가 Bash로 skill-usage.jsonl에 후속 이벤트를 append하는 지시를 추가: INFRA-10 규격의 {"skill":"auto","event":"detected","entry":<케이스 1~5, no-arg는 케이스 5>,"detected":[감지 카테고리 목록],"ts":...}. Phase 5 완료 시 선택된 스킬과 2차 점검 여부를 후속 이벤트로 append하는 지시 추가. 완료 상태 섹션에 세션 종료 시 피드백 2문("가장 도움된 피드백은?"/"다시 쓰려면 뭐가 좋아져야?") 중 1개를 묻는 규칙 추가. 제안 2와 8이 중복 제안했던 entry 필드는 이 항목 하나로 단일화한다.

**완료 판정:**
- SKILL.md에 Phase 1 감지 완료 후 후속 이벤트 append 지시가 존재하고 프리앰블 bash에는 entry/detected 필드가 없다
- no-arg 실행 시 entry가 케이스 5로 기록되는 이벤트 규격이 명시되어 있다
- test/test-preambles.sh가 통과한다 (프리앰블 무변경 확인)

### AUTO-9 · 붙여넣기 텍스트 입력 3종 분류 규칙 (round2 신규)  `[P2/S]`

Phase 1에 "텍스트 입력 분류" 소절 신설: 사용자가 파일 대신 긴 텍스트를 붙여넣은 경우 (1) JD 원문(자격요건·우대사항·모집 머리말 신호) → Case 2 채용공고 흐름 (2) 본인 답변(1인칭 경험 서술 — 지원동기·면접 답변·자소서 초안) → 해당 문서 첨삭 흐름(cover-letter 또는 면접 답변 피드백) (3) 자소서 문항+답변 쌍("문항:"+답변 구조) → cover-letter 문항 분석 흐름으로 라우팅하는 3종 감지 규칙을 추가. 판별이 불확실하면 AskUserQuestion 1회로 확인("이 텍스트는 채용공고인가요, 본인이 쓴 답변인가요?"). (근거는 rationale에만: 실사용에서 면접 답변 전문·자소서 문항+답변 붙여넣기 첨삭 패턴이 반복 관측 — 의도 분류 부재 시 오라우팅 발생)

**완료 판정:**
- Phase 1에 3종 텍스트 분류 규칙과 각 라우팅 대상이 존재한다
- 지원동기 답변 전문 붙여넣기 시 첨삭 흐름으로 라우팅됨이 명시되어 있다
- 불확실 시 AskUserQuestion 1회 확인 규칙이 존재한다

### 제외·기구현 (3건)
- **프리앰블 bash 텔레메트리에 entry(file_detected|no_arg)·detected 필드 추가 (제안 2·8의 원설계)**: 실행 순서상 불가능 — 프리앰블은 Phase 1 파일 감지 이전에 실행되어 해당 값을 알 수 없음. 감지 완료 후 Claude가 후속 이벤트를 append하는 설계(AUTO-8, INFRA-10 규격)로 이관.
- **tracker 영어 8상태 모델(applied→document_pass→interview_1/2→final→offer)을 auto 대시보드에 도입**: 실제 tracker 스키마(한국어 7상태, applications.jsonl)와 불일치 — 스킬 간 상태 어휘 분열 방지를 위해 기각하고 INFRA-5 canonical 모델 사용으로 대체(AUTO-6).
- **영상·과제형 공고에 대한 '영상 스크립트 스킬' 라우팅**: 13개 스킬 중 영상 스크립트 기능이 없어 라우팅 불가 — auto 인라인 안내 범위로 한정하는 수정본(AUTO-4)으로 대체.

## strategy → v0.2.0 (11건)

### STR-1 · Phase 2 수치 검증 규칙 + 완료 상태 4상태 표준화 (최우선 적용, 교차 점검 게이트)  `[P0/S]` · 의존: INFRA-1

Phase 2 '분석 결과' 아래에 검증 규칙 3줄 추가: ①"WebSearch로 실시간 확인한 수치만 단정형으로 쓴다. 미확보 수치는 '(출처 미확보)'를 붙이거나 생략한다" ②"채용 일정·공고는 훈련 데이터로 절대 대체하지 않는다. 검색 실패 시 해당 섹션을 생략하고 직접 확인을 안내한다" ③"검색이 막히면 '네트워크 차단' 같은 한계 표현 대신 필요 자료 요청으로 변환한다: '목표 직무의 공고 2-3개 링크나 본문을 붙여주시면 GAP 분석 정확도가 올라갑니다'". '완료 상태' 섹션을 templates/completion-status.md와 동일한 4상태(DONE/DONE_WITH_CONCERNS/BLOCKED/NEEDS_CONTEXT)로 교체하고, 시간 민감 데이터 BLOCKED 시 훈련 데이터 대체 금지→해당 섹션 스킵 후 DONE_WITH_CONCERNS 규칙을 명시. 검증 판정상 결함 없음(원안 채택). 이 항목을 가장 먼저 적용하고, 이후 STR-2/6/9/11이 이 규칙을 위반하지 않는지 교차 점검한다.

**완료 판정:**
- SKILL.md Phase 2에 검증 규칙 3줄(단정 조건, 훈련 데이터 금지, 자료 요청 전환)이 존재한다
- 완료 상태 섹션에 4상태(DONE/DONE_WITH_CONCERNS/BLOCKED/NEEDS_CONTEXT)가 존재하고 templates/completion-status.md 문구와 일치한다

### STR-2 · 공채 중심 전제 교정 — 수시 상시 지원 기본, 수치·기업표는 WebSearch 동적 확인  `[P0/M]` · 의존: INFRA-1, INFRA-7, STR-1

Phase 3.1을 '채용 방식 전략(수시 기본, 공채 예외)'으로 재작성. ①기존 3분기 규칙(신입+대기업→공채 중심 등) 삭제, "수시·상시 채용이 시장 기본값이며 공채는 일부 기업의 예외 전형"을 정성 전제로 명시 — 비율 수치(89.8% 등)·4대그룹 전형 방식 표(GSAT/SKCT 등)는 SKILL.md에 쓰지 않는다 ②구체 확인은 Phase 2 검색 항목으로 위임: "[직무명] 채용 방식 트렌드 [현재 연도]", "[기업명] 채용 전형" 추가, 기존 "[산업명] 공채 수시채용 일정"은 "[산업명] 채용 일정 [현재 연도]"로 수정(연도는 실행 시점 KST 기준 동적 치환, 하드코딩 금지) ③전략 옵션에 "프로필 상시 노출 관리(링크드인·원티드·리멤버)" 한 줄 추가(수치 근거 없이) ④Phase 4 서두에 "공채 일정 대기가 아니라 준비 완료 즉시 지원" 1줄 추가 ⑤공채/수시 캘린더·일정 세부는 다루지 않고 "/job-search — 공채/수시 캘린더 확인" 라우팅 문구로 위임. 근거 수치(경총: 수시 관여 89.8%, 공채만 10.2%, 다이렉트소싱 51.2%)는 이 rationale에만 남긴다.

> ⚠️ **main 재조정 (needs_adjust)**: 라우팅 문구는 /job_search 언더스코어 표기 필수 — test-command-style.sh가 /job-search 하이픈 표기를 FAIL 처리

**완료 판정:**
- Phase 3.1에 '신입+대기업→공채 중심' 분기가 존재하지 않고 수시 기본 전제 문장이 존재한다
- SKILL.md 본문에 채용 비율 수치·연도 하드코딩·기업별 전형 방식 표가 없다 (INFRA-7 린트 grep 검출 0건)
- Phase 2 검색 항목에 '[현재 연도]' 동적 표기와 '[기업명] 채용 전형' 항목이 존재하고, 채용 일정은 /job-search 라우팅 문구로 위임된다

### STR-3 · 로드맵에 측정 지표 도입 — deep_strategy 5블록 구조 이식 (원안 채택)  `[P0/M]`

Phase 4를 5블록 구조로 재작성: 📌진단(3-5줄)→📊갭 분석(강점·갭 각 2-3개, 근거 명시)→🎯4-8주 액션플랜(Week 단위+항목별 측정 지표)→💡1년 시계→⚠️가정 검증 요청. 로드맵 표에 '측정 지표' 컬럼을 추가하고 예시를 수치형으로 교체: "1-2주 | 기업 분석 3개 완료 + 키워드 반영률 85% 목표 | /company-research", "3-4주 | 이력서 v1 + 수치 성과 5개 확보 | /resume" 식. 섹션 말미에 금지 규칙 명시: "'사이드프로젝트 하세요', '꾸준히 공부하세요' 같은 측정 불가 일반론을 액션으로 쓰지 않는다. 모든 액션은 주차+산출물+숫자로 쓴다." Phase 3.3 GAP 분석 예시의 액션도 "프로젝트 1개 추가"→"Kafka 1만건/일 처리 프로젝트 1개(4주)" 식 구체형으로 교체. 검증 판정상 결함 없음.

> ⚠️ **main 재조정 (needs_adjust)**: main이 Phase 4 로드맵 표를 이미 개편(1-2주 행 /ncs 제거, /cover_letter·/track 표기). 측정 지표 컬럼 추가 시 예시의 스킬 명령을 현행 표(언더스코어, /track) 기준으로 작성 — '/company-research, /resume' 예시 표기 갱신.

**완료 판정:**
- Phase 4에 5블록(진단/갭/액션플랜/1년 시계/가정 검증) 구조와 측정 지표 컬럼이 존재한다
- 측정 불가 일반론 금지 규칙 문장이 SKILL.md에 존재한다
- 동일 프로필 입력으로 재실행 시 로드맵 각 행에 주차+산출물+숫자가 포함된 액션이 출력된다

### STR-4 · 중고신입·경력 트랙 대응 — Phase 1 분기 질문 + 소크라틱 4질문 + career_track 필드  `[P1/M]`

Phase 1을 두 갈래로 개편. ①질문 1 앞에 분기 질문 추가: "현재 상태를 알려주세요: A) 신입(경력 없음) B) 중고신입(경력 6개월~3년) C) 경력 이직(3년+)". B/C 선택 시 학력 질문 대신 "최근 6개월 가장 큰 임팩트는?", "자주 다루는 시스템·도메인은?"을 우선 질문 ②B에 규칙 명시: "경력은 숨기지 않고 무기화한다 — 짧은 경력도 직무경험의 근거로 재구성" (수정 반영: '1위 67.6%' 수치는 본문에 쓰지 않는다. 직무경험이 최우선 평가 요소라는 근거 수치는 이 rationale에만) ③NEEDS_CONTEXT용 소크라틱 4질문을 Phase 1 말미에 고정: 타겟 기업 1-3곳 / 자주 닿는 시스템·도메인 / 최근 6개월 최대 임팩트 / 마감 시점 ④YAML 프로필에 career_track: new|semi_experienced|experienced 필드 추가 ⑤PROFILE_EXISTS=true 시 저장된 프로필을 요약하지 말고 항목별로 그대로 보여준 뒤 업데이트 여부를 확인하는 '기억 확인' 응답 규칙 1줄 추가(프로필 영속 기억 수요 16건 반영).

**완료 판정:**
- Phase 1에 신입/중고신입/경력 분기 질문과 B/C 트랙 우선 질문 2개가 존재한다
- YAML 프로필 예시에 career_track 필드가 존재하고 소크라틱 4질문이 Phase 1 말미에 존재한다
- 본문에 '67.6%' 등 평가 비중 수치가 존재하지 않는다

### STR-5 · Tier 분류에 stepping-stone 경로 열 추가 (원안 채택)  `[P1/S]` · 의존: STR-3

Phase 3.2 Tier 표 아래에 'Tier 1 갭이 클 때의 경로 설계' 소절 추가. ①stepping-stone 표준 경로 명시: 중소기업/부트캠프 → 동종업계 → 협력업체/자회사 → 목표 대기업(자회사 목록은 egroup.go.kr 활용) ②적용 조건: "역량 매칭 50% 미만 + 목표 시기 6개월 이내면 Tier 1 직행 대신 경로형 전략을 제안한다" ③STR-3의 💡1년 시계 블록과 연결해 "1단계 진입(현 시점)→2단계 이동(1년 후)"으로 표기 ④Tier 3 '안전 지원' 설명을 "합격 가능성 높은 곳"에서 "Tier 1로 가는 경력 발판이 되는 곳(동종 도메인·협력사 우선)"으로 수정. 검증에서 이의 없음.

**완료 판정:**
- Phase 3.2에 stepping-stone 경로 소절(중소→동종업계→협력사/자회사→목표 기업)과 적용 조건 문장이 존재한다
- Tier 3 설명이 '경력 발판' 관점으로 수정되어 있다

### STR-6 · GAP 표 'AI 도구 활용' 행 추가 + 직군별 평가 방식 WebSearch 확인 규칙 (축소 채택)  `[P1/S]` · 의존: INFRA-1, STR-1

검증 수정방향대로 축소 반영. Phase 3.3 GAP 표 예시에 'AI 도구 활용' 행 1개를 추가한다(예: "AI 도구 활용 | ●●○○○ | 3 | 실무 워크플로에 AI 도구 적용 사례 2개 만들기"). 그 아래 일반 규칙 1줄 추가: "목표 직군의 최신 평가 방식(코딩테스트/과제/인적성·역량검사 등)은 WebSearch로 확인해 로드맵에 반영한다. 특정 기업·연도의 시험 형식을 단정하지 않는다." 원안의 카카오 코테 세부 형식(알고리즘 7문제 4.5h 등)·'구현자→판단자' 프레임·평가 이원화 3규칙은 넣지 않는다(staleness·단일 내부 근거·개발자 편중). AI 활용 역량이 인재 요건 상위라는 수치(4위 24.2%)는 이 rationale에만 남긴다.

**완료 판정:**
- Phase 3.3 GAP 표 예시에 'AI 도구 활용' 행이 존재한다
- 직군별 평가 방식 WebSearch 확인 규칙 1줄이 존재하고, 카카오 코테 형식·'판단자' 프레임 문구가 본문에 존재하지 않는다

### STR-7 · A/B 비교 의사결정 모드 신설 — 선택지 비교표 + 프로필 기준 추천 (신규, 실수요 반영)  `[P1/S]` · 의존: STR-3

round2 실사용 데이터 반영: strategy성 요청의 실제 형태는 로드맵 요청보다 A/B 비교 의사결정('빨리 이직 vs 석사 후 천천히', '백엔드 vs 플랫폼 리드')이 다수. Phase 1 앞에 진입 분기 1줄 추가: "사용자 요청이 두 개 이상 선택지 비교형이면 Phase 4 로드맵 대신 '비교 상담 모드'로 전환한다." 비교 상담 모드 출력 형식 명시: ①선택지별 비교표(기준 분리: 보상/성장/직무적합/리스크/타임라인) ②프로필(career_track, target, strengths) 기준 추천 1개 + 이유 한 줄 ③추천안 기준의 4주 첫 액션(측정 지표 포함, STR-3 규칙 준수) ④비교에 필요한 정보가 빠지면 AskUserQuestion 4단 구조로 1개씩 질문. 결과는 strategy-roadmap.md 대신 strategy-decision.md로 저장.

**완료 판정:**
- SKILL.md에 비교형 요청 감지 분기와 '비교 상담 모드' 섹션(비교표 5기준+프로필 기준 추천+4주 첫 액션)이 존재한다
- "A안 vs B안" 형태 입력으로 실행 시 로드맵이 아닌 비교표+추천이 출력되고 strategy-decision.md가 생성된다

### STR-10 · 직무 전환 프로토콜 — ①④⑤만 채택, 문장 수준 작업은 라우팅으로 이관 (수정 채택)  `[P2/S]` · 의존: STR-3

검증 수정방향 반영: 원안 5단계 중 strategy에서 실행 불가한 ②(경험 재분류)·③(직무명만 바꾼 문장 탐지)은 제외. Phase 3에 3.4 '직무 전환 전략(해당 시)' 소절 추가. 트리거: 프로필 experience 직무와 target.roles가 다를 때. 내용 3개: ①새 직무 공고에서 반복 키워드 추출(WebSearch 또는 사용자 제공 공고) → 📊갭 분석 블록에 '전환 갭'으로 별도 표기 ④약점은 숨기지 않고 인정+보강 계획을 로드맵 액션(주차+산출물+숫자)으로 배치 ⑤전환 이유 예상 면접 질문 3개를 생성해 로드맵의 모의면접 주차에 배치. 마지막에 라우팅 1줄: "경험 문장의 직무 기준 재작성과 '직무명만 바꾼 문장' 점검은 /resume·/cover-letter에서 진행하세요 — 전환 갭 결과를 그대로 전달합니다."

> ⚠️ **main 재조정 (needs_adjust)**: 라우팅 1줄의 /cover-letter는 /cover_letter 표기 필수(/resume는 동일). 내용 자체는 유효.

**완료 판정:**
- Phase 3.4에 트리거 조건과 ①④⑤ 3단계, /resume·/cover-letter 라우팅 문구가 존재한다
- 경험 재분류·문장 탐지 단계가 strategy 본문에 존재하지 않는다
- experience와 target.roles가 다른 프로필로 실행 시 갭 분석에 '전환 갭' 항목이 출력된다

### STR-11 · 공공기관·정부지원 트랙 분기 추가 (신규, round2)  `[P2/S]` · 의존: INFRA-1, STR-1

round2 공공기관·법제도·정부지원 리서치 반영. Phase 3에 '공공기관 트랙(해당 시)' 분기 3줄 추가: ①target.industries에 공공기관·공기업이 포함되면 NCS 기반 전형을 전제로 로드맵에 /ncs를 조기 배치하고, 블라인드 적용 여부·지역인재 요건·인턴 유형(체험형 vs 채용연계형)은 WebSearch로 해당 기관 공고를 확인한다 ②기관별 자소서 맞춤이 필수임을 명시(재활용 방지) ③Phase 4 로드맵 재료로 정부 취업지원제도(국민취업지원제도, 국민내일배움카드/KDT)를 안내하되 "지원 금액·자격 요건은 변동되므로 work24.go.kr에서 WebSearch로 확인" 규칙을 붙인다. 채용 규모·수당 금액·지역인재 비율 등 수치는 본문에 쓰지 않는다(rationale: 2026 공공기관 정규직 2.8만명 계획, 지역인재 71%, 구직촉진수당 월 60만원 인상).

> ⚠️ **main 재조정 (needs_adjust)**: '/ncs 조기 배치'는 test-command-style.sh가 금지(봇 미노출, BOT-COMMAND-STYLE §2 — NCS 보강은 cover-letter가 흡수). NCS 라우팅을 /cover_letter 공기업 NCS 보강 안내로 교체하거나 CLI 한정 예외 처리 설계 필요. 나머지(WebSearch 확인·work24 규칙)는 유효.

**완료 판정:**
- Phase 3에 공공기관 트랙 분기(NCS 라우팅+WebSearch 확인 항목 3종)가 존재한다
- 정부지원제도 안내에 work24.go.kr 확인 규칙이 붙어 있고 수당 금액·채용 규모 수치가 본문에 존재하지 않는다

### STR-8 · 직군별 평가 축 매트릭스 분기 — 개발자 편중 해소 (신규, round2)  `[P2/S]` · 의존: INFRA-1, STR-6

round2 '직군별 평가 축 매트릭스' 지식을 정성 규칙으로 반영해 STR-6에서 지적된 개발자 편중을 해소한다. Phase 3.3 뒤에 '직군별 GAP 독해 기준' 표 추가(수치 없음): 개발=GitHub·구현 근거·트러블슈팅 / 마케팅=캠페인 수치·데이터분석·AI활용 / 기획·PM=역기획서 논리·화면설계·비즈니스 임팩트 / 디자인=케이스스터디 문제해결 스토리 / 재무·회계=자격증 기준선+정확성(포트폴리오 비중 낮음) / 영업=대인 경험·스토리텔링(포트폴리오 불필요). 규칙 1줄: "GAP 표의 '필요 역량' 행은 이 직군 축에서 뽑되, 자격증·시험의 최신 기준은 WebSearch로 확인한다." 특정 자격증 합격률·응시료 등 수치는 본문에 쓰지 않는다.

**완료 판정:**
- Phase 3.3 인근에 6개 직군의 GAP 독해 기준 표가 존재한다
- 표에 합격률·응시료 등 시간 민감 수치가 존재하지 않는다

### STR-9 · 로드맵에 인적성·AI역량검사·컬처핏 단계 추가 — 수치 제거, 조건부 WebSearch 확인 (수정 채택)  `[P2/S]` · 의존: INFRA-1, STR-1, STR-3

검증 수정방향 반영: '1,200개사+', '57.6%', 'KAIST 유효성 확인' 문구는 쓰지 않는다. Phase 4 로드맵 예시에 두 항목 추가·수정: ①조건부 규칙 — "목표 기업의 서류~면접 사이 검사 단계(인적성·AI역량검사·코딩테스트)는 WebSearch로 '[기업명] 채용 전형'을 확인해 도입돼 있으면 로드맵에 대비 1주를 배치한다. AI역량검사 대비는 게임형 문항 연습(잡다 jobda.im 무료)→성향 일관성 점검→상황판단→환경 점검 4단계로 안내한다" ②모의면접 주차(10-12주)에 병기 — "컬처핏은 1차 면접에서 비중이 큰 평가 항목 — /company-research의 인재상·문화 키워드를 면접 답변에 연결". /mock-interview 라우팅 문구에 '컬처핏 모드 요청' 추가. 근거 수치(도입사 규모, 1차 면접 57.6%)는 이 rationale에만.

> ⚠️ **main 재조정 (needs_adjust)**: /mock-interview 라우팅 문구는 /mock_interview 언더스코어 표기(test-command-style.sh)

**완료 판정:**
- Phase 4에 검사 단계 조건부 규칙(WebSearch 확인 후 배치)과 대비 4단계가 존재한다
- 본문에 '1,200개사', '57.6%', 'KAIST' 문구가 존재하지 않는다
- /mock-interview 라우팅 문구에 컬처핏 모드 요청이 포함된다

### 제외·기구현 (5건)
- **4대그룹 전형 방식 표(삼성 GSAT/SK SKCT/현대차 상시/LG Way Fit) 및 시장 수치 SKILL.md 하드코딩**: 검증 기각: 하드코딩 자체가 시간 민감 데이터가 되어 1~2년 내 다시 낡은 전제가 됨. STR-1의 검증 규칙과 자기모순. Phase 2 '[기업명] 채용 전형' WebSearch 확인으로 대체(STR-2).
- **공채/수시 캘린더·채용 일정 세부를 strategy에 수록**: 역할 경계 위반 — 채용 일정·캘린더는 job-search 스킬 담당. strategy는 분기 규칙 교정과 /job-search 라우팅 문구까지만(STR-2에 라우팅으로 이관).
- **개발자 특화: 코테/면접 평가 이원화 3규칙 + 2026 카카오 코테 세부 형식 + '구현자→판단자' 프레임**: 검증 기각: 전 직군 Tier 1 진입점에 개발 규칙만 3개는 범위 왜곡(YAGNI), 카카오 형식은 시즌마다 낡는 데이터, 판단자 프레임은 단일 내부 메모 근거로 빈약. 'AI 도구 활용' GAP 행+WebSearch 일반 규칙으로 축소(STR-6).
- **직무 전환 5단계 중 ②기존 경험 재분류·③'직무명만 바꾼 문장' 탐지**: strategy는 YAML 프로필·로드맵만 다뤄 탐지할 문장 입력이 없음. 문장 단위 재작성·탐지는 resume/cover-letter/review 영역과 중복 — 라우팅 문구로 이관(STR-10).
- **'KAIST가 AI역량검사 성과예측 유효성 확인' 근거 문구**: 검증 기각: AI역량검사 타당성은 학계·업계에서 검증 논란이 있는 논쟁적 주장이라 단정 근거로 부적합. 수치·기관 인용 없이 조건부 대비 규칙만 유지(STR-9).

## tracker → v0.2.0 (9건)

### TRK-1 · 통합 canonical 상태 모델 반영 (withdrawn·watching 포함, add/update 선택지 통일, 한글→영문 정규화)  `[P0/L]` · 의존: INFRA-5

원안 제안 1(8상태 표준화)과 제안 5(watching 상태)를 하나의 상태 모델 작업으로 병합해 SKILL.md에 반영한다. (1) '상태 모델' 섹션 신설: INFRA-5에서 확정한 canonical 상태 목록(watching 포함 여부, jobclaw 원안의 final/offer 중복 해소 포함)과 영문 키↔한글 표시 매핑 표를 넣는다. (2) add 3번 질문과 update 3번 질문의 선택지를 이 단일 목록으로 통일하고 '지원철회(withdrawn)'를 update 선택지에 추가한다(현재 add에는 '서류전형', update에는 '준비중'이 없어 불일치). (3) 기존 applications.jsonl의 한글 status 값('서류전형' 등)은 읽기 시 매핑 표로 영문 키로 정규화하는 하위호환 규칙을 명시하고, 마이그레이션 방식은 INFRA-5 결정을 따른다. (4) watching 채택 시: add에 '관심 등록' 경로(공고 전 목표 기업, careers_url·last_checked 선택 필드)와 calendar에 '상시 모니터링 목록' 블록('🔍 [회사명] — 채용페이지 확인 (마지막 확인: N일 전)' + 확인 후 job-search 연계 안내)을 추가한다. (5) JSONL 예시의 status 값과 stats의 상태별 분포 예시를 확정 모델 기준으로 갱신한다. 수시채용 비율 등 시장 수치는 본문에 쓰지 않는다(근거 수치는 실행 시 WebSearch 확인).

**완료 판정:**
- add와 update의 상태 선택지 목록이 SKILL.md에서 동일하고 '지원철회' 선택지가 존재한다
- 영문 키↔한글 표시 매핑 표와 '기존 한글 status 읽기 시 정규화' 규칙이 SKILL.md에 존재한다
- JSONL 예시·stats 분포 예시의 status 값이 확정 상태 목록과 일치하고 watching 관련 필드(careers_url, last_checked)가 스키마에 정의돼 있다

### TRK-3 · 7일 정체 넛지 — PROACTIVE 게이트 + last_nudged_at 저장 명시  `[P0/S]` · 의존: INFRA-5, INFRA-4

'명령 감지' 아래 '정체 감지' 섹션을 신설한다. 스킬 진입 시(모든 하위 명령 공통) updated_at이 7일 이상 지난 진행중 구간(TRK-1 확정 모델의 applied~면접 단계) 항목을 감지해 '📋 [회사명] 지원 N일째, 결과 업데이트할까요?'를 먼저 출력하고 update로 유도한다. 검증 수정방향 반영 2건: (1) PROACTIVE=false면 넛지 자체를 생략한다는 게이트를 명시(제안 규칙과 정합) (2) '7일마다 반복'을 성립시키기 위해 항목별 last_nudged_at 필드를 JSONL 스키마에 추가하고, 넛지 출력 시 갱신·last_nudged_at 7일 미경과 항목은 재출력 금지·사용자가 '나중에' 선택 시 해당 세션 내 재출력 금지 규칙을 적는다. 프리앰블 bash에는 awk로 7일 경과 진행중 항목 수를 세어 'STALE_COUNT=' 한 줄만 emit하도록 추가한다(ACTIVE_SESSIONS/PROACTIVE/SKILL_NAME 3변수 불변식은 그대로 유지).

**완료 판정:**
- '정체 감지' 섹션에 PROACTIVE=false 생략 규칙과 last_nudged_at 갱신·재출력 억제 규칙이 SKILL.md에 존재한다
- 프리앰블이 STALE_COUNT를 emit하고 test/test-preambles.sh가 통과한다
- updated_at 7일 경과 진행중 항목이 있는 상태로 재실행 시 넛지 문구가 출력된다(PROACTIVE=true일 때)

### TRK-2 · list 출력 상태별 그룹핑 재편 (watching 그룹 포함)  `[P1/S]` · 의존: INFRA-5

list 섹션의 플랫 테이블 예시를 상태 그룹 구조로 교체한다: ✅ 진행중(면접 단계), ⏳ 대기중(준비중·지원완료·결과 대기), ❌ 종료(최종합격·불합격·철회). watching 상태가 확정 모델에 포함되면 🔍 관심 그룹을 별도로 두어 문서 내부 불일치를 없앤다(검증 지적 반영 — 그룹 정의는 TRK-1 확정 모델 기준으로 작성). 각 그룹 내 마감일/updated_at 순 정렬, 그룹 헤더에 건수 표시. 하단 요약줄에 '합격률: 서류 X% → 면접 Y%' 전환율 한 줄을 추가해 stats와 연결. 항목 5건 이하일 때는 테이블 대신 ▸ 마커 리스트로 출력한다는 조건을 명시한다(모바일 가독성).

**완료 판정:**
- list 출력 예시가 상태 그룹(진행중/대기중/종료, watching 채택 시 관심 포함) 구조로 SKILL.md에 존재하고 그룹 구성이 TRK-1 상태 모델과 일치한다
- '5건 이하는 ▸ 마커 리스트' 조건과 전환율 요약 한 줄이 SKILL.md에 존재한다

### TRK-4 · PROACTIVE 소비 규칙 — tracker 진입 시 직전 맥락 기반 추적 제안  `[P1/S]`

'보이스' 섹션 위에 '추적 제안 규칙 (PROACTIVE=true일 때)' 섹션을 신설하되, 검증 수정방향대로 조건을 재정의한다: 원안의 'company-research·첨삭 직후 제안'은 tracker 프롬프트가 그 시점 컨텍스트에 없어 작동 불가하므로 (1) tracker 진입 시 직전 대화 맥락에 특정 기업의 분석 결과나 그 공고용 첨삭 결과가 있으면 '이 지원 건을 트래커에 추가할까요?'를 제안 (2) 여러 회사가 동시에 언급된 맥락에서는 제안 금지(오등록 방지) (3) PROACTIVE=false면 제안 자체를 생략 — 으로 기술한다. 이로써 프리앰블이 emit하는 PROACTIVE 값이 본문에서 실제 소비된다(현재 dead code 상태 해소). company-research 완료 직후의 능동 제안은 company-research SKILL.md의 다음 스킬 추천 블록으로 이관한다(타 스킬 작업으로 별도 처리).

**완료 판정:**
- '추적 제안 규칙' 섹션에 진입 시 직전 맥락 조건·복수 기업 금지·PROACTIVE=false 생략 3규칙이 SKILL.md에 존재한다
- SKILL.md 본문에서 PROACTIVE 변수를 참조하는 지시가 1곳 이상 존재한다

### TRK-5 · fit_score 연계 — 출처 점수 특정 + 최소 표본 가드  `[P1/M]` · 의존: INFRA-1

JSONL 스키마에 선택 필드 2개를 추가한다: fit_score(company-research Phase 4가 산출하는 '종합 적합도' 점수 — 복수 점수 중 어느 값인지 검증 지적에 따라 명시), research_ref(~/.jobstack/company-cache/ 파일명). add 흐름 마지막에 '해당 회사의 기업분석 캐시가 있으면 종합 적합도 점수를 자동 연결한다'는 지시를 추가한다. list/stats 출력에서 fit_score가 있는 항목은 점수를 병기한다. stats의 '적합도 상위 vs 하위 서류합격률' 비교는 검증 수정방향대로 최소 표본 조건을 건다: 상·하위 각 그룹에 결과 확정 건이 3건 이상일 때만 출력하고, 미만이면 해당 줄을 생략한다(소표본 노이즈 방지). 공고 본문 미확보 등으로 점수가 없는 건은 '-'로 표기하고 절대 추정치를 넣지 않는다는 가드를 명시한다.

**완료 판정:**
- fit_score가 'company-research 종합 적합도'를 가리킨다는 정의와 research_ref 필드가 SKILL.md 스키마에 존재한다
- '각 그룹 3건 이상일 때만 상·하위 전환율 비교 출력' 조건이 stats 섹션에 존재한다
- '점수 미확보 시 - 표기, 추정치 금지' 가드 문장이 SKILL.md에 존재한다

### TRK-6 · 완료 상태 4종 정렬 + 상태 전환 직후 다음 스킬 추천  `[P2/S]`

원안 채택(검증: 그대로 채택 가능). '완료 상태' 섹션을 templates/completion-status.md 기준 4종(DONE / DONE_WITH_CONCERNS / BLOCKED / NEEDS_CONTEXT)으로 교체한다. update 섹션 4번 단계 뒤에 '다음 스킬 추천' 분기를 삽입한다: 불합격/철회로 업데이트 직후 → '/retro로 이번 지원을 복기할까요?', 서류합격으로 업데이트 직후 → '/mock-interview 준비할까요?', 마감 임박(D-7 이내) 항목 존재 시 → '/cover-letter 마무리' 제안. 상태 전환 시점이 다음 행동 제안의 최적 타이밍이라는 '맥락 직후에만 제안' 원칙을 따르며, TRK-4와 동일하게 PROACTIVE=false면 추천을 생략한다.

> ⚠️ **main 재조정 (needs_adjust)**: 추천 명령을 /mock_interview·/cover_letter 언더스코어로 표기(test-command-style.sh). /retro는 동일. 분기 로직 자체는 유효.

**완료 판정:**
- 완료 상태 4종(DONE/DONE_WITH_CONCERNS/BLOCKED/NEEDS_CONTEXT)이 SKILL.md에 존재한다
- update 섹션에 불합격→/retro, 서류합격→/mock-interview, D-7→/cover-letter 분기가 존재한다

### TRK-7 · calendar KST 기준 명시 + 마감 경과 그룹 + JSONL 원자적 재저장  `[P2/S]` · 의존: INFRA-1

원안 채택(검증: 그대로 채택 가능). calendar 섹션에 규칙 2줄을 추가한다: (1) D-day 계산 전 반드시 `date` 명령으로 KST 오늘 날짜를 확인하고 출력 상단에 '기준일: YYYY-MM-DD (KST)'를 명시한다(훈련 데이터 날짜로 계산 금지 — INFRA-1 가드레일과 정합) (2) 마감일이 지난 항목은 캘린더에서 제외하지 않고 '⚠️ 마감 경과 — 결과 확인 필요' 그룹으로 분리 표시해 update로 유도한다. update 섹션 4번의 '전체 파일을 읽어 수정 후 다시 저장' 지시에 '임시 파일에 쓴 뒤 mv로 교체(쓰기 중단 시 원본 보존)' 방식을 명시해 비원자적 재저장으로 인한 데이터 전손 위험을 막는다.

**완료 판정:**
- calendar 섹션에 '기준일: YYYY-MM-DD (KST)' 명시 규칙과 마감 경과 그룹 규칙이 존재한다
- update 섹션에 '임시 파일 작성 후 mv 교체' 지시가 존재한다

### TRK-8 · 탈락 후 권리 체크리스트 + notes 제3자 PII 최소화 (신규, round2)  `[P2/S]` · 의존: INFRA-1

round2 채굴(채용절차법·개인정보보호법 리서치, PII 3등급 정책)을 반영한 신규 항목. update에서 불합격/철회로 전환 시 선택 안내 블록 '탈락 후 권리 체크리스트'를 추가한다: ①채용서류 반환 청구권(구인자는 청구일부터 14일 내 반환 의무, 청구 기간은 기업이 고지) ②AI 서류평가·AI 면접 등 자동화 결정에 대한 거부·설명요구권 ③채용심사비용 전가 금지 ④접수·결과 통지 의무 존재(제재는 제한적). 단서 2개 명시: 상시 30명 미만 사업장은 법 적용이 안 될 수 있음을 안내하고, 법 개정 여부(공정채용법 추진 등)는 단정하지 말고 실행 시 WebSearch로 현행 여부를 확인한다. 또한 notes 필드 사용 규칙에 '인사담당자 등 제3자의 연락처·이메일은 저장하지 않는다(이름·역할까지만)'는 PII 최소화 문장을 추가한다.

**완료 판정:**
- 불합격/철회 전환 분기에 권리 체크리스트 4항목과 30인 미만 단서·WebSearch 확인 규칙이 SKILL.md에 존재한다
- notes 필드의 제3자 PII 최소화 규칙이 SKILL.md에 존재한다

### TRK-9 · 명령 감지 완료 후 텔레메트리 후속 이벤트 기록 (신규, round2)  `[P2/S]` · 의존: INFRA-10

INFRA-10 텔레메트리 확장 규격을 tracker에 적용한다. '명령 감지' 섹션 끝에 지시 1줄 추가: 하위 명령 감지가 끝나면 Claude가 ~/.jobstack/analytics/skill-usage.jsonl에 후속 이벤트 1건을 append한다 — 필드는 INFRA-10 규격(skill, ts, event=detected, 감지된 하위 명령명 등)을 따른다. 진입 이벤트(프리앰블 자동 기록)와 구분되는 detected 이벤트가 쌓이면 '트래커를 열었지만 아무 명령도 안 쓰는' 이탈 지점을 측정할 수 있다(실사용 데이터에서 트래커 전환율이 낮게 관측된 문제의 계측 기반).

**완료 판정:**
- '명령 감지' 섹션에 detected 이벤트 append 지시가 INFRA-10 규격 참조와 함께 존재한다
- 스킬 실행 후 skill-usage.jsonl에 event=detected 라인이 추가된다

### 제외·기구현 (3건)
- **TRACK_SUGGEST 원안 일부 — 'company-research·첨삭 직후 트래커 추가 제안'을 tracker SKILL.md에 기술**: 검증에서 실현 불가 판정 — tracker 프롬프트는 tracker 호출 세션에만 로드되어 company-research 실행 직후 시점에 존재하지 않음. 해당 제안 로직은 company-research SKILL.md의 다음 스킬 추천 블록으로 이관(tracker 측은 TRK-4로 조건 재정의).
- **jobclaw 8상태 목록을 그대로 canonical로 채택 (final·offer 별개 유지)**: 검증에서 원안 본문의 8상태(준비중 포함, final 없음)와 인용 근거(final·offer 별개)가 불일치 — canonical 정의는 INFRA-5에서 watching 포함 여부·final/offer 처리·마이그레이션 규칙과 함께 확정 후 TRK-1로 반영.
- **수시채용 비율 등 시장 통계의 SKILL.md 본문 기재**: 시장 수치·연도 하드코딩 금지 규칙에 따라 본문에서 제외. 상시 모니터링 개념 자체는 TRK-1의 watching 경로로 반영되며, 근거 수치는 실행 시 WebSearch로 확인.

## company-research → v0.3.0 (12건)

### CR-1 · 공고 본문 미확보 시 적합도 점수 산출 금지 게이트  `[P0/S]`

Phase 4 도입부에 게이트 규칙 추가: "Phase 1에서 채용공고 원문(자격요건·우대사항 전문)을 확보하지 못한 경우 직무적합도·역량매칭도 점수를 산출하지 않는다. '공고 본문 필요'로 표시하고 사용자에게 공고 본문 붙여넣기를 요청한다. 사용자가 붙여넣은 공고 본문은 정식 입력으로 인정하고 스코어링을 진행한다." Phase 1에 수치 검증 규칙 추가: "실시간 WebSearch/WebFetch로 확인한 값만 단정 서술. 미확보 수치는 '(출처 미확보)' 표기, 확인된 수치는 출처 URL을 인라인 병기." Phase 5 리포트 '4. 적합도 스코어링' 섹션에 '공고 미확보 시 이 섹션은 생략되고 사유가 표기된다' 조건 명시. (검증 판정: 원안 그대로 채택)

> ⚠️ **main 재조정 (partially_done)**: Phase 1 수치 검증은 #121(main)로 기구현: '기업 사실 수치 출처강제 + (출처 미확보) 표기 + 출처 인라인' 블록 존재. 잔여: Phase 4 '공고 본문 미확보 시 점수 산출 금지+붙여넣기 요청' 게이트와 Phase 5 생략 조건 — 신설 #122 결정성 블록('근거 부족' 배지, 미확보 값 점수 제외)과 어휘 정합해 삽입.

**완료 판정:**
- Phase 4 도입부에 '공고 원문 미확보 시 점수 산출 금지 + 붙여넣기 요청' 규칙이 SKILL.md에 존재한다
- 공고 검색이 실패한 입력으로 재실행 시 점수 대신 '공고 본문 필요'와 붙여넣기 요청이 출력된다
- Phase 5 리포트 구조에 스코어링 섹션 생략 조건이 명시되어 있다

### CR-2 · 도구 실패 안내: 원인 1줄 명시 + 필요 자료 요청 병기  `[P0/S]` · 의존: INFRA-1

Phase 1 'WebSearch/WebFetch 차단 시 처리 규칙' 블록의 "채용공고는 네트워크 차단으로 조회 불가 — 직접 확인 필요" 문구를 교체: "실패 원인을 1줄로 명시하되, 반드시 다음 행동을 병기한다: '채용공고 본문·CEO 신년사·인재상 페이지 내용을 붙여넣어 주시면 분석을 완성합니다'". 원칙 한 줄 추가: "도구 한계를 막다른 안내로 끝내지 않는다 — 원인 1줄 + 필요 자료 요청을 항상 함께 제시한다." (원안의 '한계 노출 금지' 절대 규칙은 삭제 — BLOCKED/DONE_WITH_CONCERNS의 원인 기술 의무와 충돌하므로 병기형으로 완화, 검증 수정방향 ② 반영.) 사용자가 붙여넣은 자료(공고 본문·신년사·잡플래닛 리뷰 텍스트)를 각 Phase의 정식 입력 소스로 인정하는 규칙 명시. templates/guardrails.md의 '한계 노출→자료 요청 전환' 규칙을 참조 문구로 연결.

**완료 판정:**
- '네트워크 차단으로 조회 불가 — 직접 확인 필요' 문구가 SKILL.md에 존재하지 않는다
- '원인 1줄 + 필요 자료 요청 병기' 원칙과 붙여넣은 자료의 정식 입력 인정 규칙이 SKILL.md에 존재한다
- 완료 상태 프로토콜(BLOCKED 원인 기술 의무)과 충돌하는 '노출 금지' 표현이 없다

### CR-3 · 재무 5지표 판별표 — 업종 편차 단서 + 비상장 폴백  `[P1/M]` · 의존: INFRA-1

Phase 1 검색 대상 2번 확장: 매출·영업이익·직원수에 부채비율, 영업이익률, 매출증가율(3년 추이), 유동비율, ROE 추가 수집. Phase 5 '1. 기업 개요'에 '재무 건전성' 소섹션 추가: 5지표 표(값·일반 기준·판정 O/△/X·출처 URL) + 한 줄 종합 판정. 수정 반영 3건: ①표 상단 고정 단서 "임계값은 일반 기준 — 업종별 편차가 크므로 반드시 동종업계 평균 대비로 해석" ②업종 평균 수치는 SKILL.md에 기재하지 않고 실행 시 WebSearch로 확인하도록 지시(예: "{업종} 평균 영업이익률" 검색) ③비상장·중소기업으로 5지표 중 3개 이상 미확보 시 판별표 생략, "재무 판별 불가(비공시) — 잡플래닛 리뷰·최근 뉴스로 대체 판단" 폴백 1줄. 미확보 지표는 '(출처 미확보)' 표기하고 판정에서 제외. (rationale에만: 부채비율 ≤100%·유동비율 ≥200%·ROE ≥10% 등은 네이버 vs 위메이드 판별에 쓰인 검증 기준 — 둘 다 IT 상장사라 일반화 범위가 좁아 단서 필수)

**완료 판정:**
- Phase 1 항목 2에 5개 추가 지표가, Phase 5에 '재무 건전성' 소섹션이 SKILL.md에 존재한다
- '업종별 편차' 단서와 비상장사 판별 생략 폴백 규칙이 존재한다
- SKILL.md 본문에 특정 업종 평균 수치(예: IT 평균 %)가 하드코딩되어 있지 않다 (INFRA-7 린트 통과)

### CR-4 · Phase 4.5 지원 판단 — 보상 축 공백 처리 + 스킬 경계 명시  `[P1/M]`

Phase 4와 5 사이에 'Phase 4.5 — 지원 판단' 신설. 5기준 트레이드오프 표(보상·성장 가능성·기술스택 적합·직무 적합·브랜드)로 정리하되, 수정 반영: 보상 축은 이 스킬이 연봉 데이터를 수집하지 않으므로 "(미수집 — /salary 참조)" 고정 표기 규칙 명시. 스코어링+재무 건전성+GAP을 근거로 '지원 권장 / 조건부 지원(보완 전략 병행) / 신중 검토' 3단계 판단을 근거와 함께 제시. 기존 문구 보완: "점수가 낮다고 '지원하지 마세요'라고 말하지 않되, 판단을 회피하지도 않는다 — 낮은 판단에는 반드시 보완 전략과 재도전 조건을 함께 제시한다." 경계 문구 추가: "복수 기업 지원 우선순위는 /strategy의 Tier 분류, 합격 후 오퍼 비교는 /salary 소관 — 여기서는 지원 전 단일 기업 판단만 다룬다." Phase 5 리포트 구조에 '6. 지원 판단' 섹션 추가.

> ⚠️ **main 재조정 (needs_adjust)**: main #122가 Phase 4에 '적합도 60% 미만 시 초기 GAP 요약+대안 제시'를 이미 추가 — Phase 4.5 3단계 판단은 이 문장과 중복 없이 통합(어느 쪽이 판단 주체인지 단일화). /salary·/strategy 경계 문구는 유효.

**완료 판정:**
- Phase 4.5 섹션과 3단계 판단 규칙이 SKILL.md에 존재한다
- 보상 축 '(미수집 — /salary 참조)' 처리 규칙과 strategy/salary 경계 문구가 존재한다
- 동일 입력 재실행 시 리포트에 '6. 지원 판단' 섹션이 근거와 함께 출력된다

### CR-5 · 전형 방식 확인 항목 — 연도·기업명 하드코딩 없이 검색 확인 목록으로  `[P1/M]` · 의존: INFRA-1

Phase 1 검색 대상에 7번 '전형 방식' 추가 — 모든 항목은 실행 시 WebSearch로 확인하며 연도·도입 기업명·전형명은 SKILL.md에 하드코딩하지 않는다: ①AI 서류평가 도입 여부(도입 확인 시 표절·AI작성 검사 대비 안내) ②AI역량검사·화상면접 툴 사용 여부(도입 확인 시 무료 연습 경로를 검색해 안내) ③컬처핏 면접 단계 유무 ④대기업이면 그룹 공통 전형(적성검사 명칭, 인턴십 연계 여부)을 검색으로 확인 ⑤해당 기업이 수시/공채 중 어느 방식인지 1줄만 확인 — 채용 캘린더·공고 모니터링은 /job-search 핸드오프로 안내. 검색어 패턴에 "{COMPANY} AI역량검사", "{COMPANY} 채용 전형 절차" 추가. Phase 5 '5. 자소서/면접 활용 가이드' 안에 '전형 대비 체크' 소섹션 추가. (rationale에만: ATS/AI 서류평가·AI역량검사·컬처핏 도입률 통계와 그룹별 전형 상이 — 시점 고정 수치라 본문 기재 금지)

> ⚠️ **main 재조정 (needs_adjust)**: 항목 ⑤ 핸드오프 문구는 /job_search 언더스코어 표기(test-command-style.sh). 나머지 5개 확인 항목은 유효.

**완료 판정:**
- Phase 1 검색 대상 7번 '전형 방식' 5개 확인 항목이 SKILL.md에 존재한다
- SKILL.md 본문에 특정 연도·AI전형 도입 기업명·그룹 적성검사명이 하드코딩되어 있지 않다 (INFRA-7 린트 통과)
- 항목 ⑤에 /job-search 핸드오프 문구가 존재한다

### CR-6 · 키워드 배치 원칙 + 반영률 기준 cover-letter 통일 + 매칭 3단계  `[P1/S]`

Phase 2에 추가: ①"소스당 반복 키워드 3~5개를 추출하고, 그중 핵심 3개를 '경험을 해석하는 기준'으로 표시한다" ②정량 목표는 신설하지 않고 참조 문구로 통일: "이 체크리스트는 /cover-letter의 반영률 게이트(목표 85%+, 70% 미만 시 우려사항 있는 완료) 기준으로 소비된다" — 원안의 '30개→50%+' 대안 기준은 cover-letter 게이트와 충돌하므로 기각(검증 수정방향 ④) ③'활용 전략' 열 작성 규칙 추가: "키워드는 구체적 경험 근거 뒤에 배치하도록 제안한다. 한 문단에 키워드를 몰아넣는 전략은 제안 금지(자소서≠SEO — ATS의 자연어 처리 진화로 keyword stuffing은 무력화됨)" ④'내 매칭' 열 판정을 O/X에서 O/모호/X 3단계로 변경(round2: E2E 검증에서 반영률 판정 3단계로 작동).

**완료 판정:**
- Phase 2에 cover-letter 반영률 게이트 참조 문구가 존재하고 '30개→50%' 기준이 SKILL.md에 없다
- 키워드 배치 원칙(근거 뒤 배치, 몰아넣기 금지)이 '활용 전략' 열 규칙에 존재한다
- 키워드 체크리스트 테이블의 '내 매칭' 열이 O/모호/X 3단계로 정의되어 있다

### CR-9 · 공고 URL/JD 원문 직접 입력 진입점  `[P1/S]`

Phase 0 확장: 인자나 대화에 채용공고 URL 또는 JD 원문 붙여넣기가 포함된 경우를 정식 진입 패턴으로 명시. URL이면 WebFetch로 원문 확보, 원문 텍스트면 그대로 Phase 1 항목 3의 '확보된 공고'로 인정하고 기업명·직무를 원문에서 추출한다(불명확 시 AskUserQuestion 1회). 이 경로에서는 Phase 1의 공고 검색을 생략하고 나머지 항목(개요·재무·CEO·뉴스·평판)만 수집. 이미지 공고 파싱 실패 시 "텍스트로 복사해 붙여넣어 주세요" 폴백 안내 1줄 추가. (round2: JD 원문 통째 붙여넣기가 실사용 반복 워크플로우 — 공고 파싱→키워드→체크리스트→스코어 파이프라인의 진입점 강화)

**완료 판정:**
- Phase 0에 공고 URL/JD 원문 입력 진입 패턴과 기업명·직무 추출 규칙이 SKILL.md에 존재한다
- JD 원문을 붙여넣은 입력으로 실행 시 공고 재검색 없이 Phase 2 키워드 추출로 진행된다
- 이미지 공고 파싱 실패 폴백 안내 문구가 존재한다

### CR-11 · 캐시 파일 상단 요약 블록 — 후속 스킬 주입용 (1500자 이내)  `[P2/S]`

Phase 5 캐시 파일(~/.jobstack/company-cache/{COMPANY}-{TODAY}.md) 최상단에 재사용용 요약 블록 규격 추가: 회사명(느슨 매칭용 정규화 키: 공백 제거·소문자), 직무, 핵심 키워드 5~10개, '이미 팀원처럼' 화두 3개, 적합도 종합 1줄 — 전체 1500자 이내. 목적: mock-interview 등 후속 스킬이 파일 앞부분만 읽어 개인화 질문 컨텍스트로 주입할 수 있게 함(round2: jobclaw interview-context의 느슨 매칭+1500자 상한 패턴을 ~/.jobstack/ 상태파일로 재현하는 크로스 스킬 연계). 요약 블록 아래에 기존 전체 리포트 본문 유지.

> ⚠️ **main 재조정 (needs_adjust)**: 캐시 경로를 ~/.jobstack/company-cache가 아닌 $_JS_STATE/company-cache/{COMPANY}-{TODAY}.md로 표기 — test-no-home-paths.sh가 ~/.jobstack 본문 표기를 FAIL 처리(main이 해당 경로를 이미 $_JS_STATE로 치환함). 요약 블록 규격 자체는 유효.

**완료 판정:**
- Phase 5에 캐시 요약 블록 규격(정규화 키, 1500자 상한 포함)이 SKILL.md에 존재한다
- 동일 입력 재실행 시 생성된 캐시 파일 상단에 요약 블록이 출력된다

### CR-12 · 공공기관 분기 — 전용 소스 안내 + 필기 유형 검색 확인 + /ncs 핸드오프  `[P2/S]` · 의존: INFRA-1

Phase 1 도입부에 분기 규칙 추가: 대상이 공공기관·공기업이면 ①채용정보 검색 소스로 잡알리오(job.alio.go.kr, 중앙 공공기관)·클린아이 잡플러스(job.cleaneye.go.kr, 지방 공공기관)를 우선 사용 ②필기 유형(모듈형/PSAT형/피듈형)과 출제 대행사를 실행 시 WebSearch로 확인해 '전형 대비 체크'에 기재 — 대행사별 경향은 훈련데이터로 단정하지 않고 검색 확인 값만 사용 ③지역인재 채용 목표제 적용 여부 확인 ④NCS 필기 상세 대비는 /ncs 핸드오프. Phase 5 활용 가이드에 "공공기관은 자소서 재활용이 감점 요인 — 기관별 맞춤 필요" 1줄 추가. (rationale에만: 비수도권 공공기관 신입 71%가 지역인재 채용 — 시점 수치라 본문 기재 금지)

> ⚠️ **main 재조정 (needs_adjust)**: '/ncs 핸드오프'는 test-command-style.sh 금지 대상(봇 미노출). NCS 필기 안내는 /cover_letter 공기업 보강으로 연결하거나 CLI 한정 표현으로 재설계. 잡알리오/클린아이 소스·지역인재 확인은 유효.

**완료 판정:**
- Phase 1에 공공기관 분기(잡알리오/클린아이 소스, 출제사 검색 확인, /ncs 핸드오프)가 SKILL.md에 존재한다
- 지역인재 비율 등 시점 고정 통계 수치가 SKILL.md 본문에 없다 (INFRA-7 린트 통과)

### CR-13 · 평판·리뷰 수집 PII 가드레일  `[P2/S]` · 의존: INFRA-1

Phase 1 검색 대상 6번(기업 평판)과 Phase 3 앱/웹 분석 경로의 리뷰 분석 항목에 규칙 1줄 추가: "잡플래닛/블라인드/앱스토어 리뷰를 인용할 때 작성자 닉네임·프로필 등 식별정보는 리포트·캐시에 기록하지 않는다 — 집계 요약(불만 Top 3, 키워드 빈도)과 익명 인용만 사용한다." templates/guardrails.md의 PII 규칙을 참조 문구로 연결. (round2: 공개 게시판 모니터링 가드레일 — 제목/집계만 수집, 작성자 식별자 수집 금지 원칙을 기업 평판 수집에 적용)

**완료 판정:**
- 리뷰 인용 시 작성자 식별정보 기록 금지 규칙이 Phase 1과 Phase 3에 존재한다
- 동일 입력 재실행 시 리포트의 리뷰 인용에 닉네임 등 식별정보가 포함되지 않는다

### CR-7 · 비교군 2~3사 — 기존 경쟁 분석 항목 확장·통합 (세 경로 대칭)  `[P2/S]`

신규 4.5 항목이 아니라 기존 항목 확장으로 수정(검증 수정방향 ⑤): 산업 분석 경로 4번 '경쟁 환경 분석'을 "경쟁 환경 분석 + 지원 후보군 확장 관점 비교군 2~3사(대상 기업의 상대적 위치를 규모·기술·평판 1줄씩)"로 확장·통합. 앱 분석 경로 3번(경쟁 앱 대비)과 웹 분석 경로 4번(경쟁사 대비)에도 동일하게 "비교군 2~3사(지원 후보군 관점 — 경쟁 제품 분석과 목적 구분)"를 병기해 세 경로 대칭 적용. Phase 5 '3. 이미 팀원처럼 브리핑'에 '업계 내 위치' 3~4줄 소섹션 추가. 다음 스킬 추천에 "비교군 기업도 분석하려면 /company-research 재호출" 추가. 비교군 기업명 예시는 본문에 하드코딩하지 않고 실행 시 검색으로 식별.

> ⚠️ **main 재조정 (needs_adjust)**: '비교군 기업도 분석하려면 /company-research 재호출' 문구는 /company_research 표기 필수. 확장·통합 설계는 유효.

**완료 판정:**
- 산업 분석 경로에 별도 4.5 항목 없이 기존 4번이 비교군 포함으로 확장되어 있다
- 앱/웹/산업 세 경로 모두에 '지원 후보군 관점 비교군 2~3사' 문구가 존재한다
- 리포트 브리핑 섹션에 '업계 내 위치' 소섹션이 존재한다

### CR-8 · /salary 핸드오프 한 줄 추가 (신뢰도 규칙 본문은 이관)  `[P2/S]`

완료 상태 프로토콜의 '다음 스킬 추천'에 한 줄 추가: "연봉 수준 확인·협상 준비가 필요하면 -> /salary 추천: 연봉 데이터는 소스·시점별 편차가 크므로 단일 소스로 단정하지 않습니다." 소스 신뢰도 상세 규칙(크레딧잡 역추정 과소, 잡플래닛 인증 중앙값, 원티드인사이트 종료 등)은 이 스킬에 넣지 않는다 — salary/SKILL.md Phase 2-3 소관으로 이관(검증 수정방향 ⑥). company-research Phase 1 항목 6은 현행대로 평판·면접 후기 수집만 유지.

**완료 판정:**
- 다음 스킬 추천에 /salary 항목이 SKILL.md에 존재한다
- 크레딧잡/원티드인사이트 등 연봉 소스 신뢰도 상세 규칙이 company-research SKILL.md에 존재하지 않는다

### 제외·기구현 (6건)
- **연봉 소스 교차 검증 규칙 본문 (크레딧잡 역추정 과소·원티드인사이트 종료 등)**: 역할 중복 — salary/SKILL.md에 이미 교차 검증 규칙이 있고 상세 신뢰도 규칙이 필요한 곳도 salary 쪽. company-research는 연봉을 수집 항목으로 두지 않아 발동 조건이 없음. /salary 핸드오프만 남기고(CR-8) 본문은 salary 작업서로 이관. '원티드인사이트 종료' 같은 시점 고정 사실의 박제도 낡음 위험.
- **키워드 정량 대안 기준 '총 30개 추출 후 50%+ 반영'**: cover-letter의 기존 게이트(목표 85%+, 70% 미만 DONE_WITH_CONCERNS)와 스킬 간 기준 충돌 — 대기업 분석 시 50% 달성해도 cover-letter가 우려사항 완료로 판정하는 모순 발생. cover-letter 기준 참조로 통일(CR-6). 배치 원칙(근거 뒤 배치, stuffing 금지)만 채택.
- **'도구 한계 노출 금지' 절대 규칙**: 완료 상태 프로토콜(BLOCKED=차단 요인 기술, DONE_WITH_CONCERNS=우려사항 명시)과 정면 충돌. 실패 원인을 숨기면 '데이터 없음'과 '조회 실패'를 구분 불가. '원인 1줄 명시 + 필요 자료 요청 병기'로 대체(CR-2).
- **'2026' 연도·AI전형 도입 기업명·그룹별 전형명(GSAT/SKCT 등) 하드코딩**: 매년 낡는 시점 고정 정보의 SKILL.md 박제 — 스킬의 기존 원칙(훈련데이터 금지, 실시간 검색 확인)과 모순. '실행 시 WebSearch로 확인할 항목 목록'으로 재구성(CR-5). 통계·기업명은 rationale에만 유지.
- **채용 캘린더·수시/공채 사이클 상세 수집**: job-search의 '공채/수시 캘린더' 소관과 중복. 단일 기업의 채용 방식 1줄 확인으로 축소하고 캘린더성 정보는 /job-search 핸드오프로 처리(CR-5 항목 ⑤).
- **CR-10 프리앰블 stale PID 루프 문법 오류 수정 + 표준 패턴 동기화**: main에서 기구현 — main 전 스킬 프리앰블 핫픽스(055646a 계열)로 stale 루프 리다이렉트 제거 완료(for _f in "$_JS_STATE/sessions/"*;), trap EXIT 유지, test-preambles.sh company-research PASS 확인. ba

## portfolio → v0.2.0 (8건)

### PF-1 · 수치 날조 방지 가드 + 수치 폴백 4종 추가  `[P0/S]` · 의존: INFRA-1, INFRA-2

Phase 3 '프로젝트 임팩트 리라이팅' 상단에 굵은 가드 문구 추가: "수치는 사용자가 제공했거나 세션에서 확인된 것만 사용한다. 확인 안 된 수치는 만들어 넣지 않고 '[수치 확인 필요]' placeholder + 질문 1회로 처리한다" (templates/guardrails.md 참조 지시 포함). 이어서 '수치가 없을 때' 하위 절 신설 — templates/experience-methods.md의 대체 4종(범위: 담당 모듈 수 / 빈도: 주간 배포 횟수 / 전후비교: 수동→자동 / 담당규모: 4인 팀 BE 리드)을 인용하고, 판정 기준으로 "면접에서 산출 과정을 설명할 수 있는 숫자인가"를 명시. 기존 변환 예시 3개('40% 절감' 등)는 유지하되 "예시일 뿐이며 사용자 실제 데이터로만 채운다" 주석 추가.

**완료 판정:**
- Phase 3에 '[수치 확인 필요]' placeholder + 1회 질문 규칙이 존재한다
- '수치가 없을 때' 절에 대체 4종(범위·빈도·전후비교·담당규모)과 '면접 설명 가능성' 판정 기준이 존재한다
- 기존 변환 예시 3개 옆에 '예시일 뿐, 실제 데이터로만 채운다' 주석이 존재한다

### PF-2 · '판단의 증거' 프레임 + 증거 6종 체크리스트 도입 (RAG·LLM 점검은 조건부로 수정)  `[P0/M]`

Phase 1 감사 항목에 증거 6종 점검 추가: ①문제·목표 README ②기능 전후 사용자 흐름 ③테스트·검증 시나리오 ④성능·비용·오류율 중 1개 측정 기록 ⑤AI 제안 중 수정·폐기한 이유 ⑥기술 선택에서 변경·포기한 대안. Phase 4 README 권장 구조의 '아키텍처 / 주요 설계 결정' 섹션을 '설계 판단 (대안 비교 + AI 제안 수정·폐기 이유)'로 확장. Phase 5 체크리스트에 "'따라 만든 프로젝트'와 구분되는 판단의 증거가 있는가?" 항목 추가. [검증 수정 반영] Phase 2의 RAG·LLM 프로젝트 점검은 고정 항목이 아니라 조건부로: "지원 공고/직무 요건에 RAG·LLM 등 해당 기술이 명시된 개발 직군인 경우에만 갭 분석 항목에 추가한다" — Phase 2의 직무 주도 갭 분석 원칙 및 PF-3의 직군 분기와 정합하게.

**완료 판정:**
- Phase 1에 증거 6종 체크리스트 6개 항목이 모두 존재한다
- Phase 4 README 구조에 '설계 판단 (대안 비교 + AI 제안 수정·폐기 이유)' 섹션이 존재한다
- RAG·LLM 점검이 '공고/직무 요건에 명시된 개발 직군인 경우에만'이라는 조건부 문구로만 존재한다 (무조건 점검 항목 없음)

### PF-3 · 직군별 포트폴리오 프레임 분기 (개발/PM/UX + 마케팅, 평가 축 매트릭스 반영)  `[P1/M]`

Phase 4를 '직군별 구조 최적화'로 개편. 개발자 README 템플릿은 유지하되 개발 6요소(제목·데모 링크·기간/인원·스택·핵심 기능·트러블슈팅)에 맞춰 '데모 링크'·'트러블슈팅' 섹션 보강. 그 아래 추가: PM용 6단계(문제정의→리서치→가설→실험→결과→러닝, '3~5분 내 파악+정량지표' 기준, 역기획서 3유형: 신규 기획서/역기획+스토리보드/문제점 분석+개선안), UX용 6항목(문제정의·리서치·솔루션·완성도·본인 역할·결과 회고 + '문제 발견→해결→결과' 케이스스터디 스토리), 마케팅용(기획→실행→성과 구조, 성과 수치 + 기여도 비율 명시, AI 툴 활용 성과 서술 권장). 재무·회계/영업 등 포트폴리오 비중이 낮은 직군은 자격증·경험 중심 평가임을 안내하고 /resume·/strategy로 연결. Phase 2 시작 시 프로필/질문에서 직군 확인, 불명확하면 AskUserQuestion 1회로 개발/PM·기획/UX·디자인/마케팅/기타 중 선택받는 분기 규칙 추가.

**완료 판정:**
- Phase 4에 개발·PM·UX·마케팅 4개 직군 템플릿이 각각 존재한다
- 직군 불명확 시 AskUserQuestion 1회 분기 규칙이 Phase 2에 존재한다
- 포트폴리오 비중이 낮은 직군(재무·회계/영업)의 타 스킬 안내 문구가 존재한다

### PF-4 · Phase 5 꼬리질문 방어 테스트 — 문서 수준 필터로 한정 + /mock-interview 위임 경계 명시  `[P1/S]`

[검증 수정 반영] Phase 5 체크리스트 뒤에 '꼬리질문 방어 테스트' 하위 절 신설하되 범위를 문서 수준 필터로 한정: 핵심 프로젝트 서술마다 공통 5세트 질문(어떤 문제였나/왜 그 방법이었나/역할 범위는/결과를 어떻게 확인했나/다시 한다면)을 적용해 '1분 설명 가능' 여부만 점검하고, 즉답 불가 문장은 위험 표시 후 수정 또는 삭제를 제안한다. 문답 확장·답변 연습·심화 질의응답은 하지 않으며 "실제 답변 연습과 심화 문답은 /mock-interview에 위임한다"는 경계 문구를 1줄 명시(PF-7의 다음 스킬 추천과 연결). 체크리스트에 "블로그·기술 글 링크는 완전히 설명 가능한 것만 노출했는가?" 항목 추가. 기존 '미끼 포인트' 항목 유지 — '답변이 준비된 미끼만 남긴다' 원칙으로 연결.

> ⚠️ **main 재조정 (needs_adjust)**: '/mock-interview에 위임' 경계 문구는 /mock_interview 언더스코어 표기(test-command-style.sh). 내용은 유효.

**완료 판정:**
- '꼬리질문 방어 테스트' 절에 공통 5세트 질문과 '1분 설명 가능' 기준이 존재한다
- '답변 연습·심화 문답은 /mock-interview에 위임' 경계 문구가 존재한다
- 블로그·기술 글 노출 점검 항목이 Phase 5 체크리스트에 존재한다

### PF-5 · 제출 표준 + 사이드 프로젝트 완성도 기준 + 제출 서류 권리 안내 명시  `[P1/S]` · 의존: INFRA-1

Phase 4 끝에 '제출 형태 표준' 절 추가: ①표준 조합은 PDF 이력서 본문 + 노션 포트폴리오 링크 ②노션 페이지 PDF 직출력 제출은 감점 요인이므로 금지 안내 ③링크는 권한(공개 설정)·모바일 렌더링 확인. 같은 절에 권리 안내 2줄 추가: 과제 전형·포트폴리오 제출 시 채용서류 반환 청구권(채용 확정일 이후 청구 가능, 구인자는 14일 내 반환 의무)이 있으며, 아이디어만 수집하는 거짓 채용광고는 채용절차법 위반임을 사용자에게 알릴 수 있다(세부 기간·벌칙 수치는 하드코딩하지 않고 필요 시 WebSearch로 최신 법령 확인). Phase 1 감사와 Phase 5 체크리스트에 사이드 프로젝트 판정 3기준 추가: 완성·배포 여부(배포 URL 존재)/꾸준함(최근 커밋·업데이트)/주인의식(기획~운영 관여 범위). "미완성 프로젝트 나열은 감점 — 3개 완성 > 7개 미완성" 원칙을 Phase 5에 1줄 명시.

**완료 판정:**
- '제출 형태 표준' 절에 PDF+노션 링크 표준과 노션 직출력 금지 안내가 존재한다
- 채용서류 반환 청구권 안내가 존재하고 벌칙 금액 등 수치가 본문에 하드코딩되어 있지 않다
- 사이드 프로젝트 판정 3기준과 '3개 완성 > 7개 미완성' 원칙이 존재한다

### PF-6 · 수시채용·다이렉트소싱 대응 '상시 노출 관리' 절 추가  `[P2/S]` · 의존: INFRA-1

Phase 5 뒤에 짧은 절 '상시 노출 관리' 추가: ①수시채용이 채용의 기본 형태이므로(비율 등 시장 수치는 본문에 하드코딩하지 않고 실행 시 WebSearch로 확인) 포트폴리오는 '공고 발견 후 1주 내 지원 가능 상태'를 유지 ②다이렉트소싱 대비 GitHub 프로필 README·핀 고정 3개·최근 활동을 분기 1회 갱신 ③갱신 체크 항목 5개(핀 프로젝트 최신성/데모 링크 생존/연락 수단/최근 성과 반영/노션 권한). 기존 Phase 4의 '잔디(contribution graph) 활성화 전략 제안' 문장을 이 절로 이동해 통합.

**완료 판정:**
- '상시 노출 관리' 절에 갱신 체크 항목 5개가 존재한다
- 수시채용·다이렉트소싱 비율 등 시장 수치가 SKILL.md 본문에 하드코딩되어 있지 않고 WebSearch 확인 규칙으로 서술된다
- 잔디 활성화 문장이 Phase 4에서 이 절로 이동되어 중복이 없다

### PF-7 · 완료 상태 섹션을 공유 템플릿과 동기화 + 뷰어 안내 + /mock-interview 연계  `[P2/S]` · 의존: INFRA-1

'완료 상태' 섹션을 templates/completion-status.md 기준으로 갱신: ①BLOCKED 정의에 "시간 민감 데이터(공고·기사)는 훈련 데이터로 절대 대체하지 않고 해당 섹션 스킵 후 DONE_WITH_CONCERNS 처리" 규칙 반영 ②결과물(리라이팅된 README, 갭 분석 리포트) 생성 시 jobstack-view 뷰어 사용 안내 문구 추가. '다음 스킬 추천'에 `/mock-interview`(포트폴리오 미끼 기반 꼬리질문 연습 — PF-4의 위임 경계와 연결) 경로를 1줄 추가.

> ⚠️ **main 재조정 (needs_adjust)**: 다음 스킬 추천은 /mock_interview 표기. 완료 상태·뷰어 안내는 templates/completion-status.md(4상태+훈련데이터 금지+뷰어 안내 기존재) 참조로 동기화.

**완료 판정:**
- 완료 상태 섹션에 시간 민감 데이터 훈련데이터 대체 금지 규칙이 존재한다
- 결과물 생성 시 jobstack-view 뷰어 안내 문구가 존재한다
- 다음 스킬 추천에 /mock-interview 경로가 존재한다

### PF-9 · 연구·논문→프로젝트 기술서 변환 경로 추가 (석박사·연구직)  `[P2/S]`

Phase 1 감사에 소재 유형 감지 1줄 추가: 사용자 산출물이 논문·연구 결과물(학위논문, 학회 발표 등)이면 '연구 기술서 변환' 경로로 안내. Phase 3에 하위 절 '연구 산출물 리라이팅' 신설: 논문 구조(초록·방법·실험)를 채용 관점 4단계 '문제정의→방법 선택 이유→본인 기여(공저자 중 역할 범위)→산출물·검증 결과'로 재구성한다. 수치 규칙은 PF-1 가드를 그대로 적용(실험 수치는 논문에 기재된 것만 인용). 근거: 실사용에서 ASR 논문→프로젝트 기술서 변환 수요가 관측되었으나 coverage_gaps로 밀려 미반영 상태였음(context.md critic 지적).

**완료 판정:**
- Phase 1에 논문·연구 산출물 감지 시 변환 경로 안내가 존재한다
- Phase 3에 '문제정의→방법 선택 이유→본인 기여→산출물·검증 결과' 4단계 재구성 절이 존재한다

### 제외·기구현 (2건)
- **Phase 2 갭 분석에 RAG·LLM 프로젝트 보유 여부 고정 점검 항목 추가 (제안 2의 일부)**: 검증 판정: Phase 2의 직무 주도 갭 분석 설계와 충돌하고 PM/UX 트랙에서 무의미하며 근거가 웹 단일 출처로 빈약. 고정 항목은 기각하고 PF-2에서 '공고/직무 요건에 명시된 개발 직군인 경우에만' 조건부로 전환하여 흡수.
- **PF-8 프리앰블 bash 문법 오류 수정 + 신 표준 패턴 동기화**: main에서 기구현 — main에서 portfolio 프리앰블 stale 루프 문법 수정 완료(diff 확인), test-preambles.sh portfolio PASS(3변수 emit+세션 정리). bash -n 통과.

## job-search → v0.5.0 (12건)

### JOB-1 · Phase 5 수시 중심 구조 개편 (공기업·금융권 예외 유지, 수치 하드코딩 금지)  `[P0/M]` · 의존: INFRA-1

Phase 5의 "공채: 정기 채용 일정 (상반기: 3~6월, 하반기: 9~12월)" 프레임을 교체한다. (1) 대기업 신입 채용은 수시가 다수이며 대규모 정기 공채는 '4대그룹 중 삼성이 유일'로 한정 서술("정기 공채는 사실상 삼성이 유일" 단정 금지). (2) 공기업(NCS 기반)·금융권은 상·하반기 정기 공채 운영이 일반적임을 별도 줄로 유지 — 구체 일정은 기관 채용페이지·잡알리오에서 확인하도록 안내. (3) 수시 비율·다이렉트소싱 비중 등 시장 수치와 그룹별 인적성검사(GSAT/SKCT 등) 전형 방식은 SKILL.md 본문에 하드코딩하지 않고 "사용자에게 제시하기 전 WebSearch로 최신 확인, 인용 시 조사 출처·시점 병기" 규칙으로 대체(검색 쿼리 예시 1~2개 포함). (4) 준비 전략을 '공채 시즌 대비'에서 '관심 기업 채용페이지 상시 모니터링 + 구직 플랫폼 프로필 상시 관리'로 전환. (5) 프론트매터 description "공채/수시 캘린더"를 "수시·공채 캘린더"로 조정.

**완료 판정:**
- SKILL.md에 "상반기: 3~6월" 문구가 존재하지 않고, '4대그룹 중 삼성이 유일'과 공기업·금융권 정기 공채 유지 줄이 존재한다
- 수시 54.8% 같은 시장 수치와 GSAT/SKCT 등 기업별 전형 방식이 본문에 하드코딩되어 있지 않고, WebSearch 확인+출처·시점 병기 규칙이 Phase 5에 존재한다 (INFRA-7 린트 통과)
- 프론트매터 description이 "수시·공채 캘린더"로 변경되어 있다

### JOB-2 · 매칭 스코어 산출 가드 — 공고 본문 미확보 시 점수 금지  `[P0/S]`

Phase 4 맨 앞에 가드 블록 추가: "매칭 스코어는 공고 본문(자격요건·우대사항)을 실제 확보(WebFetch/API 응답/사용자 원문 제공)한 공고에만 산출한다. 목록 페이지 데이터(회사명·직무명·마감일·기술태그)만 있는 공고는 점수 대신 '매칭도 미산출 — 본문 미확보'로 표시하고, 사용자가 관심을 표명하면 본문을 가져와 재산출한다." Phase 6 캘린더 출력 예시에 미산출 케이스 1줄 추가 (예: "[회사E] 백엔드 — 매칭 미산출(본문 미확보)"). 검증 결과 원안 그대로 채택.

> ⚠️ **main 재조정 (needs_adjust)**: main #122 스코어 결정성 블록이 Phase 4에 이미 존재('매칭 미상'·'(출처 미확보)' 점수 제외+'근거 부족' 배지). 공고 단위 '본문 미확보 시 점수 금지' 가드는 이 블록의 어휘·배지 체계와 통일해 삽입(별도 용어 신설 금지).

**완료 판정:**
- Phase 4 서두에 '본문 미확보 시 점수 산출 금지' 가드 블록이 존재한다
- Phase 6 출력 예시에 '매칭 미산출(본문 미확보)' 케이스가 존재한다

### JOB-3 · 마감일 기준 날짜 KST 고정 + 기준일·검색 조건 투명 공개  `[P1/S]`

Phase 2 마감 필터링 규칙의 `date +%Y-%m-%d`를 `TZ=Asia/Seoul date +%Y-%m-%d`로 교체하고 "기준 날짜는 반드시 KST(한국시간) 오늘"을 명시, UTC 서버에서 자정~오전 9시 사이 판정이 하루 어긋나는 것을 막는다는 이유를 주석 1줄로 병기. 추가로 Phase 6 캘린더 출력 상단에 "기준일: YYYY-MM-DD (KST) / 검색 조건: 직무·경력·지역" 1줄을 반드시 출력하는 규칙을 넣는다 — '죄다 마감인데 날짜 기준이 뭐냐'는 실불만(마감 관련 불만 5건 반복)에 대한 신뢰 확보 장치.

**완료 판정:**
- SKILL.md의 마감 필터링 규칙에 `TZ=Asia/Seoul date` 와 KST 명시 문구가 존재한다
- Phase 6에 기준일(KST)·검색 조건 1줄 출력 규칙이 존재하고, 캘린더 예시 상단에 해당 줄이 포함된다

### JOB-4 · cover-letter 핸드오프 — tracker 저장 구체화, '자동 전달' 문구 금지  `[P1/M]` · 의존: INFRA-5

(1) Phase 3 추출 표에 '자소서 문항' 행 추가: 공고 본문에 자소서/에세이 문항이 있으면 원문 그대로 추출. (2) Phase 6 tracker 저장 문단 구체화: `$_JS_STATE/tracker/`에 공고별 YAML로 회사명·직무·마감일·URL·추출 키워드·자소서 문항 저장 — 필드명·상태 키는 INFRA-5 canonical 상태 모델을 따른다. (3) '다음 스킬 추천'의 cover-letter 줄을 "관심 공고 확정 → /cover-letter — 이 공고의 키워드·자소서 문항은 tracker에 저장되어 있어 /cover-letter 실행 시 활용 가능" 수준으로 서술한다. 검증 지적 반영: "자동 전달됨" 등 job-search 수정만으로 실현되지 않는 동작을 약속하는 문구는 금지. cover-letter가 tracker를 읽는 로직은 cover-letter 스킬 항목으로 이관.

> ⚠️ **main 재조정 (needs_adjust)**: 전제 변경: Phase 6 tracker 문단이 main에서 '저장 + 봇 네이티브 /track·/myapps 안내'로 교체됨. YAML 필드 구체화는 유효하나 /tracker 스킬 언급 금지(lint), cover-letter 추천 줄은 /cover_letter 표기.

**완료 판정:**
- Phase 3 표에 '자소서 문항' 행이 존재하고, Phase 6에 tracker YAML 필드 목록(회사명·직무·마감일·URL·키워드·자소서 문항)이 명시되어 있다
- SKILL.md에 '자동 전달' 계열 문구가 존재하지 않는다
- 동일 공고 재분석 시 tracker YAML에 동일 필드가 기록된다

### JOB-5 · 회사군(업종) 단위 탐색 모드 — 기업명 하드코딩 없이 WebSearch 생성  `[P1/M]`

Phase 2 앞에 분기 추가: 사용자가 직무 키워드가 아닌 업종/회사군(예: "보안 전문기업", "핀테크 스타트업" — 예시는 업종명만 쓰고 기업명은 SKILL.md에 하드코딩 금지)으로 물으면 ①WebSearch로 해당 업종 대표 기업 shortlist를 생성·검증하고(검색으로 확인되지 않은 기업 제외, 채용 진행 미확인 기업은 "채용 진행 미확인" 표시) ②AskUserQuestion으로 관심 기업을 좁힌 뒤 ③그 기업명들을 키워드로 4플랫폼 검색 실행. 경계 문장 명시: shortlist 비교까지가 job-search 범위이고, 개별 기업 심층 분석은 /company-research로 핸드오프한다. '○○과 비슷한 회사 추천' 유형 요청도 이 분기로 처리.

> ⚠️ **main 재조정 (needs_adjust)**: '/company-research로 핸드오프' 경계 문장은 /company_research 표기(test-command-style.sh). 회사군 탐색 분기 자체는 유효.

**완료 판정:**
- Phase 2 앞에 회사군 탐색 분기 소절이 존재하고, 본문에 특정 기업명 예시가 하드코딩되어 있지 않다 (업종명 예시만 존재)
- shortlist는 WebSearch로 생성·검증한다는 규칙과 '채용 진행 미확인' 표시 규칙이 존재한다
- /company-research 핸드오프 경계 문장이 존재한다

### JOB-6 · 파싱 실패 fallback — 한계 노출 대신 자료 요청  `[P1/S]` · 의존: INFRA-1

Phase 2 끝에 'fallback UX' 소절 추가: (1) 사용자가 준 공고 URL WebFetch 실패 또는 이미지 공고 인식 실패 시 실패 원인 나열 대신 "공고 본문을 복사해 붙여주시면 바로 분석합니다" 1문장으로 요청. (2) 4플랫폼 전부 수집 실패 시 해당 섹션을 생략하고 "사람인·잡코리아·원티드에서 직접 확인" 링크 안내 + DONE_WITH_CONCERNS 처리(완료 상태 프로토콜과 연결). (3) 금지 표현 예시 병기: "네트워크가 차단되어"·"스크래핑이 막혀서" 같은 내부 한계 서술 금지 — 상세 규칙은 templates/guardrails.md(INFRA-1)를 참조하도록 링크. 검증 결과 원안 그대로 채택.

> ⚠️ **main 재조정 (needs_adjust)**: main #118d가 '사람인 단축 URL은 복붙 요청 전 WebFetch 리다이렉트 재시도'를 이미 규정 — fallback 소절은 이 순서(URL 재시도→복붙 요청)와 모순 없이 작성하고 #118d 블록과 중복 제거.

**완료 판정:**
- Phase 2에 fallback UX 소절(URL/이미지 실패 시 복붙 요청, 전면 실패 시 섹션 생략+직접 확인 안내+DONE_WITH_CONCERNS)이 존재한다
- 한계 노출 금지 표현 예시와 guardrails 템플릿 참조가 존재한다

### JOB-9 · 공고 URL/원문 직접 입력 진입점 — 검색 생략 후 분석·매칭 직행  `[P1/S]`

Phase 1 앞에 진입 분기 추가: 사용자가 공고 URL 또는 JD 원문을 직접 제공하면 플랫폼 검색(Phase 2)을 건너뛰고 Phase 3(분석)→Phase 4(매칭)로 직행한다. URL이면 WebFetch로 본문 확보(원티드는 API detail endpoint 사용), 원문 붙여넣기면 그대로 본문으로 취급 — 본문 확보 상태이므로 JOB-2 가드를 충족해 매칭 스코어 산출 가능. 분석 결과(키워드·자소서 문항)는 JOB-4와 동일 포맷으로 tracker에 저장하고, "이 공고 기준으로 이력서/자소서 첨삭" 후속 요청은 /resume·/cover-letter 추천으로 연결한다. 근거: 실사용 355건 중 공고 탐색 57~59건이며 JD 원문 통째 붙여넣기→적합도 분석→첨삭이 최다 반복 워크플로우.

> ⚠️ **main 재조정 (needs_adjust)**: 후속 추천의 /cover-letter는 /cover_letter 표기. wanted가 main에서 정식 플랫폼으로 추가돼(API detail 전제) 진입점 설계는 오히려 전제 강화 — 내용 유효.

**완료 판정:**
- Phase 1 앞에 URL/원문 직접 입력 분기가 존재하고 Phase 2 생략 규칙이 명시되어 있다
- JD 원문 붙여넣기 입력 시 플랫폼 검색 없이 키워드 추출·매칭 스코어가 출력된다
- 직접 입력 공고도 tracker YAML로 저장된다

### JOB-10 · 공공기관 채용 소스 라우팅 — 잡알리오/클린아이/나라일터/워크넷  `[P2/S]`

Phase 2에 소절 추가: Phase 1에서 희망 기업 유형이 공기업/공공기관이면 4플랫폼 검색에 더해 채용 성격별 공식 소스를 안내·검색한다 — 중앙 공공기관=잡알리오(job.alio.go.kr), 지방 공공기관·출자출연기관=클린아이 잡플러스(job.cleaneye.go.kr), 공무원·개방형 직위=나라일터, 종합·진로상담=워크넷. 연간 채용 규모·기관별 인원 등 수치는 본문에 쓰지 않고 실행 시 WebSearch로 확인. NCS 기반 전형 안내가 필요하면 /ncs 스킬 추천으로 연결.

> ⚠️ **main 재조정 (needs_adjust)**: '/ncs 스킬 추천' 금지 — test-command-style.sh가 /ncs 단어 경계를 검출·FAIL. NCS 안내는 /cover_letter 공기업 보강으로 연결(BOT-COMMAND-STYLE §2). 공공 소스 4종 안내는 유효.

**완료 판정:**
- Phase 2에 공공기관 소스 4종(잡알리오·클린아이·나라일터·워크넷)과 성격별 구분(중앙/지방/공무원)이 존재한다
- 공공기관 채용 규모 수치가 본문에 하드코딩되어 있지 않다
- 공기업 선택 경로에서 /ncs 추천 연결이 존재한다

### JOB-11 · 필터 설계 상담 분기 — 실사용 필터 어휘 반영  `[P2/S]`

Phase 1에 '필터 설계 상담' 분기 추가: 사용자가 "어떻게 필터링하는 게 좋아 보여?"처럼 필터 설계 자체를 물으면, 실사용에서 관측된 필터 축(회사 규모(현 직장 대비), B2C/B2B 여부, 지역, 경력 레벨, 선호 기업 유형(대기업/빅테크/스타트업), 유사기업 추천)을 제시하고 AskUserQuestion으로 2~3개 축을 고르게 한 뒤 Phase 2 검색 조건으로 변환한다. "○○ 다음으로 지원할 만한 비슷한 회사" 요청은 JOB-5 회사군 탐색 분기를 재사용한다.

**완료 판정:**
- Phase 1에 필터 상담 분기와 필터 축 목록(회사 규모·B2C/B2B·유사기업 포함)이 존재한다
- 필터 상담 입력 시 AskUserQuestion을 거쳐 검색 조건 요약이 출력된다

### JOB-12 · 텔레메트리 후속 이벤트 — 검색 조건 확정·결과 수 기록  `[P2/S]` · 의존: INFRA-10

프리앰블의 진입 텔레메트리(entry)에 더해, Phase 2 검색 완료 후 Claude가 `$_JS_STATE/analytics/skill-usage.jsonl`에 후속 이벤트 1줄을 append하는 지시를 SKILL.md에 추가: `{"skill":"job-search","event":"detected","ts":...,"combo":"직무/경력/지역","results":수집 건수,"cache_hit":true|false}`. 이벤트 필드 규격은 INFRA-10 확장 규격을 따른다. 검색 실패(0건)도 기록해 fallback UX(JOB-6) 발동 빈도를 retro에서 집계할 수 있게 한다.

**완료 판정:**
- SKILL.md에 Phase 2 이후 skill-usage.jsonl append 지시와 이벤트 JSON 스키마 예시가 존재한다
- 검색 실행 후 skill-usage.jsonl에 event=detected 레코드가 1건 추가된다

### JOB-7 · job-cache 도입 — TTL 2일 + 재사용 시 마감 재검증, 프리앰블 mkdir 반영  `[P2/M]` · 의존: INFRA-4

Phase 2에 수집 파이프라인 소절 추가. 검증 지적을 반영해 원안(7일 캐시)을 수정: (1) (직무,경력,지역) 콤보 단위로 수집 결과를 `$_JS_STATE/job-cache/`에 저장하되 TTL을 2일로 단축. 캐시 재사용 시 ①마감일 필터를 오늘(KST) 기준 재적용 ②원티드 공고는 API detail(status/hidden) 재검증 ③due_time:null·상시채용 공고는 본문 마감 문구 재확인을 통과한 것만 출력 — 마감 공고 재노출로 v0.4.0 마감 필터 강점이 무너지지 않게 한다. (2) 프리앰블 mkdir 목록에 `"$_JS_STATE/job-cache"` 추가. (3) 기술태그 규칙: 목록 페이지에서 추출, 30자 미만·최대 8개, 사람인은 태그 미노출이므로 생략. (4) AI 매칭 top-3 불가 시(프로필 없음 등) 마감임박순 정렬 fallback.

> ⚠️ **main 재조정 (partially_done)**: 기술태그 추출은 bin/fetch-jobs.mjs에 기구현(main): 30자 미만·최대 8개 slice·사람인 skills:'' 명시 + wanted 플랫폼 추가. 잔여: job-cache 디렉토리(프리앰블 mkdir에 미존재 확인)·TTL 2일·재사용 시 3단계 마감 재검증·SKILL.md 소절.

**완료 판정:**
- 프리앰블 mkdir 라인에 job-cache 디렉토리가 포함되고 test/test-preambles.sh가 통과한다
- 캐시 소절에 TTL 2일과 재사용 시 3단계 마감 재검증(KST 필터·원티드 API detail·본문 문구) 규칙이 존재한다
- 태그 규칙(30자·8개·사람인 생략)과 마감임박순 fallback 규칙이 존재한다

### JOB-8 · Phase 1 경력 선택지에 중고신입 추가 (수치는 본문 하드코딩 금지)  `[P2/S]`

Phase 1 경력 수준 선택지 "신입, 1~3년, 3~5년, 5년+"에 "중고신입(경력 6개월~3년, 신입 공고 지원)"을 추가하고, 매핑 표에 "중고신입 → entry로 검색하되 경력(experienced) 공고도 병행 노출" 규칙을 넣는다. 안내 문장은 "경력은 숨기지 말고 무기로 쓰세요"로 넣되, 원안의 '28.1%' 같은 시장 통계는 본문에 쓰지 않는다 — 비율을 인용하려면 실행 시 WebSearch로 최신 수치를 확인하고 출처·시점을 병기하라는 규칙으로 대체.

**완료 판정:**
- Phase 1 선택지에 중고신입 항목과 entry+experienced 병행 노출 매핑 규칙이 존재한다
- 본문에 28.1%·33.5% 등 시장 수치가 하드코딩되어 있지 않다 (INFRA-7 린트 통과)

### 제외·기구현 (3건)
- **4대그룹 채용 채널 표(삼성 GSAT/SK SKCT/현대차/LG Way Fit) 본문 하드코딩**: 기업별 전형 방식은 매년 변하는 시간민감 정보 — 본문 하드코딩 금지 규칙에 따라 기각. JOB-1의 'WebSearch로 최신 확인 + 출처·시점 병기' 규칙으로 대체.
- **보안 업종 shortlist 기업명 예시(SK쉴더스·에스원·안랩·시큐아이) 하드코딩**: 훈련 데이터 출처 정보와 같은 계열의 위험(검증 판정). SKILL.md에는 업종명 예시만 남기고 기업명은 실행 시 WebSearch로 생성·검증하도록 JOB-5에서 수정.
- **cover-letter가 tracker 공고 데이터를 자동으로 읽는 동작**: job-search SKILL.md 수정만으로 실현 불가(검증 판정). '자동 전달' 문구를 제거하고 tracker 저장까지만 job-search 범위로 한정(JOB-4). tracker 읽기 로직은 cover-letter 스킬 업그레이드 항목으로 이관.

## ncs → v0.2.0 (9건)

### NCS-2 · 가드레일 섹션 신설 — 생성형 AI 작성 제한 고지 + 사실 날조 금지  `[P0/S]` · 의존: INFRA-1

Phase 5 앞에 '## 가드레일' 섹션 신설, templates/guardrails.md를 기준으로 작성. 내용: (1) 일부 공공기관은 자소서의 생성형 AI 작성 제한을 공고에 명시하므로, 자소서 가이드 제공 시 '대필이 아닌 본인 경험 재작성 구조 제안'임을 고지하고 최종 문장은 사용자 본인 표현으로 다듬도록 안내. 지원 기관의 AI 활용 규정은 본문에 수치·기관명을 하드코딩하지 말고 실행 시 해당 기관 공고 원문 또는 WebSearch로 확인하도록 지시한다(적발 시 불이익 65.4%는 500대 사기업 조사 수치이므로 본문에 쓰지 않는다 — 근거는 이 rationale에만). (2) Phase 4 변환 매트릭스는 세션에서 사용자가 제공한 경험·자격증만 사용, 미확인 정보는 "[자격증명 확인 필요]" placeholder + 1회 질문으로 처리. 자격증·경력·수치를 추정으로 채우는 것 절대 금지(수치 폴백은 NCS-5와 상호 참조).

**완료 판정:**
- '## 가드레일' 섹션이 SKILL.md에 존재하고 templates/guardrails.md를 참조한다
- SKILL.md 본문을 grep 했을 때 65.4%, 42.2% 등 조사 수치가 존재하지 않는다
- 미확인 자격증 입력 시 추정 기입 대신 placeholder+1회 질문 규칙이 명시되어 있다

### NCS-3 · Phase 1에 지역인재 전형·인턴 유형 질문 추가 (수치 하드코딩 없이)  `[P0/M]`

Phase 1 AskUserQuestion 확장: (1) '지역인재 전형 해당 여부' 질문 추가 — 본사(이전 지역) 소재지와 최종학교 소재지를 확인하고, 해당 시 전형 전략을 분기한다. 지역인재 채용 비율·의무채용 요건 같은 수치는 본문에 쓰지 않고 '지원 기관의 지역인재 요건은 실행 시 WebSearch 또는 공고 원문으로 확인'으로 지시한다(제안 원안의 71% 수치는 혁신도시법 의무목표 30%와 상충하는 출처 오독 가능성이 있어 제외). (2) 인턴 지원자에게 '체험형 vs 채용연계형' 구분 질문 추가 — 채용연계형이면 정규직 전환 요건 중심, 체험형이면 경험 소재화 중심으로 Phase 4~5 가이드 분기. (3) 공공 인턴 선발이 어학점수보다 정책 관심도를 본다는 경향을 Phase 5 지원동기 가이드에 연결(수치 없이 경향 서술).

**완료 판정:**
- Phase 1 질문 목록에 지역인재 해당 여부와 체험형/채용연계형 구분 질문이 SKILL.md에 존재한다
- SKILL.md 본문에 71%, '2026-06 기준' 등 시기 민감 수치가 존재하지 않고 WebSearch 확인 지시가 존재한다
- 인턴 유형에 따라 Phase 4~5 가이드가 분기되는 지시문이 존재한다

### NCS-4 · Phase 4에 경험 전환 6단계 + 신입 빈출 경험 매핑표 + 자격증 예시 재작성  `[P1/M]` · 의존: INFRA-2

Phase 4 '변환 원칙' 아래에 templates/experience-methods.md의 경험 전환 6단계(경험 이름→당시 문제→역할→바꾼 행동→검증가능 변화→직무 연결)를 참조·명시. 신입 빈출 경험의 직업기초능력 매핑표 추가: 고객 응대→의사소통·고객서비스 / 동아리 운영→자원관리 / 팀 프로젝트→대인관계·문제해결 / 수업 과제→정보능력. 기존 변환 예시 표의 정보처리기사 행 "자격증을 통해 SW 개발 전반의 이론적 기반 보유"를 자격증으로 검증 가능한 범위로만 재작성: "정보처리기사 필기·실기 통과 — SW 개발 생명주기 단계별 용어·산출물 등 시험 범위 내 지식 검증". 원안의 '요구사항 명세서 작성 실습 경험'처럼 자격증만으로 증명되지 않는 경험을 부여하는 서술은 금지(NCS-2 날조 금지와 정합).

**완료 판정:**
- Phase 4에 경험 전환 6단계와 4행 이상의 빈출 경험 매핑표가 SKILL.md에 존재한다
- 정보처리기사 예시 행에 '이론적 기반 보유' 문구가 없고, 시험으로 검증 가능한 사실만 서술되어 있다
- templates/experience-methods.md 참조 문구가 존재한다

### NCS-5 · Phase 4에 수치 폴백 5기준 추가 (신입 경험 수치화)  `[P1/S]` · 의존: INFRA-2

원안 그대로 채택(검증에서 수정 지시 없음). Phase 4 말미에 '수치가 없을 때' 소섹션 추가: 수치 폴백 5기준 ①전후 변화 ②역할 범위 분리 ③정성 근거(피드백·계속 쓰인 양식) ④작은 검증가능 숫자(예: "3주간 12건 문의 유형 정리") ⑤면접에서 설명 가능한가. 수치 대체 4종(범위·빈도·전후비교·담당규모)을 표로 제시. 세부 정의는 templates/experience-methods.md를 참조해 중복 서술을 줄인다. NCS 타겟은 학생·신입이 다수라 수치가 없는 경우가 기본값 — 없는 수치를 지어내지 말고 이 폴백으로 유도하도록 명시하고 가드레일 섹션(NCS-2)과 상호 참조.

**완료 판정:**
- '수치가 없을 때' 소섹션에 폴백 5기준과 대체 4종 표가 SKILL.md에 존재한다
- 가드레일 섹션과의 상호 참조 문구가 존재한다

### NCS-6 · Phase 5에 STAR 한계 경고 + 모호 문항 재연결 + 경험/경력기술서 구분  `[P1/M]`

Phase 5 보강 3가지. (1) 'STAR 기법과 NCS 역량 단위를 연결' 문장 뒤에 경고 추가: STAR는 구조일 뿐, 문제 정의·선택 이유·역할·전후 차이가 없으면 약하다. '저희는/우리 팀은'으로 시작하는 문장은 역할이 묻히므로 '저는 그중 ~을 맡아'로 분리하는 점검 항목 추가. (2) '모호 문항 대응' 소섹션 신설: 공기업 자소서 문항은 답변 방향이 불분명한 경우가 적지 않으므로(33.1% 같은 조사 수치는 본문에 쓰지 않음), 문항을 그대로 따르지 말고 해당 기관 직무기술서에 명시된 직업기초능력으로 재연결. 예: "조직에 기여한 경험"→조직이해+대인관계로 해석 후 Phase 4 매트릭스에서 소재 선택. 작성 전 직무기술서의 능력 매핑이 필수임을 명시. (3) 경험기술서(무보수 활동)와 경력기술서(금전 대가)를 구분하고 경력기술서는 두괄식+최근 경력 순 배열 원칙 추가. 자소서 재활용 방지(기관별 맞춤 필요) 한 줄 경고 포함.

**완료 판정:**
- STAR 한계 경고와 '저희는' 분리 점검 항목이 SKILL.md에 존재한다
- '모호 문항 대응' 소섹션이 존재하고 33.1% 등 조사 수치가 본문에 없다
- 경험기술서/경력기술서 구분과 두괄식+최근순 원칙이 존재한다

### NCS-7 · 블라인드 지원서 식별정보 필터링 체크 추가  `[P1/S]` · 의존: INFRA-1

신규 항목(2차 채굴 반영). 가드레일 섹션(NCS-2) 또는 Phase 5에 블라인드 규칙 추가: NCS 기반 블라인드 입사지원서는 학교명·학점·가족사항·사진 미기재가 원칙이며, 자소서·경험기술서 본문 안에서 학교명 등 식별정보가 노출되면 불이익 가능 — 산출 서술을 제시하기 전 식별정보 노출 여부를 점검하는 체크 항목을 넣는다(templates/guardrails.md의 PII 등급 기준 참조). 단 일부 연구개발목적기관은 블라인드가 폐지되어 학위취득기관 기재가 가능하므로, 지원 기관의 블라인드 적용 여부는 기관명·목록을 하드코딩하지 말고 실행 시 공고 원문 또는 WebSearch로 확인하도록 지시한다.

**완료 판정:**
- 블라인드 식별정보(학교명·학점·가족·사진) 필터링 체크 항목이 SKILL.md에 존재한다
- 블라인드 예외 기관 여부를 WebSearch/공고 원문으로 확인하라는 지시가 존재하고 예외 기관 목록은 본문에 하드코딩되어 있지 않다

### NCS-10 · Phase 2에 NCS 공식 무료 자료·채용 소스 안내 + 필기 유형 확인 규칙  `[P2/S]`

신규 항목(2차 채굴 반영). Phase 2 검색 절차 뒤에 '공식 자료 우선' 소섹션 추가: (1) ncs.go.kr에서 직무기술서 양식·직업기초능력 학습자료·필기 예시문항을 무료 제공하므로 유료 교재 이전에 1차 소스로 안내. (2) 채용공고 확인은 중앙 공공기관=잡알리오(job.alio.go.kr), 지방 공공기관=클린아이 잡플러스로 소스를 구분해 안내. (3) 필기 대비 한 줄 안내: NCS 필기는 모듈형/PSAT형/피듈형으로 나뉘고 유형은 기관이 아닌 출제 대행사가 결정하므로, 지원 기관의 출제사·유형은 본문에 하드코딩하지 않고 실행 시 WebSearch로 확인하라고 지시(출제사 목록·유형 매칭은 변동 정보라 본문 금지). 필기 상세 대비는 이 스킬 범위 밖임을 명시하고 매핑에 집중.

**완료 판정:**
- Phase 2에 ncs.go.kr 무료 자료와 잡알리오/클린아이 소스 구분 안내가 SKILL.md에 존재한다
- 필기 유형은 출제사가 결정하며 WebSearch로 확인하라는 규칙이 존재하고, 출제사별 유형 매칭 표는 본문에 없다

### NCS-8 · Phase 3 A~D 평가에 근거 기준표 + 평가 시점을 Phase 4 이후 확정으로 명시  `[P2/S]`

Phase 3의 'A/B/C/D로 평가합니다' 한 줄을 기준표로 교체: A=수행 경험+검증가능 결과 있음 / B=수행 경험 있으나 결과 서술 약함 / C=간접 경험(수업·자격증)만 / D=근거 없음. 검증 지적(순서 모순) 반영: Phase 3에서는 사용자 자기신고 기반 '잠정 평가'만 하고, Phase 4에서 경험 근거를 수집한 뒤 등급을 '확정'한다고 시점을 명시한다. C·D 영역은 자소서 소재로 쓰지 않고 B 이상 영역을 선별해 문항에 배치. 10개 영역 전부를 서술하려는 시도는 키워드 몰아넣기와 동일한 실패로 금지 문구 명시 — 직무기술서에 명시된 핵심 영역(통상 3~5개)에 집중하도록 안내한다.

**완료 판정:**
- A/B/C/D 각각의 판정 기준이 표 형태로 SKILL.md에 존재한다
- 'Phase 3 잠정 평가 → Phase 4 이후 확정' 시점 규칙이 명시되어 있다
- 10개 영역 전부 서술 금지 문구가 존재한다

### NCS-9 · 완료 상태 섹션을 공유 템플릿과 동기화  `[P2/S]` · 의존: INFRA-1

원안 그대로 채택(검증에서 templates/completion-status.md 대조로 완전 검증됨). '## 완료 상태' 섹션을 templates/completion-status.md 기준으로 교체: (1) BLOCKED 정의에 "시간 민감 데이터(ncs.go.kr 검색 실패 등)는 훈련 데이터로 절대 대체하지 않고 해당 섹션 스킵 후 DONE_WITH_CONCERNS 처리" 조항 추가. (2) 결과물 뷰어 안내(jobstack-view) 추가 — NCS 매핑 매트릭스는 표 중심 산출물이라 HTML 뷰어 효용이 큼. (3) Phase 2 WebSearch 실패 시 대응 수정: "검색이 안 됩니다" 같은 한계 노출 대신 "지원 직무의 NCS 세분류 페이지나 직무기술서를 붙여넣어 주세요"로 자료 요청 전환(INFRA-1 규칙과 정합).

**완료 판정:**
- 완료 상태 섹션이 templates/completion-status.md와 동일한 4상태+훈련 데이터 대체 금지 조항을 포함한다
- Phase 2에 검색 실패 시 자료 요청 전환 문구가 존재한다
- jobstack-view 뷰어 안내가 존재한다

### 제외·기구현 (4건)
- **금융공기업 인턴십→하반기 우대·면접 면제 트랙 안내 (제안2의 일부)**: 검증 지시에 따라 삭제. 기관·시기별로 달라지는 변동 정보라 SKILL.md 내장 부적합하고 company-research/job-search 역할과 중복 — company-research로 이관.
- **시기 민감 통계 하드코딩 (65.4%, 71%, 33.1%, '2026-06 기준')**: 검증 지시에 따라 전부 본문에서 제외. 65.4%는 500대 사기업 조사라 공공기관 근거로 부적합, 71%는 혁신도시법 목표 30%와 상충하는 출처 오독 가능성, 33.1%는 표본 130건 소규모·작년 데이터. '실행 시 WebSearch 확인' 규칙으로 대체하고 수치는 각 항목 rationale에만 남김.
- **대기업 인적성검사 상세(GSAT/SKCT/HMAT/PAT 구성·비중) 반영**: 2차 채굴에 있으나 미채택. ncs는 공공 NCS 역량 매핑 스킬이라 대기업 인적성 필기 구성은 범위 밖이고, 문항수·출제 비중은 시기 민감 수치라 하드코딩 금지 원칙과 충돌. mock-interview/strategy 스킬 소관으로 이관.
- **NCS-1 프리앰블 stale PID 정리 루프 bash 문법 오류 수정**: main에서 기구현 — main에서 ncs 프리앰블 stale 루프 리다이렉트 제거 완료(diff 확인), test-preambles.sh ncs PASS(3변수 emit·세션 정리·bash 실행 성공).

## salary → v0.2.0 (8건)

### SAL-1 · 검색 소스·키워드 현행화 (동적 연도)  `[P0/S]` · 의존: INFRA-1, INFRA-4

Phase 2 '검색 소스' 수정: ①크레딧잡 URL을 creditjob.co.kr에서 kreditjob.com으로 교정 ②원티드 연봉정보(wanted.co.kr/salary) 추가 ③KOSA SW기술자 평균임금(sw.or.kr, 매년 12월 공표)을 공식 기준 소스로 추가. '검색 키워드'의 하드코딩 연도 "[기업명] 초봉 2024 2025"를 동적 연도로 교체: 프리앰블에 `echo "CURRENT_YEAR=$(date +%Y)"` 한 줄을 추가하고 키워드를 "[기업명] 초봉 [CURRENT_YEAR]"로 바꾼다. "KOSA SW기술자 평균임금 [직무]" 키워드 추가. Phase 2 서두에 '시장 수치는 SKILL.md에 박지 않고 실행 시 WebSearch로 확인한다'는 templates/guardrails.md 규칙 참조를 명시. 검증 지적에 따라 원안의 '원티드인사이트 언급 금지' 조항은 반영하지 않는다(현 SKILL.md에 해당 언급 자체가 없음).

**완료 판정:**
- SKILL.md에 kreditjob.com이 존재하고 creditjob.co.kr 문자열이 없다
- "2024 2025" 하드코딩 연도 문자열이 없고 CURRENT_YEAR 변수를 사용하는 검색 키워드가 존재한다
- 프리앰블에 CURRENT_YEAR emit이 존재하며 test/test-preambles.sh가 통과한다

### SAL-2 · 소스 신뢰도 지도 + 최소 2개 교차검증 규칙 구체화  `[P0/M]`

Phase 2에 '소스 신뢰도' 표 신설 — 편향 방향만 기술: 크레딧잡·오픈샐러리=국민연금 역추정 기반이라 고연봉 과소 추정, 저임금 근로자 포함 시 평균 하락 / 사람인=상여 미반영 경향 / 잡플래닛=보험 데이터 인증 기반 중앙값이라 상대적으로 정확 / 블라인드=개별 기업 실연봉에 가장 근접. 검증 지적대로 '인증 142만건' 같은 미검증 세부 수치는 넣지 않는다. 기존 125행 '여러 소스를 교차 검증' 일반론을 규칙으로 구체화: "같은 회사도 소스 간 1,000만원 이상 차이 나는 사례가 흔하므로, 최소 2개 소스 교차검증 없이 단일 수치를 단정하지 않는다"(신규가 아닌 기존 문구의 구체화임). Phase 3 벤치마크 테이블에 '시점(데이터 기준일)' 컬럼을 추가하고, 미확보 값은 추정 수치 대신 "(출처 미확보)"로 표기하는 규칙을 주의사항에 추가한다.

**완료 판정:**
- Phase 2에 4개 소스의 편향 방향을 담은 소스 신뢰도 표가 존재한다
- '최소 2개 소스 교차검증' 규칙과 "(출처 미확보)" 표기 규칙, '시점' 컬럼이 SKILL.md에 존재한다
- '142만건' 문자열이 SKILL.md에 없다

### SAL-3 · 협상 전술 핵심 4종 추가 (골든타임·3숫자·범위 답변·서면화)  `[P0/M]`

Phase 4 재구성(원안 그대로 채택): ①서두에 '골든타임 = 최종합격 후~서명 전(입사 후에는 연 5% 인상도 어려움)' 명시 ②협상 준비물로 3숫자(walk-away 최저선/목표 금액/최초 제시 범위)를 AskUserQuestion으로 확보하는 단계 추가 ③"현재 연봉이 얼마인가요?" 대응을 '희망연봉은 범위로 답변해 앵커링을 피한다'로 구체화 ④스크립트 좋은 예에 투자 제안 프레임 버전 추가: "[스킬]로 [수치화된 성과]를 달성해 왔고, 합류 시 [기여]가 가능합니다" ⑤카운터오퍼 3원칙 추가(실제 받은 오퍼만 언급 / 상대에게 선택을 주는 톤 / 떠날 준비가 됐을 때만) ⑥마지막에 서면화 체크리스트(연봉·보너스·복리후생·적용시점·다음 평가일) + 세후 실수령 재확인 단계 추가.

**완료 판정:**
- '골든타임'과 3숫자 확보 AskUserQuestion 단계가 Phase 4에 존재한다
- 카운터오퍼 3원칙과 투자 제안 프레임 스크립트가 존재한다
- 서면화 체크리스트 5항목과 세후 재확인 단계가 존재한다

### SAL-4 · 재직자 인상 협상 시나리오 추가  `[P1/M]`

원안 그대로 채택 + 전략 연계 보강. Phase 1 '현재 상황' 선택지를 '신입 취업 / 이직 / 오퍼 협상 중 / 재직 중 인상 협상' 4개로 확장. Phase 4에 '재직자 인상 협상' 소섹션 신설: ①타이밍 = 성과평가 직후 또는 연봉 시즌 전 선제 요청 ②근거 = 지난 1년 성과의 before→after 수치 정리 + 시장 벤치마크(Phase 2~3 결과) 대비 갭 제시 ③입사 후 인상은 연 5%도 어려우므로 갭이 크면 이직 협상이 현실적 대안임을 솔직하게 안내. '다음 스킬 추천'에 '재직자 인상 협상/오퍼 없는 상태 상담 → /strategy (이직 vs 잔류 선택지 비교)' 항목 추가 — 실사용 로그에서 '현재 연봉 수준, 다른 오퍼 없음, 어떤 전략?' 형태의 비교 의사결정 수요가 관측됨.

**완료 판정:**
- Phase 1 현재 상황 선택지가 4개이며 '재직 중 인상 협상'이 포함된다
- Phase 4에 재직자 인상 협상 소섹션(타이밍·수치 근거·이직 대안 안내)이 존재한다
- 다음 스킬 추천에 /strategy 연계 항목이 존재한다

### SAL-5 · 총보상 프레임 확장 (하드코딩 없이 WebSearch 확인 지시로)  `[P1/M]` · 의존: INFRA-1

검증 수정방향 반영: 법령·기업 사실을 본문에 박지 않는다. Phase 3 '총보상 구성 요소' 확장: ①성과급에 '영업이익 연동 여부·상한 유무' 확인 항목 추가 — 특정 기업 사례는 쓰지 않고 "[기업명] 성과급 산정 기준" WebSearch로 확인하도록 지시 ②스톡옵션에 "행사제한 기간·시가미만 발행 한도 등은 법 개정이 잦으므로 실행 시 '벤처기업법 스톡옵션 개정' WebSearch로 최신 내용 확인" 지시 + 체크 3종(행사가 / 베스팅 스케줄 / 퇴사 시 정산 조건) 추가 ③회사 단계별 주식보상 경향(초기=옵션 / 성장=옵션+RSU / 성숙=RSU·PSU)은 일반 지식으로 기술 ④'공시 총보상과 세후 실수령의 차이' 경고 추가. Phase 5 오퍼 비교표에 '기본 연봉'과 '변동 보상(성과급·주식)'을 분리해 계산하도록 지시.

**완료 판정:**
- '2→1년', '5→20억', 'SK하이닉스' 문자열이 SKILL.md에 없다
- 스톡옵션 최신 개정 WebSearch 확인 지시와 체크 3종이 Phase 3에 존재한다
- Phase 5 비교표에 기본급/변동 보상 분리 지시가 존재한다

### SAL-6 · 검색 실패 폴백 정책 단일화 (앵커 하드코딩 대신 3단계 폴백)  `[P1/S]` · 의존: INFRA-1

검증이 지적한 제안 6·8 충돌 해소 — 하드코딩 앵커 표를 폐기하고 폴백 정책을 하나로 통일해 Phase 2 말미에 명시: ①1차 = KOSA SW기술자 평균임금·잡플래닛 공표 통계를 WebSearch로 재시도하되 반드시 공표 시점을 병기 ②2차 = 사용자 자료 요청 전환("블라인드/잡플래닛에서 본 해당 기업 연봉 수치를 붙여주세요") — 한계 노출 대신 필요 자료 요청 ③둘 다 실패 시 해당 섹션을 스킵하고 DONE_WITH_CONCERNS 처리, 훈련 데이터 수치로 절대 대체하지 않는다(templates/completion-status.md 규칙과 일치). Phase 3 예시 테이블의 가상 수치(기업A 4,500만 등)에는 "(예시 — 실행 시 실제 검색값과 출처·시점으로 대체)" 라벨을 붙여 예시가 사실로 출력되는 것을 막는다. 연차별 참고치(1년차 3,766만 등)는 본문에 넣지 않는다 — 근거 수치는 rationale 전용.

**완료 판정:**
- Phase 2에 3단계 폴백(WebSearch 재시도→사용자 자료 요청→섹션 스킵+DONE_WITH_CONCERNS)이 존재한다
- '훈련 데이터로 대체하지 않는다' 문구가 존재하고 '3,766' 등 연차별 앵커 수치가 본문에 없다
- Phase 3 예시 테이블에 예시 라벨이 존재한다

### SAL-7 · 중고신입 포지셔닝 안내 (통계는 WebSearch 확인으로)  `[P2/S]` · 의존: INFRA-1

Phase 4 '신입 취업 시' 소섹션의 '초봉 협상 여지가 있는 기업 vs 고정인 기업 구분' 항목 바로 아래에 중고신입 항목 추가: 경력 6개월~3년은 중고신입 트랙에 해당하며, 짧은 경력을 숨기지 말고 직전 연봉+실무 성과를 초봉 협상 근거로 무기화하라는 안내. 검증 지적에 따라 28.1%·33.5% 같은 조사 통계는 본문에 하드코딩하지 않고 "중고신입 채용 비중·선호도는 '중고신입 채용 비중 [CURRENT_YEAR]' WebSearch로 확인해 조사 시점과 함께 제시" 지시로 대체한다(수치 근거: 대기업 신입 중 중고신입 비중·선호 HR이슈 1위 보도, zdnet/jobkorea — rationale 전용).

**완료 판정:**
- 중고신입 항목이 '초봉 협상 여지' 항목 아래에 존재한다
- '28.1'과 '33.5' 문자열이 SKILL.md에 없다
- 중고신입 통계에 대한 WebSearch 확인+시점 병기 지시가 존재한다

### SAL-8 · 완료 상태를 공유 템플릿과 정렬 + 한계 노출 금지 원칙  `[P2/S]` · 의존: INFRA-1

원안 그대로 채택. '완료 상태' 섹션을 templates/completion-status.md와 정렬: ①BLOCKED 규칙에 '연봉 데이터 등 시간 민감 데이터는 훈련 데이터로 절대 대체하지 않고 해당 섹션 스킵 후 DONE_WITH_CONCERNS 처리' 문구 추가(SAL-6의 Phase 2 폴백 정책과 동일 원칙으로 상호 참조) ②벤치마크 리포트 파일 생성 시 jobstack-view 뷰어 안내 추가. 별도로 '검색이 막히면 한계를 노출하지 말고 필요 자료 요청으로 전환'(예: "블라인드/잡플래닛에서 본 해당 기업 연봉 수치를 붙여주세요") 규칙을 templates/guardrails.md 참조와 함께 Phase 2 말미에 추가한다(SAL-6 ②와 같은 위치, 중복 서술 대신 한 문단으로 통합).

**완료 판정:**
- 완료 상태 섹션에 시간 민감 데이터 훈련 데이터 대체 금지 문구가 존재한다
- jobstack-view 뷰어 안내가 존재한다
- 한계 노출 금지→자료 요청 전환 규칙이 Phase 2에 존재한다

### 제외·기구현 (2건)
- **'원티드인사이트 언급 금지' 조항 (SAL-1 원안 일부)**: 현재 SKILL.md에 원티드인사이트 언급 자체가 없어 불필요한 지시 — 검증 issue 5에 따라 삭제. wanted.co.kr/salary 추가만 유지.
- **연차별 기준 앵커 데이터 하드코딩 표 (SAL-6 원안)**: completion-status.md의 '시간 민감 데이터 훈련 데이터 대체 금지' 규칙과 정면 충돌하고, 수치가 repo 내 검증 불가하며, 원안이 비판한 연도 하드코딩 문제를 재생산. WebSearch 재시도→사용자 자료 요청→섹션 스킵 3단계 폴백(SAL-6 수정본)으로 대체.

## resume → v0.2.0 (10건)

### RES-1 · 사실 무결성 가드레일 잔여분 — 보이스·Phase 2A·Phase 9 보강  `[P0/S]` · 의존: INFRA-1

main에 Phase 6 날조 금지 주석과 Phase 9 샘플 PII 경고(#130)는 기구현이므로 잔여 갭만 반영. (1) '보이스' 섹션 커뮤니케이션 원칙 아래 '사실 무결성 원칙' 블록 신설: 세션에서 사용자가 직접 제공했거나 파일에서 확인한 사실만 기재, 자격증·재직사·어학점수 등 추론 생성 절대 금지, 미확보 정보는 placeholder('[이메일 입력 필요]', '[재직기간 확인 필요]')로 표기하고 AskUserQuestion 1회만 질문. 세부 규칙은 templates/guardrails.md(INFRA-1) 참조 링크로 연결해 중복 서술 최소화. (2) Phase 2A 정보 수집에 '답변받지 못한 항목은 빈칸/placeholder 유지, 그럴듯한 값으로 채우지 않기' 규칙 추가. (3) Phase 9 저장 항목 앞에 '사용자가 확인한 값만 저장' 조건 명시(기존 #130 경고와 일관되게). (4) 대필·전면 위임 요청('전적으로 맡길게' 유형) 시에도 수치·근거 확인 질문을 먼저 거친 뒤 작성한다는 코칭 경계 1줄 추가 — 실사용에서 과장 표현을 사용자가 직접 거부한 사례가 근거.

**완료 판정:**
- 보이스 섹션에 '사실 무결성 원칙' 블록이 존재하고 templates/guardrails.md를 참조한다
- Phase 2A에 미답변 항목 placeholder 유지 규칙이 명시돼 있다
- Phase 9에 '사용자 확인 값만 저장' 조건이 있다
- 대필/전면 위임 시 사실 확인 질문 선행 규칙이 있다
- SKILL.md 어디에도 미확인 정보를 추론으로 채우라는 지시가 없다

### RES-2 · Phase 4 ATS 현대화 — 조건부 파싱 규칙·문맥 배치·공고 미확보 시 산출 금지  `[P0/M]` · 의존: INFRA-1

Phase 4 재작성(main은 여전히 단순 O/X 매칭). (1) 도입부에 ATS 4단계(수집→파싱→키워드 매칭·점수화→순위화) 명시. (2) '파싱 안전 체크' 하위 단계 신설 — 단 '자체 파일(PDF/docx) 제출 시에만 적용' 조건을 명기: 표·그래픽·이미지·차트 지양, 표준 섹션 제목(경력사항·학력 등) 사용, '디자인 템플릿≠ATS 친화' 경고. 원티드/사람인 등 플랫폼 입력형과 한국식 표 기반 양식은 예외임을 같은 블록에 명시(검증 수정방향 반영). (3) 키워드 삽입 규칙에 'NLP 기반 ATS는 keyword stuffing을 무력화 — 키워드는 경험 근거 문장 안에 문맥으로 배치, 한 섹션 몰아넣기 금지' 추가. 연도 표기 없이 서술하고, 최신 ATS 동향 인용이 필요하면 WebSearch로 확인. (4) 매칭 분석 전제조건: '공고 본문 미확보 시 매칭률 수치 산출 금지 — 한계를 사과로 노출하지 말고 "공고 본문을 붙여넣어 주세요" 자료 요청으로 전환'(guardrails 전환 형식 사용). (5) Phase 2C 진입점에 'JD 원문 통째 붙여넣기'를 1급 입력으로 명시 — 공고 원문 파싱→키워드 추출→체크리스트→매칭→첨삭 연결이 실사용 최다 반복 워크플로우.

**완료 판정:**
- Phase 4에 ATS 4단계 설명이 있다
- 파싱 안전 체크가 '자체 파일 제출 시에만 적용' 조건과 플랫폼 입력형·한국식 표 양식 예외를 함께 명시한다
- keyword stuffing 금지·문맥 배치 규칙이 있고 연도 하드코딩이 없다
- 공고 본문 미확보 시 매칭률 산출 금지 + 자료 요청 전환 규칙이 있다
- Phase 2C에 JD 원문 붙여넣기 진입점이 명시돼 있다

### RES-3 · 공채 중심 낡은 가정 교정 — 통계 하드코딩 없는 방향성 서술  `[P0/S]`

Phase 3 한국식 필수 항목 표(현 main 171행 부근)의 증명사진 행 비고 '공채는 필수, 스타트업은 선택'을 '요구 시에만 첨부 — 수시·상시채용이 주류이고 공채는 소수라 대부분 선택사항'으로 교체. 검증 수정방향대로 54.8%/10.2% 등 연도 종속 통계는 하드코딩하지 않고, 최신 비율 인용이 필요한 경우 WebSearch로 확인 후 출처·시점을 병기하라는 규칙을 함께 명시. 표 하단에 '다이렉트소싱 확산 — 링크드인/원티드 프로필과 이력서 내용 일치 여부도 점검' 1줄 추가(수치 없이). 문서 전체에서 공채 시즌 전제 표현이 남아 있는지 점검해 수시·상시 기준으로 통일.

**완료 판정:**
- 증명사진 행에 '공채는 필수' 표현이 없다
- 채용 형태 관련 구체 %·연도 수치가 SKILL.md에 하드코딩돼 있지 않다
- 최신 통계 인용 시 WebSearch 확인+출처·시점 병기 규칙이 있다
- 프로필 플랫폼 일치 점검 1줄이 추가돼 있다

### RES-4 · 완성 조건 확장 잔여분 — DONE 조건·등급 변화·독립 실행 파일화 폴백  `[P1/S]` · 의존: INFRA-6

main에 재리뷰 delta 요약(#117)·등급 결정성(#122)·완결 시 .docx 자동 산출(#118b)이 기구현이므로 별도 Phase 10 신설 없이 잔여 갭만 반영. (1) Phase 2B 재리뷰 출력에 '등급 변화(예: B-→A)' 표시 1줄 추가 — #122 앵커 기준을 그대로 재산출해 표기. (2) #118b는 jobclaw 워크스페이스(render-docx.sh) 전제이므로 독립 CLI 실행 폴백을 Phase 8에 추가: 'render-docx.sh 미존재 시 command -v pandoc으로 변환 도구 확인 → 있으면 bin/jobstack-export(INFRA-6)로 md→docx 변환, 없으면 마크다운/HTML 파일로 산출하고 변환 방법 안내'(검증 수정방향 반영). (3) 완료 상태 프로토콜의 DONE 조건을 '제출 가능 파일 산출 또는 사용자가 재리뷰 불필요 확인'으로 갱신하고, 완료 출력 예시에 '산출 파일: resume_v2.docx' 줄 추가. (4) 최초 진단표 출력 시 등급 산출 기준(🔴 건수 앵커)을 한 줄 병기 — 평가 기준 투명성 요구(실사용: 루브릭 직접 질문) 대응.

**완료 판정:**
- 재리뷰 출력 형식에 등급 변화 표기가 포함된다
- Phase 8에 render-docx.sh 부재 시 pandoc 확인→md/HTML 폴백 규칙이 있다
- DONE 조건이 '제출 가능 파일 산출 또는 재리뷰 불필요 확인'으로 갱신됐다
- 완료 출력 예시에 산출 파일 줄이 있다
- 진단표 출력에 등급 산출 기준 한 줄이 병기된다

### RES-5 · 공고별 버전 관리 — 매칭률% 유지 + 등급 병기, tracker 역할 분담  `[P1/M]` · 의존: INFRA-5

Phase 2C 확장(검증 수정방향 반영). (1) 원본 이력서는 보존하고 공고 단위 변형본을 별도 관리 — Phase 9 프로필 스키마에 resume_versions[](회사명, 공고 키워드, 매칭률, 파일 경로) 필드 추가. (2) Phase 4 매칭 출력은 0~100 정밀 스코어·'90점 기준선'을 도입하지 않고(유사 정밀도 위험으로 기각) 기존 매칭률(%) 체계를 유지하되 등급을 병기: A(80% 이상, 지원 준비 완료)/B(60~79%)/C(60% 미만). 기존 Phase 4·7의 '목표 80% 이상'과 등급 A 기준을 일치시켜 이중 척도를 제거. (3) 역할 분담 1줄 명시: '이력서 파일·버전 관리 = resume, 지원 상태 추적 = tracker' — tracker canonical 상태 모델(INFRA-5)과 필드 충돌이 없는지 확인. (4) 완료 출력 '다음 추천'에 '동일 이력서로 다른 공고 지원 시 버전 분기' 안내 추가.

**완료 판정:**
- Phase 9 스키마에 resume_versions[] 필드가 정의돼 있다
- 매칭 출력이 매칭률(%)+A/B/C 등급이며 0~100 스코어·90점 기준선이 없다
- 등급 A 기준과 기존 '80% 이상' 목표가 일치한다
- resume/tracker 역할 분담 문구가 있다
- 다음 추천에 버전 분기 안내가 있다

### RES-6 · 중고신입(경력 6개월~3년) 전략 섹션 신설  `[P1/S]`

'신입 vs 경력 차별 전략' 섹션에 세 번째 하위 섹션 '중고신입(경력 6개월~3년) 전략' 추가(검증 '그대로 채택', main과 충돌 없음 확인). (1) 경력을 숨기지 말고 전면 배치 — 짧아도 실무 경험은 즉시 투입 근거. (2) 퇴사 사유는 이력서에 쓰지 않되 면접 방어 논리를 미리 정리하도록 안내. (3) 첫 화면에 '즉시 투입 가능 역량' 요약 배치(5초 규칙 적용). (4) 신입 공고 지원 시에도 경력사항 섹션 유지, 인턴 톤으로 축소 서술 금지. 섹션 도입부에 적용 판단 기준(경력 6개월~3년이면 이 전략)을 명시해 Phase 1 모드 판단과 연결. 시장 비중 통계(선호율·비율 등)는 하드코딩하지 않고 필요 시 WebSearch로 확인.

**완료 판정:**
- 중고신입 하위 섹션이 존재하고 적용 판단 기준(6개월~3년)이 명시돼 있다
- 경력 전면 배치·퇴사 사유 미기재+면접 방어·첫 화면 요약·경력 섹션 유지 4원칙이 모두 포함된다
- 시장 통계 수치가 하드코딩돼 있지 않다

### RES-7 · 분량·첫 화면 검토 대응 가이드 — 통계 대신 원칙 서술  `[P1/S]`

Phase 7 포지셔닝 체크 표에 2행 추가. (1) '첫 화면 승부 — 인사담당자의 검토 시간은 수십 초 이내로 짧다. 1페이지 상단에 핵심 성과 3개가 보이는가'. (2) '분량 — 1장 강박으로 성과를 삭제하지 않았는가. 2~3페이지까지 허용, 3페이지 초과 시 압축'. 원안의 '평균 2.7페이지'·'15초' 같은 조사 시점 종속 수치는 하드코딩하지 않고, 사용자가 근거를 물으면 WebSearch로 최신 데이터를 확인해 출처·시점과 함께 제시하라는 규칙을 병기(전역 규칙 준수 — 검증은 원안 채택이었으나 통계 하드코딩 금지 규칙이 우선). 경력 전략 5번 '이력서(1~2페이지 요약)' 표현은 유지하되 '분량보다 첫 화면 밀도가 우선' 원칙 1줄 병기.

**완료 판정:**
- Phase 7 표에 첫 화면·분량 2행이 추가돼 있다
- 2.7페이지·15초 등 구체 통계가 하드코딩돼 있지 않다
- 근거 요청 시 WebSearch 확인 규칙이 있다
- 경력 전략 5번에 첫 화면 밀도 우선 원칙이 병기돼 있다

### RES-10 · 비개발 직군 분기 노트 — 직군별 증빙 축과 AI 활용 경험 서술  `[P2/S]`

round2 비개발 직군 리서치 반영(리서치의 개발자 편중 보정). (1) Phase 3 표 '기술스택(IT직군 필수)' 행에 직군 분기 노트 추가, Phase 7 하단에 '직군별 증빙 축' 소블록 신설: 개발=GitHub·포트폴리오 링크, 마케팅=실제 운영 경험+캠페인 성과 수치(본인 기여도 비율 명시), 기획/PM=역기획서·화면설계 등 산출물 링크(시각 완성도보다 구조·논리), 재무·회계=직무 자격증이 1차 평가 축. (2) 공통 원칙 2줄: '이력서는 검증 가능한 산출물(포트폴리오)로 연결되는 인덱스 역할', 'AI 툴 활용 경험은 어떤 도구로 생산성을 얼마나 개선했는지 수치로 서술하면 직군 불문 우대 신호'. 우대조건 비율 등 시장 수치는 하드코딩하지 않고 필요 시 WebSearch 확인.

**완료 판정:**
- 직군별 증빙 축 블록에 개발·마케팅·기획·재무 4개 분기가 있다
- 이력서=포트폴리오 인덱스 원칙과 AI 툴 활용 경험 수치 서술 가이드가 있다
- 직군 트렌드 관련 수치가 하드코딩돼 있지 않다

### RES-8 · Phase 6 수치 폴백 — 대체 4종 + 면접 방어 필터  `[P2/S]` · 의존: INFRA-2

Phase 6 코칭 전략 하단(main 기구현된 날조 금지 주석과 일관되게) '수치가 정말 없을 때' 블록 추가(검증 '그대로 채택'). (1) 수치 대체 4종 — 범위('백엔드 API 12개 중 8개 담당'), 빈도('주 1회 배포'), 전후 비교(정성이라도 '수기 정리→양식화'), 담당 규모('고객사 15곳'). (2) '작은 검증 가능 숫자가 큰 추정치보다 낫다' 원칙('3주간 문의 12건 유형 정리' > '수백 건 처리'). (3) 최종 필터: '이 숫자를 면접에서 1분간 설명할 수 있는가' — 설명 불가한 수치는 기재 금지. 정성 근거(사수 피드백, 계속 쓰인 양식)도 허용 근거로 명시. 상세 폴백 5기준·추상어→질문 전환표는 templates/experience-methods.md(INFRA-2) 참조 링크로 연결해 스킬 본문 비대화 방지.

**완료 판정:**
- Phase 6에 '수치가 정말 없을 때' 블록이 있고 대체 4종이 예시와 함께 있다
- 작은 검증 가능 숫자 우선 원칙이 있다
- 면접 1분 설명 가능성 필터가 있다
- templates/experience-methods.md 참조 링크가 있다

### RES-9 · 법정 금지 개인정보·블라인드 지원서 체크 신설  `[P2/S]` · 의존: INFRA-1

round2 공공기관·법제도 리서치 반영. Phase 3 표 하단에 '개인정보·블라인드 체크' 블록 신설. (1) 채용절차법 제4조의3 금지 항목 — 직무와 무관한 용모·키·체중 등 신체적 조건, 출신지역·혼인여부·재산, 직계존비속·형제자매의 학력·직업·재산 — 은 기재할 필요가 없으며 이력서에 있으면 삭제 권고, 구인자가 요구한 경우 법 위반 소지(과태료 대상)임을 사용자에게 안내할 수 있다고 명시. (2) 공공기관 블라인드(NCS) 지원 시 학교명·사진 등 식별정보가 지원서·경험기술서 본문에 노출되지 않는지 필터 체크 추가 — 노출 시 불이익 가능. 단 일부 연구개발목적기관은 블라인드 예외이므로 기관별 공고 기준을 우선하라고 명시. 법·제도는 변동 가능하므로 구체 안내 전 WebSearch로 현행 확인. PII 등급 분류는 templates/guardrails.md(INFRA-1)와 연결.

**완료 판정:**
- 채용절차법 금지 항목 3범주가 체크 블록에 명시돼 있다
- 블라인드 지원 시 식별정보 필터 체크가 있고 기관별 공고 우선 원칙이 있다
- 법제도 안내 전 WebSearch 확인 규칙이 있다

### 제외·기구현 (6건)
- **재리뷰 감지 + 변경분(delta) 요약 (원안 'Phase 10' 중 재리뷰 부분)**: main에서 기구현 — 커밋 d6c7da4(#117 Phase 2B delta 요약, #122 등급 결정성 앵커). 잔여 갭(등급 변화 표시·DONE 조건)만 RES-4로 이관
- **.docx 자동 산출 기본 경로 (원안 'Phase 10' 중 파일화 부분)**: main에서 기구현 — 커밋 d6c7da4(#118b Phase 8 완결 시 .docx 자동 emit). 잔여 갭(jobclaw 워크스페이스 외 독립 실행 시 pandoc 확인→md/HTML 폴백)만 RES-4로 이관
- **샘플/플레이스홀더 PII 저장 전 경고**: main에서 기구현 — 커밋 d6c7da4(#130 Phase 9 경고 블록). 잔여 가드레일(보이스 사실 무결성·Phase 2A placeholder·확인 값만 저장)은 RES-1로 이관
- **JD 매치 0~100 스코어 + '90점=지원 준비 완료' 기준선**: 검증 기각 — LLM 즉석 채점의 유사 정밀도(fake metric) 위험, Rezi 기준선은 자사 알고리즘 전제라 이식 근거 빈약. 기존 매칭률(%)+A/B/C 등급 병기로 대체(RES-5)
- **시장 통계 수치 하드코딩(수시 54.8%·공채 10.2%·다이렉트소싱 51.2%·평균 2.7페이지·15초·중고신입 33.5% 등)**: 검증 지적 + 전역 규칙 — 연도 종속 통계는 1~2년 내 스테일해져 또 다른 낡은 안내가 됨. 방향성 서술 + 필요 시 WebSearch 동적 확인·출처/시점 병기로 대체(RES-3·6·7·10에 반영)
- **프리앰블 3변수 불변식(ACTIVE_SESSIONS/PROACTIVE/SKILL_NAME) 적용**: main에서 기구현 — 커밋 2baa3dc(PR#4). 현재 resume 프리앰블이 3변수를 모두 emit하고 test/test-preambles.sh가 가드. 잔여 정합화는 공유 인프라 INFRA-4 소관

## cover-letter → v0.2.0 (12건)

### CL-1 · 인간화 점검 단계 신설 — Phase 9 뒤·완료 직전 배치 (검증 지적 1·2 반영)  `[P0/M]` · 의존: INFRA-3, INFRA-1

Phase 9(최종 키워드 반영률, 319행) 뒤에 'Phase 9.5: 인간화 점검'을 신설한다. 검증 지적 반영: Phase 5.5가 아니라 모든 문장 수정(Phase 6~8)이 끝난 지점에 배치해 AI풍 문장 재유입을 막는다. 내용: ①templates/humanize-check.md 참조 — 일반론 문장(어느 회사에나 성립), 경험 근거 없는 주장, 균질한 문장 길이를 문장 단위로 표시하고 사용자 고유 경험·수치로 치환 유도. ②'AI 만능 표현' 항목은 신규 정의하지 않고 보이스 섹션(343행) 기존 금지 목록을 참조한다(이중 정의 금지). ③합격 공식 4단계(AI 초안→본인 언어 리라이팅→탐지·표절 셀프체크→최종 점검)를 워크플로로 명시하되 AI 의심 비율 등 시장 통계는 본문에 하드코딩하지 않는다(필요 시 WebSearch로 최신 수치 확인 후 안내). ④인간화 점검 통과 후에만 완료(DONE) 판정과 #118b .docx 자동 emit을 실행한다 — 점검 전 파일 산출 금지 문장을 Phase 4A #118b 항목에 교차 표기. ⑤Phase 4A 말미에 '이 초안은 반드시 본인 언어로 리라이팅해야 합니다' 경고 1줄, 완료 상태 직전에 'GPT킬러·카피킬러 등 탐지 도구 셀프체크 후 제출 권장' 고정 문구 추가.

**완료 판정:**
- SKILL.md에서 인간화 점검 섹션이 Phase 9 뒤·'완료 상태' 앞에 위치한다
- 해당 섹션이 templates/humanize-check.md를 참조하고, AI 만능 표현은 보이스 섹션 참조 문구로만 처리된다(금지 목록 중복 정의 없음)
- '.docx 자동 emit은 인간화 점검 통과 후'라는 조건 문장이 Phase 4A 또는 Phase 9.5에 존재한다
- 본문에 48.5%·65.4% 등 AI 탐지 시장 통계 수치가 하드코딩되어 있지 않다
- bash test/test-preambles.sh 통과(프리앰블 블록 무변경)

### CL-2 · 수치 폴백 5기준·대체 4종 도입 — 날조가드 기구현분 제외 잔여 갭 (검증 지적 3 반영)  `[P0/S]` · 의존: INFRA-1, INFRA-2

main이 이미 Phase 2 질문3(134행)과 Phase 6 말미(266행)에 [추정] 표기·임의 창작 금지를 반영했으므로 잔여 갭만 적용한다. ①질문3을 '함께 추정' 프레임에서 대체 4종 우선 프레임으로 교체: '수치가 없다면 범위·빈도·전후비교·담당규모 중 답할 수 있는 것을 알려주세요' — 추정은 마지막 수단으로만 쓰고 기존 [추정] 표기 규칙은 유지. ②Phase 6 말미(266행)의 '추정 가능한 지표를 질문하여 발굴' 문구도 같은 대체 4종 프레임으로 교체해 '추정' 유도 표현을 전면 제거(검증 지적 3). ③Phase 6에 '수치 폴백 5기준' 소절 추가(templates/experience-methods.md 참조): 전후 변화/역할 범위 분리/정성 근거(피드백·계속 쓰인 양식)/작은 검증가능 숫자(예: '3주 12건 문의 유형 정리')/면접 설명 가능성. ④가드레일 명문화(templates/guardrails.md 참조): 세션에서 제공된 사실만 사용, 수치·자격·경력 창작 금지, 미확인 항목은 [수치 확인 필요] placeholder+1회 질문. 대필형 전면 위임 요청에도 사실 검증 질문을 먼저 거친다(실사용 관측 반영). ⑤변환 예시 표(257행) 아래 '모든 수치는 면접에서 1분 설명 가능해야 한다' 기준 추가.

**완료 판정:**
- Phase 2 질문3과 Phase 6에 '추정 가능한' 유도 표현이 남아 있지 않고 대체 4종(범위·빈도·전후비교·담당규모) 문구가 존재한다
- Phase 6에 수치 폴백 5기준 소절이 있고 templates/experience-methods.md를 참조한다
- [수치 확인 필요] placeholder+1회 질문 규칙과 templates/guardrails.md 참조가 본문에 존재한다
- 변환 예시 표 아래 '면접 1분 설명 가능' 기준 문장이 존재한다

### CL-3 · Phase 4B 진단에 추상어→질문 전환표·약한 문장 5유형 추가 (원안 채택)  `[P1/S]` · 의존: INFRA-2

Phase 4B 7가지 공통 문제 패턴 진단(186~203행) 아래에 templates/experience-methods.md를 참조하는 두 표를 추가한다. ①추상어→질문 전환표: 책임감→'끝까지 맡은 일이 무엇인가?' / 소통→'누구의 이해차를 줄였나?(전달·정리·설득·조정 중 무엇)' / 꼼꼼함→'어떤 오류·누락을 줄였나?' / 문제해결력→'문제를 어떻게 정의했나?' / 성장→'무엇이 달라졌나?' — 진단에서 추상어 발견 시 해당 질문을 사용자에게 던져 근거·소재 발굴로 연결하는 흐름을 명시. ②약한 문장 5유형+보강 패턴: 좋아합니다→행동 사례 / 열심히→역할 구체화 / 성장→전후 비교 / 소통→조율한 차이 명시 / 책임감→범위+문제 처리 기준. 기존 진단 항목 ③(추상적 성과)과 중복되지 않도록 '추상적 역량어' 항목으로 분리 표기한다.

**완료 판정:**
- Phase 4B에 추상어→질문 전환표(5행 이상)와 약한 문장 5유형 표가 존재한다
- 두 표가 templates/experience-methods.md를 참조한다
- '추상적 역량어'가 기존 ③ 추상적 성과와 별도 항목으로 구분되어 있다

### CL-4 · Phase 3 문항 의도 추출 단계 + 지원동기 치환 테스트 2종 (원안 채택, 통계 하드코딩 제거)  `[P1/S]` · 의존: INFRA-3

①Phase 3 서두(142행 앞)에 '문항 의도 추출' 단계 추가: 실제 기업 문항을 받으면 결이요 적용 전에 평가 기준을 먼저 추출한다. 변환표 — 지원동기→선택 이유의 구체성 / 직무역량→강점+근거 / 성장과정→일하는 방식의 형성 / 갈등·실패→판단과 행동 / 포부→회사 일과 연결된 실행. 답변 방향이 모호한 문항이면 '이 문항은 [기준]을 묻는 것으로 해석했습니다'를 명시 출력해 사용자 확인을 받는다. 모호 문항 비율(33.1%) 등 연도별 통계는 본문에 하드코딩하지 않는다. 실사용에서 '자소서 문항 의도 해석' 요청이 반복 관측된 수요 직결 기능. ②지원동기 가이드 '흔한 실수'(154행)에 치환 테스트 2종 추가(templates/humanize-check.md 참조): 회사명 치환 테스트(회사명을 경쟁사로 바꿔도 성립하면 실패), 타 지원자 치환 테스트(다른 지원자 이름으로 바꿔도 성립하면 실패). ③Phase 5 ②논리 점검의 '왜 이 회사인가'(218행)에 이 테스트를 실행 기준으로 명기.

**완료 판정:**
- Phase 3 서두에 문항 의도 변환표(5행)와 모호 문항 해석 확인 출력 규칙이 존재한다
- 지원동기 흔한 실수와 Phase 5 ②에 치환 테스트 2종이 존재하고 templates/humanize-check.md를 참조한다
- 본문에 33.1% 등 모호 문항 비율 통계가 하드코딩되어 있지 않다

### CL-5 · Phase 8 위험 문장 테스트 + mock-interview 경계·defense-map 계약 (검증 지적 4 반영)  `[P1/S]` · 의존: INFRA-9

Phase 8 미끼 포인트 인벤토리(298~309행) 다음에 '위험 문장 테스트' 소절을 추가한다. ①핵심 문장별 예상 꼬리질문 2개 생성 — 공통 5세트(어떤 문제였나/왜 그 방법이었나/역할 범위는/결과를 어떻게 확인했나/다시 한다면) 적용. ②'1분 설명 가능' 기준 판정: 사용자가 즉답 가능→미끼(유지·강화), 즉답 불가→위험 문장(수정 또는 삭제 제안). ③출력 표를 미끼 인벤토리와 대칭 구조로: 위험 문장/예상 질문/위험 이유/조치(수정안 또는 답변 준비). ④예상 질문 30-35개 생성 시 위험 문장 유래 질문에 ⚠️ 표시로 우선 준비 유도. ⑤역할 경계 명시(검증 지적 4): cover-letter는 '위험 문장의 수정/삭제 판단'까지만 담당하고, 답변 연습·심화 준비는 /mock_interview로 핸드오프한다는 문장을 소절과 '다음 추천'(373행)에 추가 — 봇 표기 규칙상 반드시 언더스코어(/mock_interview)로 쓴다. ⑥미끼·위험 문장·예상 질문 산출 구조는 INFRA-9 defense-map YAML 계약을 따라 mock-interview가 소비할 수 있게 한다.

**완료 판정:**
- Phase 8에 위험 문장 테스트 소절(공통 5세트·1분 기준·대칭 출력 표)이 존재한다
- '수정/삭제 판단은 cover-letter, 답변 연습은 /mock_interview' 경계 문장이 존재한다
- bash test/test-command-style.sh 통과(신규 텍스트가 하이픈 명령 표기를 쓰지 않음)
- 산출 구조가 INFRA-9 defense-map 계약 필드와 일치한다

### CL-6 · Phase 7에 중고신입 소절 신설 — 4번째 분기 (원안 채택, main 공공기관 소절 기준 정합화)  `[P1/S]` · 의존: INFRA-1

Phase 7(270행~)은 main에서 이미 신입/경력/공공기관(NCS) 3개 소절이므로, '중고신입인 경우' 소절을 4번째 분기로 신설한다(원안의 '3트랙 확장' 표현을 main 현황에 맞게 정정). ①대상 정의: 경력 약 6개월~3년으로 신입 전형에 지원하는 경우 — 연령대·시장 비율 등 통계는 본문에 하드코딩하지 않고 필요 시 WebSearch로 최신 수치를 확인해 안내. ②핵심 원칙: 경력을 숨기지 않고 무기화 — 실무 경험을 '즉시 투입 가능' 근거로 전면 배치(ETHOS '바로 써보고 싶은 사람'과 직결). ③퇴사·이직 사유는 경력 트랙의 이직 사유 논리화 공식(현 회사 한계→성장 방향→지원 회사 비전)을 축약 적용하되 방어적 변명 톤 금지. ④전 직장 수치 성과를 신입 지원자 대비 차별화 미끼로 배치(Phase 8 미끼 인벤토리와 연결). ⑤Phase 2 서두에 '신입/중고신입/경력 중 어디에 해당하나요?' 확인 질문을 추가한다.

**완료 판정:**
- Phase 7에 '중고신입인 경우' 소절이 존재하고 신입/경력/공공기관 소절과 병렬 구조다
- 소절에 '숨기지 않고 무기화'와 이직 사유 축약 공식이 포함된다
- 본문에 28.1%·33.5% 등 시장 통계가 하드코딩되어 있지 않다
- Phase 2 서두에 3분기 확인 질문이 존재한다

### CL-9 · 재리뷰 감지 + 변경분(delta) 요약 이식 — resume/review #117 패턴 (round2 실사용 수요)  `[P1/S]`

실사용 수요 1순위 패턴은 '피드백→수정본 재리뷰→최종 파일화' 반복 루프인데, main에서 resume(#117)·review에는 재리뷰 delta 요약이 반영됐고 cover-letter에는 없다. Phase 4B 서두(184행)에 동일 패턴을 이식한다: memo.md(또는 워크스페이스의 직전 진단 스냅샷)에 직전 자소서 진단 결과가 있으면 이번 자소서와 대조해 변경분만 3구간으로 요약 — ✅ 해결됨(짧은 축하 톤) / 🔁 여전히 미해결('지난 첨삭 참고'+핵심 한 줄, 전체 재설명 금지) / 🆕 신규. 최초 첨삭(대조 대상 없음)일 때만 7가지 공통 문제 패턴 전체 진단표를 출력한다. 재리뷰 완료 시 이번 진단 결과 스냅샷 저장을 권장하는 문장을 추가한다(review 스킬의 .last-review.md 관례와 동일 형식).

**완료 판정:**
- Phase 4B 서두에 재리뷰 감지 + ✅/🔁/🆕 3구간 delta 요약 규칙이 존재한다
- '최초 첨삭일 때만 전체 진단표 출력' 조건이 명시된다
- 문구 구조가 resume/review의 #117 소절과 동일 패턴이다

### CL-10 · 공공기관 소절에 블라인드 식별정보 필터 + 채용절차법 안내 (round2 공공기관·법제도 리서치)  `[P2/S]` · 의존: INFRA-1

Phase 7 '공기업·공공기관 지원인 경우' 소절(287~292행)에 블라인드 필터링 점검을 추가한다. ①자소서·경험기술서 본문에서 학교명·학점·가족사항·사진·출신지역 등 식별정보가 노출되면 불이익 가능성이 있으므로, 첨삭 시 해당 표현을 표시하고 중립 표현으로 치환 제안(예: 'OO대학교 캡스톤' → '4인 팀 캡스톤 프로젝트'). 단 일부 연구개발목적기관은 블라인드 예외이므로 지원 기관 공고의 블라인드 여부를 먼저 확인하도록 안내. ②채용절차법 제4조의3 기초심사자료 기재 금지 항목(신체적 조건, 출신지역·혼인여부·재산, 직계존비속·형제자매의 학력·직업·재산)을 안내하고, 기업이 요구하더라도 자소서에 쓸 필요가 없음을 사용자에게 알린다. ③경험기술서(무보수)와 경력기술서(금전 대가) 구분 및 경력기술서 두괄식+최근순 원칙을 1줄로 병기한다. PII 처리 등급은 INFRA-1 가드레일 규정을 따른다.

**완료 판정:**
- 공공기관 소절에 블라인드 식별정보 표시·치환 제안 규칙이 존재한다
- 채용절차법 제4조의3 금지 항목 3분류가 안내 문구로 존재한다
- 경험기술서/경력기술서 구분 문장이 존재한다

### CL-11 · Phase 1에 채용공고 원문(JD) 직접 입력 진입점 추가 (round2 실사용 수요)  `[P2/S]` · 의존: INFRA-1

실사용에서 JD 원문을 통째로 붙여넣고 '이 공고 기준으로 첨삭'을 요청하는 패턴이 반복 관측됐다. Phase 1(87~94행) 캐시 확인 로직 앞에 입력 우선순위를 명시한다: ①사용자가 채용공고 원문(또는 URL)을 세션에 직접 제공하면 그것을 1순위 소스로 사용 — 원문에서 자격요건·우대사항·기술 키워드를 추출해 체크리스트의 '채용공고' 소스를 채우고, 나머지 6개 소스(CEO 신년사·인재상 등)만 캐시 또는 WebSearch로 보강. ②URL 제공 시 WebFetch로 본문 확보를 시도하고, 실패하면 한계를 노출하는 대신 '공고 본문을 붙여주세요'로 자료 요청으로 전환한다(guardrails의 한계 노출→자료 요청 규칙). ③붙여넣은 긴 텍스트가 JD 원문인지 자소서 초안인지 구분이 모호하면 1회 질문으로 확인한다.

**완료 판정:**
- Phase 1에 'JD 원문 직접 제공 시 1순위 소스' 규칙이 캐시 확인보다 앞서 존재한다
- WebFetch 실패 시 복붙 요청 전환 문구가 존재한다
- JD/자소서 입력 구분 모호 시 1회 확인 질문 규칙이 존재한다

### CL-12 · 직군별 소재 강조점 분기 표 추가 (round2 비개발직군 리서치)  `[P2/S]`

현행 예시가 개발 직군(Redis·API 등)에 치우쳐 있으므로, Phase 2 소재 발굴 또는 Phase 3 항목별 가이드에 '직군별 강조점' 소표를 추가한다: 개발→구현 범위·기술 선택 이유·장애 대응 / 마케팅→전환율·고객 반응·캠페인 수치와 본인 기여도 / 기획·PM→문제 정의·사용자 흐름·실험과 결과 / 영업→대인 신뢰·고객 중심 문제 해결 스토리(대외활동·아르바이트도 유효 소재, 수치 강박 완화) / 재무·회계→정확성·오류 감축·자격증 근거. 소재 발굴 질문(경험 3가지, 문제·해결)을 직군 강조점에 맞춰 변형해 던지도록 1줄 지침을 병기한다. 직군 정보는 프로필 또는 Phase 0에서 확인된 직무를 사용하고, 미확인 시 1회 질문으로 확인한다.

**완료 판정:**
- Phase 2 또는 Phase 3에 5개 직군 강조점 표가 존재한다
- 영업 직군에 수치 대신 스토리·대인 경험 유효 문구가 포함된다
- 직군 미확인 시 1회 질문 규칙이 존재한다

### CL-7 · 키워드 배치 원칙 — 반영률이 stuffing을 유도하지 않게 (원안 채택)  `[P2/S]`

①Phase 1 키워드 체크리스트 표(110~123행) 아래에 '키워드 운용 원칙' 3줄을 추가한다: 반복 키워드 3~5개 추출 후 핵심 3개를 선정해 '경험 해석 기준'으로 사용한다 / 키워드는 근거(경험·수치) 뒤에 배치한다 — 근거 없이 키워드만 먼저 쓰지 않는다 / 문단당 키워드 1개, 한 문단에 몰아넣기 금지(자소서≠SEO). ②Phase 9(최종 키워드 반영률, 319~327행)에 배치 검증 항목을 추가한다: '반영률 85%+ 달성이라도 근거 없이 삽입된 키워드는 미반영으로 재분류한다'를 명기해 반영률 수치가 keyword stuffing을 유도하지 않게 한다. 7소스·85%+ 목표 자체는 ETHOS와 정합하므로 유지한다.

**완료 판정:**
- Phase 1 표 아래에 키워드 운용 원칙 3줄이 존재한다
- Phase 9에 '근거 없이 삽입된 키워드는 미반영 재분류' 문장이 존재한다
- 기존 반영률 85%+ 목표 문구가 유지된다

### CL-8 · Phase 5 ③ 표현 점검 강화 — 한 문장 한 판단 + 배운 점 규칙 (원안 채택)  `[P2/S]`

Phase 5 ③ 표현 점검(220~235행)의 '추가 표현 수정' 목록에 두 규칙을 추가한다. ①한 문장 한 판단 룰: 쉼표 3개 이상 또는 접속어(그리고·또한·이를 통해·그 결과) 2개 이상 연속이면 분리 신호로 진단하되, 단순히 자르지 말고 문장 역할을 분리(무엇을 했나→왜 했나→결과는)하는 수정안을 제시한다 — 5초 규칙을 문장 단위 가독성까지 확장하는 실행 기준. ②배운 점 규칙: '많은 것을 배웠습니다' 류 감상형 마무리를 발견하면 다음 행동 변화로 전환한다(예: '작업 전 담당자·마감·검수 기준을 먼저 합의하게 되었습니다'). 기존 감정→행동 공식의 하위 사례가 아닌 별도 진단 항목으로 표기하고 Phase 4B 진단 ②(감정·감상 과다)와 상호 참조를 건다.

**완료 판정:**
- Phase 5 ③에 쉼표3·접속어2 분리 신호 룰과 역할 분리 수정안 지침이 존재한다
- 배운 점→행동 변화 전환 규칙이 별도 항목으로 존재하고 Phase 4B ②와 상호 참조된다

### 제외·기구현 (5건)
- **수치 날조 유도 문구 제거 — Phase 2 질문3·Phase 6 '추정' 표현 원안 교체분**: main에서 기구현 — 날조가드 커밋 참조. cover-letter/SKILL.md 134행(질문3: [추정] 표기+임의 창작 금지)과 266행(사용자 확인 없는 확정 수치 금지)에 이미 반영됨. 잔여 갭(대체 4종 프레임 교체, 폴백 5기준, [수치 확인 필요] placeholder+1회 질문, 면접 1분 기준)만 CL-2로 이관.
- **인간화 체크리스트 내 'AI 만능 표현' 항목 신규 정의 (제안 1의 일부)**: main에서 기구현 — 보이스 섹션(343행)에 AI 만능 표현 금지 목록이 이미 존재. 검증 지적 2에 따라 CL-1에서 기존 규칙 참조로만 처리하고 신규 정의는 기각.
- **위험 문장에 대한 답변 연습·심화 준비 기능**: mock-interview 스킬 소관으로 이관 — 검증 지적 4(역할 경계). cover-letter는 위험 문장의 수정/삭제 판단까지만 담당하고, CL-5에서 /mock_interview 핸드오프 경계와 INFRA-9 defense-map 데이터 계약으로 연결.
- **완결 시 .docx 파일 산출·글자수 자동 카운트 (실사용 파일 포맷 수요 대응)**: main에서 기구현 — docx 자동산출 커밋 참조(Phase 4A #118·#118b, 181~182행). CL-1에서 '인간화 점검 통과 후 emit' 순서 조건만 추가.
- **프리앰블 3변수(ACTIVE_SESSIONS/PROACTIVE/SKILL_NAME) 불변식·trap EXIT 정비**: main에서 기구현 — 프리앰블 표준화·세션 파일 누적 수정 커밋 참조. 현재 프리앰블(21~52행)이 3변수 emit+trap EXIT+stale PID 정리를 모두 충족하고 test/test-preambles.sh가 가드 중. 본 업그레이드는 프리앰블 블록을 수정하지 않으며 전 항목 acceptance에 테스트 통과만 명시.

## mock-interview → v0.2.0 (9건)

### MI-1 · AI면접 모드를 'AI면접·AI역량검사 대비' 모드로 현행화 (시장 수치 하드코딩 금지)  `[P0/M]` · 의존: INFRA-1

Phase 2 'D) AI면접'(245-249행) 개편. ①구조적 대비 절차만 기재: 게임형 연습→성향 일관성→상황판단→환경 점검 4단계 체크리스트, 상황판단(SJT) 문항 시뮬 라운드, 성향검사 일관성 원칙('꾸민 답변은 교차 문항에서 모순으로 탐지됨'), BEI 탐침 라운드('그때 구체적으로 무엇을 했나요?'). ②기존 60초 제한·글자수 가이드·두괄식/키워드 평가 유지 + 답변 권장 발화량 안내(면접 발화 약 3.5음절/초, 60초≈200음절 내외 — jobclaw 발화 공식). ③검증 수정방향 반영: 도입사 수·플랫폼 점유율 등 시간 민감 시장 수치는 SKILL.md 본문 기재 금지. 연습 채널 등 특정 플랫폼 안내 시 WebSearch로 현행 서비스 여부를 확인한 후에만 안내한다는 규칙을 모드 규칙에 명시(INFRA-1 가드레일과 동일 계열). ④AI 자동화 채용 결정 관련 구직자 권리 1줄 안내(개인정보보호법 제37조의2 거부·설명요구권, AI 기본법상 고영향 AI 규율) — 시행·계도 상태는 단정하지 않고 필요 시 WebSearch 확인 지시.

**완료 판정:**
- D) 모드에 4단계 체크리스트·SJT 라운드·일관성 원칙·BEI 탐침이 모두 존재한다
- 본문에 도입사 수 등 시장 통계 수치와 특정 연도 시장 주장이 0건이다 (grep 검증)
- 플랫폼 안내 전 WebSearch 확인 규칙 문구가 존재한다
- 기존 60초 제한·두괄식 평가·글자수 피드백이 유지된다
- 구직자 권리 안내 1줄이 있고 법 시행 상태를 단정하는 문장이 없다

### MI-2 · 모드 확장: 임원면접·컬처핏 추가 + 역질문 라운드 고정 (5→7모드)  `[P1/M]`

Step 1 선택지(118-128행, 현재 A~E)에 F) 임원면접, G) 컬처핏 추가, 모든 모드 마지막에 역질문 라운드 1문항 고정. ①임원면접: stakeholder별 관점 질문(CEO=방향성·비전, CTO=기술 판단, 재무=비용 대비 효과, 법무=리스크 — round2 실수요 신호). 면접관 페르소나 목록(71-75행)에 '임원면접: 간결하게 통찰을 묻는 임원 — 압축적 어투, 두괄식 강요'(jobclaw exec tonePrompt 이식) 추가. ②컬처핏: company-cache 인재상·핵심가치 키워드 기반 + 지원 동기 진정성(모티베이션 핏) 질문. 검증 수정방향에 따라 컬처핏 반영률 등 시장 수치는 본문 기재 금지. ③역질문 라운드: 사용자가 면접관에게 질문 → '이미 팀원처럼' 수준(제품·최근 이슈 기반)인지 평가. 질문 세트 구성 표(167-173행)에 '역질문 1문항 고정' 행 추가. ④실수요 반영: 전화 인터뷰 대비 변형(공고+제출 서류 기반 지원동기·경험·가치관·직무지식)을 인성/컬처핏 모드 옵션으로 1줄 안내.

**완료 판정:**
- Step 1 선택지가 A~G 7개다
- 질문 세트 표에 역질문 1문항 고정 행이 존재한다
- 페르소나 목록에 임원면접 항목이 존재한다
- 컬처핏 모드가 company-cache 인재상·핵심가치를 소스로 지정하고 시장 수치가 본문에 없다
- test/test-command-style.sh가 통과한다

### MI-3 · 꼬리질문 의무화 + 고정 질문지 낭독 금지 + 서류 기반 심화 규칙  `[P1/S]`

224행 '다음 질문은 이전 답변을 반영하여 조정할 수 있습니다'를 의무 규칙 블록으로 교체(main이 이미 추가한 182-186행 '대화 견고성' 절과 중복 없이 그 아래 배치). ①고정 질문지 낭독 금지 — 매 질문은 직전 답변 내용을 근거로 생성 ②분기 규칙: 추상적 답변→구체 사례 요구, 사례 답변→역할·수치·트레이드오프 심화 ③공통 꼬리질문 5세트 표(어떤 문제였나/왜 그 방법인가/역할 범위는/결과를 어떻게 확인했나/다시 한다면) 수록, 219-220행 '꼬리질문 예고'가 이 표를 참조 ④답변이 질문과 어긋나면 정답 제시 금지, 확인 질문으로 되묻기 ⑤이력서·자소서가 로딩된 경우 특정 프로젝트를 콕 집어 기여·규모·의사결정·트레이드오프를 파고들고, 서류와 구두 답변 불일치 시 자연스러운 확인 질문(일관성 검증 — jobclaw buildInterviewerSystemPrompt 이식) ⑥침묵·막힘 시 부드러운 환기('괜찮습니다, 천천히 답변해 주세요'), 답변 후 짧은 경청 반응 뒤 다음 질문(reassure/ack 패턴).

**완료 판정:**
- 공통 꼬리질문 5세트 표가 존재하고 꼬리질문 예고가 이를 참조한다
- '조정할 수 있습니다' 선택 표현이 제거되고 의무 규칙으로 대체됐다
- 이력서 기반 심화·불일치 확인 질문 규칙이 존재한다
- 기존 대화 견고성 절(일괄 출제 금지 등)이 그대로 유지된다

### MI-4 · 채점 고도화: 6축 0-100 + 축별 근거 인용 의무 + revision + 4축 이력 하위 호환  `[P1/M]`

검증 수정방향 전면 반영. ①Phase 2 피드백 4축 1-5점(208행), 리포트 항목별 평균 표(276-283행), 총점 계산법(328-331행)을 6축(직무전문성·문제해결·의사소통·논리구조화·자신감태도·성장가능성) 0-100점으로 교체. '1의 자리 정밀 채점 의무화'는 넣지 않는다 — 대신 각 축 점수마다 채점 근거로 사용자 답변 문장 인용을 반드시 첨부(근거 없는 유사 정밀도 방지). ②질문별 상세 리뷰(295-303행)에 revision 필드 추가: 사용자 실제 답변을 결이요 구조로 고쳐 쓴 첨삭문. 모범답안 모음(305-312행)은 유지하되 역할 구분('revision=내 답변 고치기, 모범답안=방향 제시') 명시. 사용자가 답변 전문을 붙여넣는 입력(실수요 관측 패턴)도 revision 대상으로 처리. ③하위 호환: 성장 추이(343-353행)에서 구 4축(1-5점) 기록은 총점 100점 스케일로만 비교하고 축별 비교는 동일 스키마 기록끼리만 수행한다는 규칙 명시. 리포트 헤더(271-272행)에 채점 스키마 버전(6축 v2) 기록.

**완료 판정:**
- 6축 0-100 채점과 축별 답변 인용 근거 의무 규칙이 존재한다
- '1의 자리' 정밀 채점 문구가 없다
- 질문별 리뷰에 revision 필드가 있고 모범답안과의 역할 구분 문구가 있다
- 성장 추이에 구 4축 기록 호환 규칙(총점만 비교)이 명시된다
- 리포트 헤더에 스키마 버전이 기록된다

### MI-5 · 강도 선택 Step 2.5 (순한맛/보통/매운맛) + 페르소나 강도별 어투  `[P1/S]`

Step 2 다음에 Step 2.5 추가: AskUserQuestion으로 순한맛(격려 톤, 답하기 쉬운 질문, 꼬리질문 1단계)/보통(핵심 짚는 질문+적절한 꼬리질문)/매운맛(압박 어투, 날카로운 꼬리질문 2단계 연속, 구체 근거·수치 강한 검증) 선택 — 강도별 프롬프트 문구는 jobclaw Intensity(mild/normal/hard) 정의 이식. 추천: 보통, interview-history가 비어 있으면(첫 세션) 순한맛. 페르소나 목록(71-75행)에 강도별 어투 예시 1줄씩 추가(예: 인성면접 매운맛 '방금 답변은 자소서와 다른데요, 어느 쪽이 사실인가요?'). 강도는 리포트 헤더(271-272행)에 기록해 성장 추이에서 동일 강도끼리 비교. 검증 수정방향 반영 — 상호 참조 명시: no-arg 즉시 시작(MI-6) 경로에서는 이 질문을 생략하고 기본 강도(보통)를 적용하며, 세션 중 '매운맛으로 바꿔줘' 요청 시 즉시 전환 가능.

**완료 판정:**
- Step 2.5가 존재하고 3강도 정의·추천 규칙이 있다
- no-arg 경로에서 강도 질문 생략+기본 강도 적용+세션 중 변경 가능 상호 참조 문구가 있다
- 리포트 헤더에 강도가 기록되고 성장 추이 비교 규칙에 반영된다

### MI-6 · no-arg 즉시 시작 경로 (설정 질문 생략, 진행 중 맥락 보강)  `[P1/S]` · 의존: MI-5, INFRA-1, INFRA-10

Phase 1 앞에 '즉시 시작 규칙' 문단 추가: 인자 없이 호출되고 company-cache·자소서·프로필이 모두 없으면 모드/기업/강도(Step 2.5) 질문을 전부 생략하고 인성면접 공통 질문('자기소개 부탁드립니다')으로 즉시 시작 — 기본 강도 보통 적용(MI-5 상호 참조, 검증 수정방향 반영). 2-3문항 후 자연스럽게 '어느 기업을 준비 중이신가요?'로 맥락 보강, 이후 질문부터 기업 맞춤 전환. 캐시·자소서·프로필이 하나라도 있으면 기존 Phase 1 흐름(자동 감지+추천) 유지. '준비된 자료가 없어 진행할 수 없다' 류 한계 노출 문구 금지 — 필요 자료 요청으로 변환(INFRA-1 가드레일). no-arg 시작은 empty-start=정상 진입 경로로 취급하고 skill-usage.jsonl에 별도 이벤트로 기록(INFRA-10 규격).

**완료 판정:**
- 인자·자료 전무 시 첫 응답이 설정 질문 없이 면접 질문으로 시작한다는 규칙이 존재한다
- 2-3문항 후 기업 맥락 보강 전환 규칙이 있다
- 한계 노출 금지→자료 요청 변환 문구가 있다
- no-arg 이벤트가 INFRA-10 규격으로 기록된다

### MI-7 · 완료 상태 프로토콜 동기화 + jobstack-view 안내 + 저장 시 제3자 PII 익명화  `[P2/S]` · 의존: INFRA-1

①'완료 상태 프로토콜'(357-364행)을 templates/completion-status.md 현행본과 동기화: BLOCKED 항목에 '채용공고·최신 뉴스 등 시간 민감 데이터는 훈련 데이터로 절대 대체하지 않고 해당 섹션 스킵 후 DONE_WITH_CONCERNS 처리' 조항 추가. ②Phase 4 저장(335-341행) 직후 결과물 뷰어 안내 의무화: `$CLAUDE_SKILL_DIR/../bin/jobstack-view <리포트.md>`로 브라우저 열람+PDF 저장 가능함을 반드시 안내(템플릿 문구 사용). ③round2 PII 3등급 반영: 리포트의 답변 인용에 포함된 제3자(전 직장 동료·상사 등) 실명·연락처는 익명화('동료 A')하여 저장 — 사용자 본인 정보는 허용, 제3자는 익명화(INFRA-1 등급 정의 참조). 참고: 다음 스킬 추천의 언더스코어 표기는 main d908ab1에서 이미 정리됨 — 신규 문구도 BOT-COMMAND-STYLE 준수.

**완료 판정:**
- BLOCKED 항목에 훈련 데이터 대체 금지 조항이 templates/completion-status.md와 동일하게 존재한다
- Phase 4에 jobstack-view 안내 의무 문구가 존재한다
- 제3자 실명·연락처 익명화 저장 규칙이 존재한다
- test/test-command-style.sh가 통과한다

### MI-8 · 직군별 질문 초점 분기 확장 (디자인·영업 추가 + 평가 축 보강)  `[P2/S]`

E) 기술면접(251-258행)의 직무별 맞춤 목록 확장: 디자인(디자인 프로세스 단계별 수행 + 포트폴리오 딥다이브, 팀 내 갈등·의견 제시 경험)과 영업(고객 중심 문제 해결 스토리텔링, 대인관계·추진력 — 포트폴리오 대신 대외활동·아르바이트 경험도 유효 소재로 인정) 추가. 기존 마케팅 항목에 '캠페인 성과 수치와 본인 기여도 분리 확인', 기획 항목에 '기획 프로세스(목표설정→조사분석→아이디어→계획→실행평가) 단계별 역할' 평가 초점 1줄씩 보강(round2 직군별 평가 축 매트릭스). 인성/컬처핏 모드에 '영업 직군은 긍정 마인드·신뢰 인상 평가 비중이 높다' 분기 노트 1줄. 공기업·공공기관 지원이면 직업기초능력 기반 경험 질문을 포함하고, 관련 심화는 /cover_letter의 공기업 소절을 안내(/ncs는 봇 미노출이라 추천 금지 — BOT-COMMAND-STYLE 준수).

**완료 판정:**
- 직무별 목록에 디자인·영업 항목이 존재한다
- 마케팅·기획 항목에 평가 초점 보강 문구가 있다
- 공공기관 분기가 /cover_letter 안내로 연결되고 /ncs 추천이 없다
- test/test-command-style.sh가 통과한다

### MI-9 · defense-map 소비: 미끼 질문 소스 연계 + 미끼 전략 활용률 표기  `[P2/S]` · 의존: INFRA-9

Phase 1 Step 3 맥락 자동 로딩(145-161행)에 4번째 소스 추가: review/cover-letter가 산출한 defense-map YAML(미끼 문장|예상 꼬리질문 인벤토리 — INFRA-9 데이터 계약)이 상태 디렉토리에 있으면 미끼 질문(40%)의 1순위 소스로 사용하고, 자소서 직접 추출은 폴백으로 유지. 파싱 실패 시 오류를 노출하지 않고 조용히 기존 폴백으로 진행. Phase 3 리포트에 '미끼 전략 활용률'(defense-map의 미끼 중 면접 답변에서 실제 활용된 비율) 1줄 표기 — E2E 리포트에서 관측된 대표 약점('미끼를 자소서에 심고 면접에서 안 씀')을 직접 계측하는 지표. 스킬 간 산출물 재사용(기업분석→자소서→면접) 체인 설계 원칙 반영.

**완료 판정:**
- Step 3에 defense-map 소스와 폴백 규칙이 존재한다
- 파싱 실패 시 조용한 폴백 규칙이 명시된다
- 리포트에 미끼 전략 활용률 표기 항목이 존재한다

### 제외·기구현 (1건)
- **프리앰블 bash 문법 오류 수정 (스킬 실행 차단 버그)**: main에서 기구현 — 커밋 055646a(PR#4 2baa3dc 머지)로 mock-interview 47행 for 루프가 이미 `for _f in "$_JS_STATE/sessions/"*;`로 수정됐고 trap EXIT·3변수 불변식(ACTIVE_SESSIONS/PROACTIVE/SKILL_NAME emit)도 현행이며 test/test-preambles.sh가 가드 중. 검증 지적(templates/preamble.md에 trap EXIT·stale PID 정리 루프가 없어 템플릿 기준 덮어쓰기 시 회귀)의 잔여 갭은 '수정된 루프를 템플릿에 역반영'으로, 이 스킬 범위가 아닌 공유 인프라 INFRA-4의 범위.

## retro → v0.2.0 (9건)

### RET-1 · 면접 형식 목록에 AI역량검사·AI화상면접·코딩테스트 유형 추가 + 유형별 회고 축  `[P0/S]`

Phase 2 질문 2(현재 "인성/PT/토론/기술/임원")를 "인성/PT/토론/기술/임원/AI역량검사/AI화상면접/코딩테스트"로 확장. Phase 3에 유형별 회고 축 소절 추가: ①AI역량검사=성향 응답 일관성·게임형 과제 수행·환경 문제 여부 ②AI화상면접=답변 내용과 비언어 지표(목소리 크기·떨림·더듬)를 분리 진단 — jobclaw-interview 리포트의 '음성/표정이 아니라 답변 내용만 평가, 음성 지표는 별도 첨부' 평가 축 분리 원칙 적용 ③코딩테스트=AI 금지 환경 기본기 vs AI 활용 과제 중 어느 쪽에서 막혔는지 구분. 액션 라우팅(검증 수정 반영): AI역량검사·AI화상면접→`/mock_interview` D) AI면접 모드(기술 모드 아님 — main mock-interview에 D 모드 실재), 코딩테스트→`/mock_interview` E) 기술면접. 도입 기업 수·지표 개수 등 시효성 수치는 본문에 기입하지 않고 "최신 도입 현황이 필요하면 WebSearch로 확인" 지시만 둔다. 사용자 노출 명령은 언더스코어 표기(templates/BOT-COMMAND-STYLE.md).

**완료 판정:**
- Phase 2 질문 2 선택지에 AI역량검사·AI화상면접·코딩테스트가 포함된다
- AI화상면접 회고 액션이 /mock_interview D) AI면접 모드로 라우팅된다 ('기술 모드' 표기 없음)
- AI화상면접 축에 답변 내용/비언어 지표 분리 진단 문구가 있다
- 본문에 '1,200개사' 등 도입 기업 수·시장 수치가 없다
- test/test-command-style.sh 통과

### RET-2 · 탈락 원인 분석(B) 전형 단계별 분기 플로우 — tracker 한국어 상태값 기준 재작성  `[P0/M]` · 의존: INFRA-5

Phase 1의 B) 선택 시 전용 플로우 신설(검증 수정 반영: 영문 8상태 전제 전면 제거). $_JS_STATE/tracker/applications.jsonl에서 해당 건의 status를 확인해 탈락 직전 단계를 추정 — 상태값은 tracker v0.1.0 실제 한국어 값(준비중/서류전형/서류합격/1차면접/2차면접/최종합격/불합격) 기준. 기록이 없으면 AskUserQuestion 1회로 탈락 단계(서류/코테·AI역량검사/1차면접/2차면접·최종) 확인. 단계별 진단 축: 서류=공고 키워드 반영률(7가지 키워드 소스 체크리스트 대조)+ATS 형식 리스크(표·그래픽·이미지·비표준 제목), 코테·AI역량검사=RET-1 축 재사용, 1차 면접=직무역량+컬처핏, 최종=컬처핏·모티베이션 핏+임원 관점 답변. 단계별 평가 비중(%) 등 시효성 수치는 본문 미기입 — 필요 시 WebSearch 확인 지시만(검증 수정 반영). 기존 Phase 2(면접 인터뷰)는 면접 단계 탈락에만 적용함을 명시. 탈락 건 마무리에 채용서류 반환 청구권 안내 1줄 추가(채용절차법상 반환 청구·보관·파기 의무 존재, 구체 기간·절차는 안내 시점에 법령 확인).

**완료 판정:**
- 서류 탈락 시나리오에서 Phase 2 면접 인터뷰를 건너뛰고 서류 진단 축(키워드 반영률+ATS 형식)이 실행된다
- 플로우의 상태값이 tracker/SKILL.md의 한국어 상태값과 정확히 일치한다 (applied/document_pass 등 영문 키 없음)
- 본문에 컬처핏 비중 % 등 시장 수치가 없다
- 탈락 건 회고에 채용서류 반환 청구권 안내가 포함된다

### RET-3 · 회고 파일 YAML 프론트매터 스키마 + weakness_tags 기반 패턴 집계  `[P1/M]` · 의존: INFRA-5, INFRA-1

Phase 5 저장 규칙에 프론트매터 스키마 정의: date/company/role/stage/result/weakness_tags/actions. stage 값은 tracker 한국어 상태값 중 하나로 제한(검증 수정 반영: '8상태 값' 정의 폐기, INFRA-5 canonical 모델 확정 시 그 매핑을 따름). weakness_tags는 고정 8태그로 제한: 기업연구부족·꼬리질문대응·수치화부족·기술깊이·기준미스매치·근거부족·표현문제·컬처핏. Phase 3.3의 Grep 대상을 자유 키워드("개선 필요", "아쉬운 점", "BLOCKED")에서 `weakness_tags:` 라인 집계로 교체하되, 프론트매터 없는 구서식 파일은 기존 키워드 Grep 폴백 유지(자유 서식 집계 취약성은 현행 Phase 3.3에서 확인된 사실 — 방향 유효 판정). 회고 파일에 면접관 실명·연락처 등 제3자 정보 기록 금지 명시 — 3등급 PII 정책(제3자=금지, 익명화·집계만) 및 templates/guardrails.md 참조. 경로 표기는 $_JS_STATE 유지(test-no-home-paths.sh 통과 필수).

**완료 판정:**
- 신규 회고 파일에 7필드 프론트매터가 생성되고 weakness_tags 값이 고정 8태그 내에서만 나온다
- stage 값이 tracker 한국어 상태값과 일치한다
- 프론트매터 있는 파일과 구서식 파일이 혼재해도 패턴 집계에 둘 다 포함된다
- 제3자 PII 기록 금지 문구가 Phase 5에 존재한다
- test/test-no-home-paths.sh 통과

### RET-4 · Phase 3.4 탈락 원인 3축 분리 진단(기준→근거→표현) + 축별 라우팅  `[P1/S]` · 의존: INFRA-2

Phase 3에 3.4절 추가(원안 채택 — main과 충돌 없음, 명령 표기만 정합화): 탈락 원인을 ①기준 미스매치(공고가 반복 요구한 기준과 내 소재의 어긋남) ②근거 부족(문제·역할·행동·변화 중 빠진 요소) ③표현 문제(추상어·구조) 순으로 분리 진단. 축별 라우팅: 기준→`/company_research` 재분석, 근거→`/cover_letter` 소재 보강(경험 전환 6단계 — templates/experience-methods.md 참조), 표현→`/review`. Phase 4 액션플랜 예시(main 기준 이미 언더스코어 표기)에 각 항목 앞 3축 라벨([기준]/[근거]/[표현])을 붙여 출력하도록 갱신. 직무 변경 후 탈락이면 '기준부터 재점검'(같은 경험도 새 직무 공고 키워드로 재해석) 1줄 추가.

**완료 판정:**
- Phase 3.4가 존재하고 3축 각각에 라우팅 스킬이 명시된다
- Phase 4 예시 항목에 3축 라벨이 붙어 출력된다
- 라우팅 명령이 전부 언더스코어 표기이고 test/test-command-style.sh 통과
- 직무 변경 시 기준 재점검 안내가 포함된다

### RET-5 · Phase 3.1에 꼬리질문 공통 5세트 재점검 + 위험 문장 표시  `[P1/S]`

Phase 3.1(답변 품질 분석)에 항목 추가(원안 채택): 사용자가 말한 핵심 답변 각각에 꼬리질문 공통 5세트(어떤 문제였나/왜 그 방법이었나/역할 범위는/결과를 어떻게 확인했나/다시 한다면)를 대조해, 지금도 즉답이 어려운 문장을 '위험 문장'으로 표시하고 '1분 설명 가능' 기준의 재구성 과제를 낸다. Phase 3.2의 미끼 전략 확인과 연결: 미끼를 던졌는데 꼬리질문에서 무너진 지점을 별도 표시하고, 해당 지점을 다음 `/mock_interview` 연습 대상으로 지정한다(E2E에서 확인된 '미끼 전략 활용 20%' 약점 패턴 대응). 위험 문장에 weakness_tags의 '꼬리질문대응' 태그를 연동한다.

**완료 판정:**
- Phase 3.1에 꼬리질문 5세트 대조 항목이 존재한다
- 즉답 불가 문장이 '위험 문장'으로 표시되고 재구성 과제가 출력된다
- 미끼 이후 방어 실패 지점이 별도 표시되고 /mock_interview 연습 대상으로 연결된다

### RET-6 · 액션플랜 작성 규칙 — 감상 금지, 행동 변화 문장으로  `[P2/S]`

Phase 4 상단에 작성 규칙 2줄 추가(원안 채택 — main Phase 4 예시는 이미 행동형이므로 규칙 명문화만): "회고 항목에 '~을 느꼈다/배웠다' 같은 감상 금지. 모든 항목은 다음 지원에서 달라질 행동 한 문장으로 기록한다(예: '면접 전 해당 팀 최근 업데이트 3건을 시간순 정리한다')." To-Do 체크리스트 예시도 이 형식으로 통일. ETHOS 어조 전환 공식(희망→실행, 감정→행동)과 동일 계열임을 주석으로 명시.

**완료 판정:**
- Phase 4 상단에 감상 금지 + 행동 문장 규칙 2줄이 존재한다
- To-Do 예시가 전부 행동 변화 문장 형식이다

### RET-7 · 완료 상태 4상태 정합화 + jobstack-view 뷰어 안내  `[P2/S]`

완료 상태 섹션(main 기준 여전히 DONE 2종만 존재 — 잔여 갭 확인됨)을 templates/completion-status.md의 4상태로 확장: 회고 대상 기록이 전혀 없어 진행 불가→NEEDS_CONTEXT, 패턴 분석인데 기록 3건 미만→DONE_WITH_CONCERNS, 사용자 중단·정보 회수 불가→BLOCKED, 정상 완료→DONE(단일/패턴 구분 유지). Phase 5에 회고 파일 저장 후 뷰어 안내 추가: ```$CLAUDE_SKILL_DIR/../bin/jobstack-view <회고파일.md>``` (템플릿의 '결과물 생성 시 반드시 안내' 규정 준수). 다음 추천 명령은 main에서 이미 언더스코어(/mock_interview·/company_research)로 정리됐으므로 그대로 유지하고 변경하지 않는다.

**완료 판정:**
- 완료 상태 섹션에 DONE/DONE_WITH_CONCERNS/BLOCKED/NEEDS_CONTEXT 4상태와 각 판정 조건이 존재한다
- Phase 5에 jobstack-view 안내 블록이 존재한다
- 다음 추천 명령 표기가 변경되지 않고 test/test-command-style.sh 통과

### RET-8 · 누적 패턴 분석(C)에 '반복 정체 단계 × 약점 태그' 교차 표시 (역할 경계 정리판)  `[P2/S]` · 의존: INFRA-5, RET-3

Phase 3.3에 applications.jsonl(현재 상태 스냅샷)을 함께 Read해, tracker 한국어 상태값 서열(준비중→서류전형→서류합격→1차면접→2차면접→최종합격, 불합격은 별도 표기) 기반 근사로 '반복 탈락·정체 단계'를 판정하고 weakness_tags와 교차 표시한다(예: "1차면접 단계 불합격 3회 + 꼬리질문대응 태그 3회 = 1차 면접이 병목"). 검증의 3중 결함 수정 반영: ①영문 상태 키 계산식 제거 ②전이 이력이 없는 스냅샷 기반 근사임을 출력에 명시 ③전환율 수치 산출·지원 통계·7일 정체 넛지는 tracker(stats/calendar) 소관으로 retro에서 제외 — retro는 교차 해석만 담당. 병목 단계가 확인되면 `/strategy` 재수립 추천의 근거 문장으로 연결. 패턴 출력 예시 블록을 이 형식으로 갱신.

**완료 판정:**
- Phase 3.3 출력에 정체 단계 × 약점 태그 교차 행이 포함된다
- document_pass 등 영문 상태 키·전환율 계산식·7일 넛지가 본문에 없다
- 스냅샷 기반 근사임을 알리는 문구가 출력 예시에 있다
- 병목 판정 시 /strategy 추천 근거로 연결된다

### RET-9 · 회고 완료 텔레메트리 후속 이벤트 (INFRA-10 규격)  `[P2/S]` · 의존: INFRA-10, RET-3

현행 프리앰블의 시작 이벤트에 더해, 회고 완료 시 skill-usage.jsonl에 후속 이벤트 1줄을 append하도록 Phase 5에 지시 추가: {"skill":"retro","event":"done","mode":"A|B|C","stage":"<탈락 단계, B모드일 때>","tags":[weakness_tags]} — INFRA-10 이벤트 규격을 따른다. 고정 태그·상태값만 기록하고 자유 텍스트·제3자 PII는 미포함(3등급 PII 정책 — 서비스 사용자 데이터는 익명화·집계만). 근거: 실사용 데이터에서 '서류 탈락 이유 진단'이 핵심 수요이고 재방문(2차 점검 요청률)이 제품 지표이므로, B 모드 사용률·태그 분포가 개선 우선순위 판단에 필요.

**완료 판정:**
- 회고 완료 시 event:done 라인이 skill-usage.jsonl에 append된다
- 이벤트에 자유 텍스트·이름·연락처 필드가 없다 (mode/stage/tags만)
- 이벤트 스키마가 INFRA-10 규격 문서와 일치한다

### 제외·기구현 (7건)
- **영문 8상태 모델(applied→document_pass→…offer|rejected/withdrawn) 전제 (제안 2·3·8 공통)**: 검증 기각 — main의 tracker v0.1.0은 한국어 상태값(준비중/서류전형/서류합격/1차면접/2차면접/최종합격/불합격)을 사용하며 '내부 결정기록(2026-05-18)'은 저장소에서 미발견. canonical 상태 모델 확정은 INFRA-5로 이관, retro 항목들은 한국어 상태값 기준으로 재작성(RET-2/3/8).
- **퍼널 전환율 수치 산출 (제안 8의 일부)**: 검증 판정으로 tracker stats 확장으로 이관 — applications.jsonl은 상태 스냅샷만 저장(전이 이력 없음)이라 전환율 산출 불가하고, 지원 통계는 tracker stats 소관. retro에는 '정체 단계 × 약점 태그 교차 표시'만 잔존(RET-8).
- **7일 이상 정체 건 후속 확인 넛지 (제안 8의 일부)**: 검증 기각 — tracker calendar의 D-7 강조와 역할 중복. tracker 소관으로 이관.
- **컬처핏 단계별 비중(57.6%/36.9%/32.6%)·AI 전형 도입 기업 수(1,200개사+/150개사)·수시채용 54.8% 등 시장 수치 본문 기입**: 검증 기각 — 시효성 수치의 SKILL.md 하드코딩은 출처 검증 불가+낡은 수치 단정 리스크. rationale 참고용으로만 두고 본문은 진단 축 구분+WebSearch 동적 확인 지시로 대체(RET-1/2).
- **AI화상면접 액션의 '/mock-interview 기술 모드' 라우팅**: 검증 수정 — main mock-interview에 'D) AI면접 모드'(시간제한+글자수 제한 시뮬레이션)가 실재하므로 D 모드로 라우팅 정정(RET-1에 반영). 하이픈 표기도 test-command-style.sh 위반이라 /mock_interview로 정정.
- **프리앰블 3변수(ACTIVE_SESSIONS/PROACTIVE/SKILL_NAME)·trap EXIT·6개 디렉토리 mkdir 보강**: main에서 기구현 — 커밋 참조: 2baa3dc(PR#4 프리앰블 표준화)·055646a(좀비 청소 루프 수정)·eea3c6c(trap EXIT+stale PID 정리). retro 프리앰블이 3변수 emit·6디렉토리 mkdir을 이미 충족하고 test/test-preambles.sh가 가드 중.
- **경로 표기 ~/.jobstack → $_JS_STATE 정정 및 추천 명령 언더스코어 표기 정리**: main에서 기구현 — 커밋 참조: ff0e43b·d908ab1(봇 경계 드리프트 정리, 표기 lint 신설). retro 본문 경로·명령 표기가 이미 정리됐고 test-no-home-paths.sh·test-command-style.sh가 가드 중. 신규 항목은 이 표기를 유지하는 조건만 acceptance에 포함.

## review → v0.2.0 (8건)

### REV-1 · Phase 6 산출물 모순 해소 — File output protocol 기반 질문 세트 영속화  `[P0/S]` · 의존: INFRA-9

현재 main 175행 '파일로 저장: `면접예상질문-{기업명}.md`'는 allowed-tools에 Write가 없어 최소권한 설계와 불일치('실행 불가'가 아니라 Bash echo 우회 등 비일관 동작 유발). 수정: ①질문 세트를 응답 본문에 인라인 출력. ②영속화는 main에 이미 존재하는 File output protocol 패턴(resume/cover-letter #118b와 동일: Bash heredoc으로 `runs/$JOBCLAW_RUN_ID/output/source.md` 작성 → `[OUTPUT_FILE: ...]` 마커)을 따르도록 명시 — Write 도구 추가 금지, '이 산출물에 한해 Bash 파일 쓰기를 허용한다'를 문서에 명기해 소실 리스크 제거. CLI 환경(런 디렉토리 없음)에서는 현재 디렉토리에 Bash heredoc 저장 후 기존 '결과물 뷰어'(188~192행) 안내 유지. ③마지막 줄 핸드오프는 밑줄 표기 `/mock_interview` 유지하고 저장된 질문 세트 파일 경로를 함께 안내. 질문 세트의 mock-interview 소비 포맷은 INFRA-9 defense-map 계약을 따른다.

**완료 판정:**
- review/SKILL.md allowed-tools에 Write가 추가되지 않았다
- Phase 6에 인라인 출력 + Bash 기반 영속화(OUTPUT_FILE 프로토콜, CLI 폴백 포함) 지시가 있고, 근거 없는 '파일로 저장' 단독 지시가 남아있지 않다
- test/test-command-style.sh가 통과한다(신규 텍스트에 하이픈 명령 없음)

### REV-2 · 재점검 루프 완성 — main #117 기구현분 제외 잔여 갭 (분기·완료조건·recheck 텔레메트리)  `[P0/M]` · 의존: REV-1, INFRA-10

main은 Phase 1 재리뷰 감지+delta 3구간 요약(#117, 81~89행)까지 구현됨. 잔여 갭만 추가: ①Phase 5 직후 AskUserQuestion(templates/ask-user-question.md 구조 준수)으로 'A) 지금 수정 반영 후 재점검 B) 수정 후 나중에 다시 /review C) 이대로 제출' 분기. A/B의 수정 주체 명시: review는 Write가 없어 문서를 직접 수정하지 않으며, 사용자가 직접 수정하거나 `/resume`·`/cover_letter`로 핸드오프 후 재실행한다고 문서화. 재실행이 #117 delta 경로를 타도록 `.last-review.md` 스냅샷 저장(REV-1과 동일한 Bash heredoc 방식)을 '권장'에서 '필수'로 승격(89행). ②완료 상태(183~186행) 재정의: DONE=재리뷰에서 체크리스트 전항 통과, 1차 진단만 하고 종료=DONE_WITH_CONCERNS(미재검 항목 명시). ③완료 시점 텔레메트리에 `"recheck":true/false` 필드 추가 — 이벤트 스키마는 INFRA-10 규격을 따르며 2차 점검 요청률 측정을 가능하게 한다.

**완료 판정:**
- Phase 5 뒤에 AskUserQuestion 3분기가 있고 A/B 옵션에 수정 주체(사용자 직접 또는 /resume·/cover_letter 핸드오프)가 명시돼 있다
- 완료 상태 정의가 '재리뷰 통과=DONE / 1차 진단만=DONE_WITH_CONCERNS'로 기술돼 있다
- skill-usage.jsonl 후속 이벤트에 recheck 필드가 기록되는 지시가 있고 INFRA-10 스키마와 일치한다
- .last-review.md 스냅샷 저장이 필수 지시로 표기돼 있다

### REV-3 · 진단 지적 출처 강제 — 위치·원문 인용 의무화 + 반박 시 재검증  `[P1/S]` · 의존: INFRA-1

Phase 5의 '보완이 필요한 항목에 대해 구체적 수정 방안을 제시합니다'(162행)를 규칙 3줄로 확장: ①모든 지적은 `파일명 > 문항/섹션 + 원문 문장 인용` 형식으로 위치·근거 표시 ②원문에 없는 내용을 근거로 지적 금지 — 날조 금지 원칙은 templates/guardrails.md를 참조(스킬 내 중복 정의 금지) ③사용자가 지적에 반박하면 해당 원문을 다시 Read하여 재검증 후 정정 또는 근거 재제시. '보이스'(179~181행)에 '틀렸다는 반박을 받으면 방어하지 말고 원문부터 재확인' 한 줄 추가. main의 날조가드·출처강제 방향(cover-letter `[추정]` 표기, job-search '근거 부족' 배지)과 정합 — review에는 아직 해당 장치가 없어 잔여 갭 전체가 유효.

**완료 판정:**
- Phase 5에 지적 형식 규칙(파일명>섹션+원문 인용) 3줄이 존재한다
- 날조 금지 조항이 templates/guardrails.md 참조로 연결돼 있다
- 보이스 섹션에 반박 시 원문 재확인 규칙이 있다

### REV-4 · Phase 4 AI스러움 진단 — templates/humanize-check.md 참조로 치환 테스트 2종 추가  `[P1/S]` · 의존: INFRA-3

Phase 4 '자소서 구조 점검'(124~127행)에 치환 테스트 2종(회사명→경쟁사 치환, 주어→타 지원자 치환) 항목을 추가하되, 판정 로직은 templates/humanize-check.md를 참조하고 스킬 본문에 자체 정의하지 않는다(cover-letter·humanize 신규 스킬과의 3중 중복 방지 — 다이제스트 지적 사항). 실패 문장은 원문 인용으로 나열하고, 보강 방향은 표현 교정이 아닌 '경험 근거(문제·역할·행동·변화) 추가'로 안내. Phase 5 체크리스트에 '[ ] AI풍 일반문장 — 치환 테스트 통과' 항목 연동. AI 자소서 탐지율 등 시장 통계는 본문에 하드코딩하지 않으며, 사용자에게 근거 제시가 필요할 때만 WebSearch로 최신 수치를 확인해 출처·시점과 함께 인용한다는 규칙을 명기.

**완료 판정:**
- Phase 4에 치환 테스트 2종 항목이 있고 templates/humanize-check.md 참조로 연결돼 있다(자체 판정 로직 중복 정의 없음)
- Phase 5 체크리스트에 치환 테스트 연동 항목이 존재한다
- 본문에 특정 연도·퍼센트 등 시장 통계 하드코딩이 없고 WebSearch 동적 확인 규칙이 있다

### REV-5 · 미끼 인벤토리에 '방어 판정' 열 추가 — 위험 문장 탐지 및 defense-map 산출  `[P1/S]` · 의존: INFRA-9, REV-1

Phase 4 미끼 포인트 표(129~140행)에 '방어 판정' 열 추가: 각 미끼 문장에 공통 꼬리질문 5세트(어떤 문제였나/왜 그 방법인가/역할 범위는/결과를 어떻게 확인했나/다시 한다면)를 적용해 서류 내용만으로 1분 설명이 가능한지 판정. 즉답 근거가 서류에 없으면 `⚠️위험`으로 표시하고 '면접 전 답변 준비 필수 또는 문장 수위 조정' 중 택일 안내. Phase 6 질문 생성 시 위험 문장 기반 질문을 최우선 배치. 미끼 문장·예상 질문·방어 판정 매핑은 INFRA-9 defense-map YAML 계약 형식으로 산출해(REV-1의 파일 영속화 경로 재사용) mock-interview가 소비할 수 있게 한다 — '면접의 60~70%를 내 답변으로 채우기' 목표와 서류-면접 일관성 원칙의 연결 지점.

**완료 판정:**
- 미끼 표에 방어 판정 열과 ⚠️위험 표기 규칙, 택일 안내가 존재한다
- Phase 6에 위험 문장 기반 질문 최우선 배치 지시가 있다
- defense-map 산출 형식이 INFRA-9 계약을 참조한다

### REV-6 · Phase 5 체크리스트에 개인정보 과다 기재 경고 항목 추가  `[P1/S]` · 의존: INFRA-1

Phase 5 체크리스트에 '[ ] 개인정보 점검' 항목 추가: ①채용절차법 제4조의3 금지 항목(용모·키·체중 등 신체 조건, 출신지역·혼인·재산, 직계존비속·형제자매의 학력·직업·재산) 기재 여부 — 발견 시 삭제를 권고하고, 기업이 기재를 요구한 경우라면 법 위반 소지(500만원 이하 과태료)임을 사용자에게 안내 ②블라인드/공공기관(NCS) 지원 시 자소서·경험기술서 내 학교명 등 식별정보 노출 검사(노출 시 불이익 가능) ③주민등록번호·상세 주소 등 채용에 불필요한 과다 개인정보. 판정 등급·분류 기준은 templates/guardrails.md의 PII 등급 체계를 참조하고 스킬 내 중복 정의하지 않는다. '제출 전 마지막 관문'이라는 스킬 정의상 PII 최종 필터 위치로 review가 적합.

**완료 판정:**
- Phase 5 체크리스트에 개인정보 점검 항목(법정 금지항목·블라인드 식별정보·과다 PII 3종)이 존재한다
- 판정 기준이 templates/guardrails.md PII 등급 참조로 연결돼 있다
- 법 위반 소지 안내 문구가 사용자 권리 안내 형태로 기술돼 있다

### REV-7 · Phase 5 판정 보강 — 3계층 우선순위 정렬 + 루브릭 선공개 (점수화 도입 없음)  `[P2/S]`

①보완 항목을 '기준(공고 연결)→근거(경험 구체성)→표현(맞춤법·글자수)' 3계층으로 정렬해 수정 순서를 명시 — 현 체크리스트(144~160행)는 '결이요 구조'와 '글자수'가 같은 층위로 나열됨. 기준·근거가 약한 상태의 표현 교정을 후순위로 미루는 자소서 수정 우선순위 3단계 원칙 반영. ②점검 시작 시(Phase 2 진입 전) 체크 9항목과 판정 기준(무엇을 ✓/!로 판정하는지)을 한 표로 선공개 — 실사용자의 평가 기준 투명성 요구('점수화·우선순위 기준을 먼저 알려달라') 반영. ③검증 기각에 따라 0~100 종합 점수·90점 기준선은 도입하지 않고(LLM 점수 재현성 부재, main #122 스코어 결정성 원칙과 충돌) 기존 '통과 N/9' 표기를 유지한다.

**완료 판정:**
- 보완 항목 출력이 3계층(기준→근거→표현) 정렬로 기술돼 있다
- 점검 시작 시 루브릭(항목+판정 기준) 선공개 단계가 존재한다
- 0~100 점수·합격선 표기가 문서 어디에도 없다

### REV-8 · Phase 3에 keyword stuffing 금지 확인 한 줄 추가  `[P2/S]`

Phase 3 대조 항목(115~118행) 아래에 1~2줄 추가: '키워드 한 문단 몰아넣기 금지(자소서≠SEO) — 키워드가 경험 근거 뒤에 자연스럽게 배치됐는지 확인하고, 몰아넣기 발견 시 보완 항목으로 지적한다.' 원안(gap #6)의 ATS 파싱 안전성·제출 포맷·분량 3항목은 검증 기각(resume 스킬 중복·구조상 감지 불가·기존 지침 충돌)으로 추가하지 않으며, 채택 가치가 인정된 이 한 줄만 반영한다. 근거 설명이 필요하면 'NLP 기반 심사에서 키워드 나열은 효과가 없다' 수준의 일반 원칙으로만 기술하고 특정 도입률 통계는 하드코딩하지 않는다.

**완료 판정:**
- Phase 3에 keyword stuffing 금지 확인 문구가 존재한다
- ATS 파싱·제출 포맷·분량 관련 신규 항목이 Phase 5 체크리스트에 추가되지 않았다
- 시장 통계 수치 하드코딩이 없다

### 제외·기구현 (5건)
- **프리앰블 bash 문법 오류 수정 (stale PID 정리 루프)**: main에서 기구현 — 커밋 055646a(PR#4 머지 2baa3dc)로 13개 스킬 일괄 수정 완료. 현재 review/SKILL.md 51행이 리다이렉션 없는 정상 루프이며 3변수 불변식(ACTIVE_SESSIONS/PROACTIVE/SKILL_NAME)도 emit 중, test/test-preambles.sh가 가드. 검증이 지적한 잔여분(templates/preamble.md에 trap EXIT+정리 루프 신 패턴 역반영)은 INFRA-4로 이관.
- **재리뷰 감지 + 변경분(delta) 요약 (Phase 7 제안의 재리뷰 대조 부분)**: main에서 기구현 — 커밋 참조(300a2aa/d6c7da4 품질 개선 계열, #117). Phase 1(81~89행)에 해결됨/미해결/신규 3구간 delta 요약이 반영됨. 잔여 갭(AskUserQuestion 분기, 수정 주체 명시, 완료 조건 재정의, recheck 텔레메트리)만 REV-2로 채택.
- **Phase 5 체크리스트에 제출 포맷·ATS 점검 3항목 추가**: 검증 기각 — (1) resume 스킬 Phase 4 'ATS 최적화'와 역할 중복 (2) review는 로컬 텍스트/마크다운 소스만 Read하므로 최종 제출 PDF의 표/그래픽 파싱 문제나 노션 직출력 여부를 감지할 수 없어 구조상 실현 곤란 (3) '2~3페이지 허용'은 resume의 '이력서 1~2페이지+경력기술서 분리' 지침과 정면 충돌. 채택 가치가 인정된 keyword stuffing 금지 한 줄만 REV-8로 축소 채택.
- **Phase 5 판정의 0~100 종합 점수 + '90점 이상 제출 권장' 기준선**: 검증 기각 — LLM이 매기는 점수는 실행마다 달라 재현성이 없고(main이 #122로 도입한 '관측 가능한 개수 기반 결정성 스코어' 원칙과도 충돌), Rezi는 영문 이력서 ATS 도구라 한국어 자소서·통합 서류 점검에 합격선을 이식할 타당성이 미검증. 기존 '통과 N/9' 체크리스트가 더 투명. 3계층 우선순위 정렬만 REV-7로 채택.
- **질문 세트를 mock-interview interview-history 보관으로 대체하는 핸드오프 (원안 #2의 대체 경로)**: 검증에서 사실관계 오류로 기각 — mock-interview는 자체 면접 리포트만 저장하며 review의 30~40개 질문 세트를 수신·저장하는 인터페이스가 없어 산출물 소실 리스크. main에 신설된 File output protocol([OUTPUT_FILE:]+render-docx.sh)이 정답 경로가 되어 REV-1(Bash 영속화)과 INFRA-9(defense-map 데이터 계약)로 대체.
