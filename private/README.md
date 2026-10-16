# Private folder

Git ignores everything in this folder except this file and
`never-write.example.txt`. Nothing else here is ever committed or uploaded
through git.

**What goes here:**
- Raw documents: statements, contracts, scans, anything with names, addresses
  or account numbers.
- `never-write.txt`: your list of values the guards must block. Copy it from
  `never-write.example.txt`, then type your entries yourself in a text editor.

**Rules:**
- Agents may read raw documents here and copy only safe facts (a total, a
  date, the last 4 digits) into other files. Never identifiers.
- Agents never open or print `never-write.txt`. The guard scripts read it.
- Passwords don't belong here either. Use a password manager.

**Backups:** because git ignores this folder, a git backup doesn't include it.
Back it up some other way if you need to.
