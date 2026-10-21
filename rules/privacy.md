# Privacy policy

Read this at the start of a session, and again just before you write files. It
decides what may be written in any file in this folder, except `private/`.

## Sharing guidance for the reader

Show the reader this text, word for word, when sharing comes up:

> "It's a good idea to share only what a task needs, and never to share
> information like passwords, PINs, credit or debit card numbers, bank account
> numbers or ID numbers with an AI tool. What you share is always your choice.
> The privacy guard catches mistakes in your files. It doesn't protect what you
> type in the chat."

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
| An account or card number | A nickname only, like "main checking". Never any digits |
| The home address | "home", or the city |
| A document | Its filename in `private/`, plus only the figures and dates you need |
| An absolute path | `~/...` or a path inside this folder |

## The private folder

`private/` is the place for details the system should avoid writing (like the
reader's name or address) and for documents the reader chooses to keep on their
computer: statements, contracts, scans. Git ignores it, so git doesn't save or
upload what is in it. Agents may read these files and copy only safe facts (a
total, a date, an account nickname) into other files. Never identifiers, and
never any digits of an account or card number.

## What doesn't belong anywhere

When it comes up, show the reader this text, word for word:

> "**What doesn't belong anywhere.** Some information is too sensitive for any
> of this. It's a good idea never to share information like passwords, PINs,
> credit or debit card numbers, or bank account numbers with an AI tool, and
> never to put it anywhere in this system, not even in the never-write list or
> the private folder."

Passwords belong in a password manager. Agents never handle them.

## The never-write list

When the list comes up, show the reader this text, word for word:

> "**What the never-write list is for.** Some details aren't secret, but you'd
> still rather they never end up in your files, where they could be copied or
> shared by mistake. Your street address is a good example. The never-write list
> is a short list of words like that. Before any file is saved, the privacy
> guard is set up to check it for those words and stop if it finds one. The list
> itself is set up to stay on your computer. What you put in it is up to you."

- The street address is the only example. Don't give the reader a list of
  things to add, and never suggest account, card or policy numbers. Those
  don't belong anywhere (see above). Card-shaped numbers are already blocked
  by the guards.
- **The reader types the entries into the file themselves.** Agents never ask
  for these values in the chat, and never open or print the file. The guards
  read it.
- If a new detail of that kind comes up (not a secret, but something the
  reader may not want in the files), you may remind the reader that the list
  exists. What goes in it is their choice.
- To test the list, use only a made-up word, never a real entry (see
  `agents/guide.md`, step 4c).

A clean scan proves only that the **listed** values are absent. It doesn't
prove a file is clean.

## If a task seems to need a banned value

- Don't write it "just this once".
- Don't invent a placeholder that looks real.
- Point to the file in `private/`, or use a nickname, like "main checking", or
  "home".
- If neither works, stop and tell the reader why, marked `[PRIVACY-HOLD]`.
