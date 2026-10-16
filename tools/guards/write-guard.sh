#!/usr/bin/env bash
# Write guard: a Claude Code PreToolUse hook (wired in .claude/settings.json).
#
# Before any file is written, it checks the NEW content against the
# never-write list and the secret-shaped patterns in common.sh. A match blocks
# the write (exit code 2). It skips the private folder and machine-local
# *.local.* files, where sensitive values are allowed.
#
# It doesn't check the file's path, only the content: paths on this computer
# contain the username.

. "$(dirname "${BASH_SOURCE[0]}")/common.sh"

input="$(cat)"
file_path=""
content=""
parsed=0

# Read the hook input. Try jq, then python3. If neither works, fall back to
# scanning the raw input with the path fields removed.
if command -v jq >/dev/null 2>&1; then
  if file_path="$(jq -r '.tool_input.file_path // .tool_input.notebook_path // ""' <<<"$input" 2>/dev/null)" &&
     content="$(jq -r '[.tool_input.content, .tool_input.new_string, .tool_input.new_source, ((.tool_input.edits // [])[] | .new_string)] | map(select(. != null)) | join("\n")' <<<"$input" 2>/dev/null)"; then
    parsed=1
  fi
fi
if [ "$parsed" -eq 0 ] && python3 -c 'pass' >/dev/null 2>&1; then
  if out="$(python3 -c '
import sys, json
d = json.load(sys.stdin).get("tool_input", {})
print(d.get("file_path") or d.get("notebook_path") or "")
parts = [d.get(k) for k in ("content", "new_string", "new_source")]
parts += [e.get("new_string") for e in d.get("edits") or []]
print("\n".join(str(p) for p in parts if p))
' <<<"$input" 2>/dev/null)"; then
    file_path="$(head -n 1 <<<"$out")"
    content="$(tail -n +2 <<<"$out")"
    parsed=1
  fi
fi
if [ "$parsed" -eq 0 ]; then
  file_path="$(grep -oE '"(file_path|notebook_path)" *: *"[^"]*"' <<<"$input" | head -n 1 | sed -E 's/.*: *"([^"]*)"/\1/')"
  content="$(sed -E 's/"(file_path|notebook_path|transcript_path|cwd)" *: *"[^"]*"//g' <<<"$input")"
fi

[ -z "$content" ] && exit 0

# Sensitive values are allowed in the private folder and in machine-local files.
case "$file_path" in
  "$ROOT/private/"*|private/*) exit 0 ;;
  *.local.*) exit 0 ;;
esac

hits="$(scan_text "$content")"
if [ -n "$hits" ]; then
  name="${file_path#"$ROOT/"}"
  {
    echo "WRITE BLOCKED by the privacy guard."
    echo "The new content for $name contains:"
    sed 's/^/  - /' <<<"$hits"
    echo "$HELP_LINE"
  } >&2
  exit 2
fi
exit 0
