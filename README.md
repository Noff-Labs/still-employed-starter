# Still Employed starter

A starter AI agent team for your job, your home or a small business. It is a
small set of plain text files. Your AI tool reads them and plays the roles: a
Guide that sets the system up with you, and a chief of staff you talk to every
day after that.

This is the system used by David Noff, author of *Still Employed*. He built it
up over months of running it at work, at home and in a small publishing company.

> **AI tools:** read [`AGENTS.md`](AGENTS.md) first and follow it.

## The book and the tool

This repository is the tool. The book is the way of thinking behind it.
*Still Employed* explains how to think about this system, how to use it well,
and what you can use it for. The files make much more sense after you read it.

## Quick start

**What you need.** You need an AI tool that can read and write files on your computer, such as Claude Code, Cursor or Codex. A chat window in a web browser can't do this.

**Paste this one sentence into your AI tool:**

```
Download the starter system from github.com/Noff-Labs/still-employed-starter into a new folder on my computer, then open it and start its Guide.
```

**If you'd rather do it yourself:** click the green **Code** button on GitHub, then **Download ZIP**; unzip it; open the folder in your AI tool; type **start**.

## What happens next

1. The Guide asks you what this is for, then asks a few questions, one at a time.
   It asks **what** you want done, not **how** to do it.
2. It builds the system with you: it names your chief of staff, writes your
   rules, fills in memory, and turns on the privacy guard.
3. You start with **one** first workflow. You add more roles later, when real
   work shows that one is missing.
4. After that, open the folder and type **start**. Your chief of staff tells you
   where things stand and the one next step.

## Before you start

- **It is not a magic prompt.** It is a set of files. It becomes useful as its
  memory and lessons fill up with your real work.
- **Start small.** One conversation, one workflow. Add the next one when you
  need it.
- **Start on the cheapest paid plan** of your AI tool. Upgrade only if you keep
  hitting its limits.
- **At work, use only AI tools your employer allows.** Keep confidential
  information out unless your employer allows it.
- **Which AI tool?** David uses Claude Code. Every file is plain markdown, so
  other AI tools can use it too. One privacy layer (the write guard) works only
  in Claude Code. The other layers work with any tool.

## Two rules that never change

1. **The human gate.** Agents draft, stage and recommend. A human publishes,
   sends, signs, pays and buys. Drafts wait in `output/` for you.
2. **The privacy guard is on from day one.** It stops your private details from
   ending up anywhere they could be shared.

## What's inside

| Path | What it is |
|---|---|
| `AGENTS.md` | Instructions every AI tool reads first |
| `CLAUDE.md` | Points Claude Code to `AGENTS.md` |
| `agents/guide.md` | The setup Guide |
| `agents/chief-of-staff.md` | The one agent you talk to every day (a template the Guide fills in) |
| `rules/rules.md` | House rules every agent follows |
| `rules/privacy.md` | What must never be written, and what to write instead |
| `memory/state.md` | Where things stand right now, including reminders |
| `memory/decisions.md` | Dated decisions, newest first |
| `memory/lessons.md` | Dated lessons, so a mistake happens only once |
| `knowledge/` | What the team should know about your work or life |
| `output/` | Drafts waiting for you |
| `tools/new-agent.md` | Checklist for adding a new role |
| `tools/guards/` | The privacy guard scripts |
| `private/` | Your raw documents and your never-write list. Never tracked by git |

## The privacy guard, layer by layer

| Layer | What it does | Works with |
|---|---|---|
| 1. Policy (`rules/privacy.md`) | Tells every agent what never to write, and what to write instead | Any AI tool |
| 2. Private folder (`private/`) | Raw documents live here only. Git ignores it | Any AI tool |
| 3. Never-write list (`private/never-write.txt`) | Your surname, address, account numbers and similar. You type it yourself; agents never open it | Any AI tool |
| 4. Write guard | Blocks a file write that contains a listed value or a secret-shaped number | Claude Code |
| 5. Commit guard | Blocks a git commit that adds a listed value | Git |
| 6. Pre-push check | Scans every commit before upload, and warns if the GitHub repository is public | Git |

If you downloaded the ZIP and don't use git, layers 1 to 4 still protect you.

## License

MIT. See [LICENSE](LICENSE).
