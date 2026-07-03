#!/usr/bin/env bash
# 사용자 노출 명령 표기 드리프트 재발 방지 린트 (templates/BOT-COMMAND-STYLE.md 규칙).
# 검사 대상: */SKILL.md, templates/*.md, README.md
#   - docs/ 는 과거 산출물(E2E 리포트 등) 보존용이므로 검사하지 않는다.
#   - templates/BOT-COMMAND-STYLE.md 는 표기 규칙 문서 자체라 금지 표기를 인용하므로 제외.
# 검출:
#   1) 하이픈 스킬 명령 멘션 — /cover-letter, /mock-interview, /company-research, /job-search
#      (Telegram 봇은 하이픈 명령을 지원하지 않아 탭 불가 → 언더스코어 표기 필수)
#   2) 봇 미노출 스킬 추천 — /tracker, /ncs (단어 경계)
#      (지원 현황은 봇 네이티브 /track·/myapps, NCS는 /cover_letter 공기업 보강으로 안내)
# 예외 (명령 추천이 아닌 표기):
#   ① 리포트 버전 스탬프 — `jobstack /<skill> v<N>` 풋터 (예: jobstack /mock-interview v0.1.0)
#   ② 디렉토리/경로 문맥 — 토큰이 슬래시로 이어지는 경로 표기 (예: /tracker/applications.jsonl)
#      또한 검출 자체를 토큰 시작 위치(행 시작·공백·백틱·따옴표·괄호·표 구분자 뒤)의
#      `/명령` 으로 한정하므로, `$_JS_STATE/tracker` 같은 변수 경로는 애초에 걸리지 않는다.

set -u
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO="$(cd "$SCRIPT_DIR/.." && pwd)"

CMDS='cover-letter|mock-interview|company-research|job-search|tracker|ncs'

HITS=$(grep -rnE "(^|[[:space:]\`\"(>|[])/(${CMDS})\\b" \
    "$REPO"/*/SKILL.md "$REPO"/templates/*.md "$REPO"/README.md 2>/dev/null \
  | grep -v '/templates/BOT-COMMAND-STYLE.md:' \
  | grep -vE 'jobstack /[a-z-]+ v[0-9]' \
  | grep -vE "/(${CMDS})/" || true)

if [ -n "$HITS" ]; then
  COUNT=$(echo "$HITS" | wc -l | tr -d ' ')
  echo "[FAIL] 명령 표기 위반 ${COUNT}건 발견 — templates/BOT-COMMAND-STYLE.md 규칙을 따르세요:"
  echo "  (하이픈 명령 → 언더스코어 / tracker → /track·/myapps / ncs → /cover_letter 보강 안내)"
  echo "$HITS" | sed "s|^$REPO/||; s/^/  /"
  exit 1
fi

echo "[PASS] */SKILL.md · templates/*.md · README.md 에 하이픈 명령·봇 미노출 스킬 추천 표기 없음"
exit 0
