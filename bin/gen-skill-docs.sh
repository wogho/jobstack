#!/usr/bin/env bash
# gen-skill-docs.sh -- expand SKILL.md.tmpl → SKILL.md
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$ROOT_DIR/templates"

# Read shared templates
PREAMBLE=$(cat "$TEMPLATE_DIR/preamble.md")
VOICE=$(cat "$TEMPLATE_DIR/voice.md")
ASK_USER=$(cat "$TEMPLATE_DIR/ask-user-question.md")
COMPLETION=$(cat "$TEMPLATE_DIR/completion-status.md")
GUARDRAILS=$(cat "$TEMPLATE_DIR/guardrails.md")

count=0
for tmpl in "$ROOT_DIR"/*/SKILL.md.tmpl; do
  [ -f "$tmpl" ] || continue
  skill_dir=$(dirname "$tmpl")
  output="$skill_dir/SKILL.md"

  # Read template
  content=$(cat "$tmpl")

  # Replace placeholders
  content="${content//\{\{PREAMBLE\}\}/$PREAMBLE}"
  content="${content//\{\{VOICE\}\}/$VOICE}"
  content="${content//\{\{ASK_USER_QUESTION\}\}/$ASK_USER}"
  content="${content//\{\{COMPLETION_STATUS\}\}/$COMPLETION}"
  content="${content//\{\{GUARDRAILS\}\}/$GUARDRAILS}"
  # 프리앰블의 __SKILL_NAME__ 플레이스홀더를 스킬 디렉토리명 리터럴로 치환
  content="${content//__SKILL_NAME__/$(basename "$skill_dir")}"

  echo "$content" > "$output"
  count=$((count + 1))
  echo "  Generated: $(basename "$skill_dir")/SKILL.md"
done

echo "Done. $count skill(s) generated."
