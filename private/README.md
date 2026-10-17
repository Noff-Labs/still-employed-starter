# Private folder

This is the place for details the system should avoid writing (like your name
or address) and for documents you choose to keep on your computer.

Git ignores everything in this folder except this file and
`never-write.example.txt`, so git doesn't save or upload the rest.

**What goes here:**
- Documents you choose to keep on your computer: statements, contracts, scans.
- `never-write.txt`: your list of values the guards should block. Copy it from
  `never-write.example.txt`, then type your entries yourself in a text editor.

It's a good idea not to put passwords, PINs or full card numbers anywhere in
this system, even in the private folder. A password manager is a better place
for passwords.

**Rules for agents:**
- Agents may read documents here and copy only safe facts (a total, a date,
  the last 4 digits) into other files. Never identifiers.
- Agents never open or print `never-write.txt`. The guard scripts read it.

**Backups:** because git ignores this folder, a git backup doesn't include it.
Back it up some other way if you need to.
