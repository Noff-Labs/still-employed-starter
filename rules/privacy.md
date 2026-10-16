# Privacy policy

Read this before every task. It decides what may be written in any file in this
folder, except `private/`.

## Never write these in any tracked file

"Tracked" means any file git keeps, which is every file outside `private/`.

- Full account, card or ID numbers (bank, credit card, loan, insurance policy,
  passport, driver's license, tax or social security number).
- Passwords, PINs, API keys, tokens, recovery codes, answers to security
  questions.
- The reader's surname, or anyone else's.
- The full home address (street and number).
- Employer details the reader hasn't been cleared to share.
- Absolute home-folder paths such as `/Users/<name>/` or `C:\Users\<name>\`.
  They contain the computer's username, which often contains the surname.

## Write this instead

| Instead of | Write |
|---|---|
| A full name | The first name only |
| An account or card number | Bank, nickname, last 4 digits (for example "Main bank, checking, ...1234") |
| The home address | "home", or the city |
| A document | Its filename in `private/`, plus only the figures and dates you need |
| An absolute path | `~/...` or a path inside this folder |

## The private folder

`private/` is ignored by git, so it never leaves this computer through git. Raw
documents live here and only here: statements, contracts, scans, anything with
names, addresses or account numbers. Agents may read these files and copy only
safe facts (a total, a date, the last 4 digits) into other files. Never
identifiers.

Passwords don't belong even in `private/`. They belong in a password manager.
Agents never handle them.

## The never-write list

`private/never-write.txt` holds the reader's own values to block: surname,
street address, account numbers, the computer's username, anything else. **The
reader types the entries into the file themselves.** Agents never ask for these
values in the chat, and never open or print the file. The guards read it.

When a new kind of identifier enters the reader's life (a policy number, a
membership number, a license plate), ask the reader to add it to the list the
same day.

A clean scan proves only that the **listed** values are absent. It doesn't
prove a file is clean.

## If a task seems to need a banned value

- Don't write it "just this once".
- Don't invent a placeholder that looks real.
- Point to the file in `private/`, or use the last 4 digits.
- If neither works, stop and tell the reader why, marked `[PRIVACY-HOLD]`.
