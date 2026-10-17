#!/usr/bin/env bash
# Write guard: a PreToolUse hook for Claude Code (wired in .claude/settings.json)
# and Codex (wired in .codex/hooks.json).
#
# Before any file is written, it checks the NEW content against the
# never-write list and the secret-shaped patterns in common.sh. A match blocks
# the write (exit code 2). It skips the private folder and machine-local
# *.local.* files, where sensitive values are allowed.
#
# Claude Code sends the new content in tool_input (content, new_string,
# new_source, or edits[].new_string). Codex sends file edits as an apply_patch
# call, with the patch text in tool_input.command. For a patch, only the ADDED
# lines are checked, so a patch that removes a value still goes through.
#
# It doesn't check file paths, only the content: paths on this computer
# contain the username.

. "$(dirname "${BASH_SOURCE[0]}")/common.sh"

input="$(cat)"
tool_name=""
file_path=""
content=""
patch=""
parsed=0

# Read the hook input. Try jq, then python3. If neither works, fall back to
# scanning the raw input with the path fields removed.
if command -v jq >/dev/null 2>&1; then
  if tool_name="$(jq -r '.tool_name // ""' <<<"$input" 2>/dev/null)" &&
     file_path="$(jq -r '.tool_input.file_path // .tool_input.notebook_path // ""' <<<"$input" 2>/dev/null)" &&
     content="$(jq -r '[.tool_input.content, .tool_input.new_string, .tool_input.new_source, ((.tool_input.edits // [])[] | .new_string)] | map(select(. != null)) | join("\n")' <<<"$input" 2>/dev/null)" &&
     patch="$(jq -r '.tool_input.command // "" | if type == "array" then join("\n") else tostring end' <<<"$input" 2>/dev/null)"; then
    parsed=1
  fi
fi
if [ "$parsed" -eq 0 ] && python3 -c 'pass' >/dev/null 2>&1; then
  if out="$(python3 -c '
import sys, json
data = json.load(sys.stdin)
d = data.get("tool_input") or {}
body = [d.get(k) for k in ("content", "new_string", "new_source")]
body += [e.get("new_string") for e in d.get("edits") or []]
cmd = d.get("command") or ""
if isinstance(cmd, list):
    cmd = "\n".join(str(c) for c in cmd)
print(json.dumps([data.get("tool_name") or "",
                  d.get("file_path") or d.get("notebook_path") or "",
                  "\n".join(str(p) for p in body if p),
                  str(cmd)]))
' <<<"$input" 2>/dev/null)"; then
    tool_name="$(python3 -c 'import sys, json; print(json.load(sys.stdin)[0])' <<<"$out")"
    file_path="$(python3 -c 'import sys, json; print(json.load(sys.stdin)[1])' <<<"$out")"
    content="$(python3 -c 'import sys, json; print(json.load(sys.stdin)[2])' <<<"$out")"
    patch="$(python3 -c 'import sys, json; print(json.load(sys.stdin)[3])' <<<"$out")"
    parsed=1
  fi
fi
if [ "$parsed" -eq 0 ]; then
  # Rough fallback. For a Codex patch it also scans removed lines, and it
  # can't skip the private folder. That errs on the side of blocking.
  file_path="$(grep -oE '"(file_path|notebook_path)" *: *"[^"]*"' <<<"$input" | head -n 1 | sed -E 's/.*: *"([^"]*)"/\1/')"
  content="$(sed -E 's/"(file_path|notebook_path|transcript_path|cwd)" *: *"[^"]*"//g' <<<"$input")"
fi

# A Codex patch: keep only the lines it adds, and skip files in the private
# folder or machine-local files.
if [ "$tool_name" = "apply_patch" ] || grep -q '^\*\*\* Begin Patch' <<<"$patch"; then
  file_path="the files in this patch"
  content="$(awk -v root="$ROOT" '
    function exempt(p) {
      if (index(p, root "/private/") == 1 || index(p, "private/") == 1 || index(p, "./private/") == 1) return 1
      if (p ~ /\.local\./) return 1
      return 0
    }
    /^\*\*\* (Add|Update) File: / { f = $0; sub(/^\*\*\* (Add|Update) File: /, "", f); skip = exempt(f); next }
    /^\*\*\* Move to: / { f = $0; sub(/^\*\*\* Move to: /, "", f); skip = exempt(f); next }
    /^\*\*\* / { next }
    /^\+/ { if (!skip) print substr($0, 2) }
  ' <<<"$patch")"
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
