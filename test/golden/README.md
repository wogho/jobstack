# 골든 테스트 (INFRA-8)

스킬 업그레이드 전/후 산출물의 회귀를 잡기 위한 특성(trait) 기반 기준선.
LLM 산출물은 exact match가 불가능하므로 "무엇을 포함/불포함해야 하는가"로 판정한다.

## 구조

```
test/golden/<skill>/<case>/
  input.jsonl 또는 input/     # 입력 픽스처
  expected-traits.yaml         # must_contain / must_not_contain / structure
```

## 판정 (test/run-golden.sh)

- **결정적 케이스**: `tracker/v1-compat` — 입력의 v1 한글 status가 전부
  `docs/tracker-states.md` 매핑표에 존재하는지 자동 검증. 상태를 추가/개명할 때
  하위호환이 깨지면 CI에서 실패한다. `run-golden.sh` 인자 없이 실행.
- **trait 케이스**: 스킬을 실제로 실행해 산출한 md를 `run-golden.sh <산출물.md> <케이스경로>`로
  넘기면 must_contain/must_not_contain을 grep으로 판정한다(구조 항목은 사람이 확인).

## 케이스 추가 우선순위

resume / cover-letter / review / tracker / job-search 5종을 우선한다.
현재는 tracker 결정적 케이스가 대표로 구현돼 있고, 나머지는 `expected-traits.yaml`의
공통 금지 항목(AI 만능 표현, 금지 표현, 입력에 없는 자격/수치 날조)을 최소 기준으로 삼는다.
