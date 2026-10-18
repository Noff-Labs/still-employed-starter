#!/usr/bin/env bash
# Read guard: a PreToolUse hook on shell commands, for Codex (wired in
# .codex/hooks.json) and Claude Code (wired in .claude/settings.json).
#
# Agents are set up never to open or print private/never-write.txt. Claude Code
# also has a permission rule that blocks its Read tool on that file, but a shell
# command (cat, head, grep, copy) can still read it, and Codex has no such rule.
# So this hook refuses any shell command that names the never-write list, or
# that uses a wildcard inside private/ (which could include the list).
#
# Two commands are allowed, because they don't show the file's contents:
#   cp -n private/never-write.example.txt private/never-write.txt
#   test -f private/never-write.txt
#
# The guard scripts read the list themselves, outside any tool call, so this
# hook doesn't affect them. It is a seatbelt for mistakes, not a lock: it only
# sees the command text.

input="$(cat)"
command_text=""
parsed=0

# Read the command. Try jq, then python3. If neither works, check the raw input.
if command -v jq >/dev/null 2>&1; then
  if command_text="$(jq -r '.tool_input.command // "" | if type == "array" then join(" ") else tostring end' <<<"$input" 2>/dev/null)"; then
    parsed=1
  fi
fi
if [ "$parsed" -eq 0 ] && python3 -c 'pass' >/dev/null 2>&1; then
  if command_text="$(python3 -c '
import sys, json
d = (json.load(sys.stdin).get("tool_input") or {})
cmd = d.get("command") or ""
if isinstance(cmd, list):
    cmd = " ".join(str(c) for c in cmd)
print(cmd)
' <<<"$input" 2>/dev/null)"; then
    parsed=1
  fi
fi
[ "$parsed" -eq 0 ] && command_text="$input"

[ -z "$command_text" ] && exit 0

# The two allowed commands, exactly as written above (an optional ./ is fine).
trimmed="$(printf '%s' "$command_text" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
p='(\./)?private/'
if grep -Eqx "cp -n ${p}never-write\.example\.txt ${p}never-write\.txt" <<<"$trimmed" ||
   grep -Eqx "test -f ${p}never-write\.txt" <<<"$trimmed"; then
  exit 0
fi

# The example file is fine to read. Remove its name, then look for the list.
rest="$(sed 's/never-write\.example\.txt//g' <<<"$command_text")"
reason=""
if grep -qi 'never-write' <<<"$rest"; then
  reason="it names the never-write list"
elif grep -Eq 'private/[^[:space:]"'\'']*[*?[]' <<<"$rest"; then
  reason="it uses a wildcard inside private/, which could include the never-write list"
fi

if [ -n "$reason" ]; then
  {
    echo "COMMAND BLOCKED by the privacy guard: $reason."
    echo "Agents are set up never to open or print private/never-write.txt. The guard scripts read it; nobody else needs to."
    echo "To check that the guard works, write a test file with a made-up value instead (see agents/guide.md, step 4c)."
  } >&2
  exit 2
fi
exit 0
