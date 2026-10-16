#!/usr/bin/env bash
# Shared parts of the privacy guards. The other guard scripts load this file.
#
# Two rules for every guard:
#   1. Never print a matched value. Name the file and the kind of match only.
#   2. A check that can't run says so. It doesn't pretend to pass or fail.
#
# Works with the bash that ships with macOS (version 3.2), Linux and Git Bash.

GUARD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$GUARD_DIR/../.." && pwd)"
NEVER_WRITE="$ROOT/private/never-write.txt"
HOME_USER="$(basename "${HOME:-unknown}")"

# Secret-shaped patterns (extended regular expressions). Kept tight, so
# ordinary text and phone numbers pass. Each has a plain name in the same
# position in PATTERN_NAMES.
SECRET_PATTERNS=(
  '-----BEGIN [A-Z ]*PRIVATE KEY-----'
  'AKIA[0-9A-Z]{16}'
  'gh[pousr]_[A-Za-z0-9]{30,}'
  'github_pat_[A-Za-z0-9_]{30,}'
  'xox[abprs]-[A-Za-z0-9-]{10,}'
  'sk-[A-Za-z0-9_-]{20,}'
  '(sk|rk)_live_[A-Za-z0-9]{20,}'
  'AIza[0-9A-Za-z_-]{35}'
  '(^|[^0-9])([0-9]{4}[- ]){3}[0-9]{4}([^0-9]|$)'
  '(^|[^0-9])[0-9]{15,16}([^0-9]|$)'
  '(^|[^0-9])[0-9]{3}-[0-9]{2}-[0-9]{4}([^0-9]|$)'
  '(^|[^0-9])[0-9]{3}[- ][0-9]{3}[- ][0-9]{3}([^0-9]|$)'
)
PATTERN_NAMES=(
  'a private key'
  'an AWS access key'
  'a GitHub token'
  'a GitHub token'
  'a Slack token'
  'an API key'
  'a payment API key'
  'a Google API key'
  'a card number (four groups of four digits)'
  'a card number (15 or 16 digits)'
  'an SSN-shaped number'
  'a SIN-shaped number'
)

# Absolute home-folder paths contain the computer's username, which often
# contains the surname. Fixed strings, not patterns.
HOME_PATHS=(
  "/Users/$HOME_USER/"
  "/home/$HOME_USER/"
  "\\Users\\$HOME_USER\\"
)

# Load the never-write list: one entry per line, # starts a comment.
NEVER_WRITE_ENTRIES=()
NEVER_WRITE_FOUND=0
if [ -f "$NEVER_WRITE" ]; then
  NEVER_WRITE_FOUND=1
  while IFS= read -r line || [ -n "$line" ]; do
    line="${line%$'\r'}"
    line="$(printf '%s' "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    case "$line" in ''|\#*) continue ;; esac
    NEVER_WRITE_ENTRIES+=("$line")
  done < "$NEVER_WRITE"
fi

# scan_text TEXT
# Prints one line for each kind of match. Prints nothing if the text is clean.
# Uses here-strings, not pipes, so a large text can't cause a false pass.
scan_text() {
  local text="$1" i term
  i=0
  for term in "${NEVER_WRITE_ENTRIES[@]+"${NEVER_WRITE_ENTRIES[@]}"}"; do
    i=$((i + 1))
    if grep -iqF -- "$term" <<<"$text"; then
      echo "entry #$i on your never-write list"
    fi
  done
  i=0
  while [ "$i" -lt "${#SECRET_PATTERNS[@]}" ]; do
    if grep -Eq -- "${SECRET_PATTERNS[$i]}" <<<"$text"; then
      echo "${PATTERN_NAMES[$i]}"
    fi
    i=$((i + 1))
  done
  for term in "${HOME_PATHS[@]}"; do
    if grep -qF -- "$term" <<<"$text"; then
      echo "an absolute home-folder path (write ~/ instead)"
      break
    fi
  done
}

# is_never_tracked PATH (relative to the repository root)
# True for files that must never be committed.
is_never_tracked() {
  case "$1" in
    private/README.md|private/never-write.example.txt) return 1 ;;
    private/*) return 0 ;;
    *.local.*) return 0 ;;
    .env|.env.*|*/.env|*/.env.*) return 0 ;;
  esac
  return 1
}

# Where the protected files are explained, for messages.
HELP_LINE="See rules/privacy.md: use a first name, the last 4 digits, or \"home\", or keep the value in private/. The matched value is not shown on purpose."
