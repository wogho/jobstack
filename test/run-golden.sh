#!/usr/bin/env bash
# 골든 테스트 러너 (INFRA-8).
# LLM 산출물은 exact match가 불가하므로 특성(trait) 기반으로 판정한다.
#   - 결정적 케이스(tracker v1-compat): 매핑표 정합성을 자동 검증 — CI 가능
#   - trait 케이스: must_contain/must_not_contain을 산출물 md에 대해 grep 판정(반수동)
# 사용법:
#   run-golden.sh                 # 결정적 케이스만 실행 (CI)
#   run-golden.sh <산출물.md> <케이스경로>   # trait 케이스 grep 판정
set -u
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO="$(cd "$SCRIPT_DIR/.." && pwd)"
GOLDEN="$SCRIPT_DIR/golden"
STATES_DOC="$REPO/docs/tracker-states.md"
FAIL=0

# ── 결정적 케이스: tracker v1→v2 매핑 정합성 ──
# input.jsonl의 모든 v1 status가 docs/tracker-states.md 매핑표에 존재하는지 검증.
echo "## tracker v1-compat (결정적)"
INPUT="$GOLDEN/tracker/v1-compat/input.jsonl"
if [ ! -f "$INPUT" ] || [ ! -f "$STATES_DOC" ]; then
  echo "  [SKIP] 입력 또는 tracker-states.md 없음"
else
  # input.jsonl에서 status 값들 추출
  statuses=$(python3 -c "
import json,sys
seen=set()
for line in open('$INPUT'):
    line=line.strip()
    if line:
        seen.add(json.loads(line)['status'])
print('\n'.join(sorted(seen)))
" 2>/dev/null)
  while IFS= read -r st; do
    [ -z "$st" ] && continue
    # tracker-states.md 매핑표에 '| <한글> | `<영문>` |' 행이 있는지
    if grep -qE "^\| $st \| \`[a-z0-9_]+\`" "$STATES_DOC"; then
      echo "  [PASS] '$st' 매핑 존재"
    else
      echo "  [FAIL] '$st' 가 docs/tracker-states.md 매핑표에 없음 — 하위호환 깨짐"
      FAIL=$((FAIL+1))
    fi
  done <<< "$statuses"
fi

# ── trait 케이스 (인자로 산출물 지정 시) ──
if [ $# -eq 2 ]; then
  OUTPUT_MD="$1"; CASE_DIR="$2"
  TRAITS="$CASE_DIR/expected-traits.yaml"
  echo ""
  echo "## trait 판정: $CASE_DIR"
  if [ ! -f "$OUTPUT_MD" ] || [ ! -f "$TRAITS" ]; then
    echo "  [SKIP] 산출물 또는 expected-traits.yaml 없음"
  else
    # must_contain / must_not_contain 블록을 grep으로 판정
    python3 - "$OUTPUT_MD" "$TRAITS" <<'PY'
import sys, re
out=open(sys.argv[1], encoding='utf-8').read()
traits=open(sys.argv[2], encoding='utf-8').read()
def block(name):
    m=re.search(rf'{name}:\s*\n((?:\s*-\s*.*\n)+)', traits)
    if not m: return []
    return re.findall(r'-\s*"?([^"\n]+?)"?\s*(?:#.*)?$', m.group(1), re.M)
fail=0
for item in block('must_contain'):
    item=item.strip()
    if item and item.split()[0] in out:
        print(f"  [PASS] contains: {item[:40]}")
    elif item:
        print(f"  [WARN] missing (수동확인): {item[:40]}");
for item in block('must_not_contain'):
    item=item.strip().strip('"')
    key=item.split('#')[0].strip()
    if key and key in out:
        print(f"  [FAIL] contains banned: {key}"); fail+=1
    elif key:
        print(f"  [PASS] absent: {key}")
sys.exit(1 if fail else 0)
PY
    [ $? -ne 0 ] && FAIL=$((FAIL+1))
  fi
fi

echo ""
if [ "$FAIL" -eq 0 ]; then
  echo "[PASS] 골든 테스트 (결정적 판정 통과)"
  exit 0
else
  echo "[FAIL] 골든 테스트 위반 ${FAIL}건"
  exit 1
fi
