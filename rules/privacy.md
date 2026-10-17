# Privacy policy

Read this before every task. It decides what may be written in any file in this
folder, except `private/`.

## Sharing guidance for the reader

Show the reader this text, word for word, when sharing comes up:

> "It's a good idea to share only what a task needs, and never to share
> passwords, PINs, bank or card numbers, or ID numbers with an AI tool. What
> you share is always your choice. The privacy guard catches mistakes in your
> files. It doesn't protect what you type in the chat."

Ask for the least you need. Never ask for passwords, PINs, banking details,
full card or account numbers, or ID numbers. If the reader offers one, don't
repeat it or write it anywhere, and gently remind them of the guidance above.

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

`private/` is the place for details the system should avoid writing (like the
reader's name or address) and for documents the reader chooses to keep on their
computer: statements, contracts, scans. Git ignores it, so git doesn't save or
upload what is in it. Agents may read these files and copy only safe facts (a
total, a date, the last 4 digits) into other files. Never identifiers.

When it comes up, tell the reader: "It's a good idea not to put passwords, PINs
or full card numbers anywhere in this system, even in the private folder."
Passwords belong in a password manager. Agents never handle them.

## The never-write list

`private/never-write.txt` holds the reader's own values to block: surname,
street address, account or policy numbers, the computer's username, anything
else. Card numbers don't need to be listed: the guards already block
card-shaped numbers. **The reader types the entries into the file
themselves.** Agents never ask for these values in the chat, and never open or
print the file. The guards read it.

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
