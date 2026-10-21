# Still Employed starter

A starter AI agent team for your job, your home or a small business. It is a
small set of plain text files. Your AI tool reads them and plays the roles: a
Guide that sets the system up with you, and one contact you talk to whenever
you want something done.

This is the system used by David Noff, author of *Still Employed*. He built it
up over months of running it at work, at home and in a small publishing company.

> **AI tools:** read [`AGENTS.md`](AGENTS.md) first and follow it.

## The book and the tool

This repository is the tool. The book is the way of thinking behind it.
*Still Employed* explains how to think about this system, how to use it well,
and what you can use it for. The files make much more sense after you read it.

## A word about safety

This system can be powerful, because it lets AI agents do real work for you. That also means you do less of it yourself, so what you let them do really matters. Setting clear limits (your walls) is one of the most important parts of the system. It comes with some safety features built in, like the privacy guard. They're set up to help, but no one can promise they'll always work: AI tools differ from one another, and they change over time. So it's a good idea to ask your AI to explain how the safety features work, to check that they work on your computer, and to add your own limits where you need them. Be careful what you share, and what you ask the AI to do.

## Quick start

**What you need.** You need an AI tool that can read and write files on your computer, such as Claude Code, Cursor or Codex. A chat window in a web browser can't do this.

**Paste this one sentence into your AI tool:**

```
Download the starter system from github.com/Noff-Labs/still-employed-starter into a new folder on my computer, then open it and start its Guide.
```

**If you'd rather do it yourself:** click the green **Code** button on GitHub, then **Download ZIP**; unzip it; open the folder in your AI tool; type **start**.

## What happens next

1. If your AI downloaded the files for you, it will ask you to open a new
   session inside the new folder. Do that, then type **start**. This turns on
   the privacy guard.
2. The Guide asks you what this is for, then asks a few questions, one at a
   time. It asks **what** you want done, not **how** to do it.
3. It builds the system with you: you choose a name for your one contact, and
   the Guide writes your rules, fills in memory, and turns on the privacy
   guard.
4. You start with **one** first workflow. You add more roles later, when real
   work shows that one is missing.
5. After that, open the folder and type **start**. Your contact tells you
   where things stand and the one next step. Then tell it what you want, in
   your own words.
6. When you're finished, say **done for today**. Your contact saves what you did and tells you the next step.

If anything is unclear, now or later, just ask. Your AI can explain any step, including how the safety features work.

Tip for Claude Code users: you can also type **/** and your contact's name, for example **/assistant**.

## Before you start

- **It is not a magic prompt.** It is a set of files. It becomes useful as its
  memory and lessons fill up with your real work.
- **Start small.** One conversation, one workflow. Add the next one when you
  need it.
- **Start on the cheapest paid plan** of your AI tool. Upgrade only if you keep
  hitting its limits.
- **What you share.** It's a good idea to share only what a task needs, and
  never to share information like passwords, PINs, credit or debit card
  numbers, bank account numbers or ID numbers with an AI tool. What you share
  is always your choice. The privacy guard catches mistakes in your files. It
  doesn't protect what you type in the chat.
- **At work.** At work, it's a good idea to use only AI tools your employer
  allows, and to keep confidential information out unless your employer allows
  it.
- **Which AI tool?** David uses it mainly in Claude Code, in the Claude
  desktop app. In October 2026, the setup was tested there and in Codex. It
  may work in other AI tools that can read and write files, but it hasn't been
  tested there. AI tools change often, so if something doesn't work as
  described, ask your AI to check. One privacy layer (the write guard) works in
  Claude Code and Codex. The other layers work with any tool. In Codex, you
  approve the guard once by typing **/hooks**. The Guide shows you how.

## Two rules the system is set up to follow

1. **The human gate.** The system is set up to draft, stage and recommend. You
   publish, send, sign, pay and buy. Drafts wait in `output/` for you.
2. **The privacy guard is on from day one.** It is set up to stop your private
   details from ending up anywhere they could be shared.

AI can make mistakes, so it's a good idea to check important work.

## What's inside

| Path | What it is |
|---|---|
| `AGENTS.md` | Instructions every AI tool reads first |
| `CLAUDE.md` | Points Claude Code to `AGENTS.md` |
| `agents/guide.md` | The setup Guide |
| `agents/chief-of-staff.md` | Your one contact, whenever you want something done (a template the Guide fills in with you) |
| `rules/rules.md` | House rules every agent follows |
| `rules/privacy.md` | What must never be written, and what to write instead |
| `memory/state.md` | Where things stand right now, including reminders |
| `memory/decisions.md` | Dated decisions, newest first |
| `memory/lessons.md` | Dated lessons, so a mistake happens only once |
| `knowledge/` | What the team should know about your work or life |
| `output/` | Drafts waiting for you |
| `tools/new-agent.md` | Checklist for adding a new role |
| `tools/guards/` | The privacy guard scripts |
| `.claude/settings.json`, `.codex/hooks.json` | Turn on the write guard (and the never-write list's read guard) in Claude Code and Codex |
| `private/` | Details the system should avoid writing (like your name or address), and documents you choose to keep on your computer. Git ignores it |

## The privacy guard, layer by layer

| Layer | What it does | Works with |
|---|---|---|
| 1. Policy (`rules/privacy.md`) | Tells every agent what never to write, and what to write instead | Any AI tool |
| 2. Private folder (`private/`) | For details the system should avoid writing, and documents you keep on your computer. Git ignores it | Any AI tool |
| 3. Never-write list (`private/never-write.txt`) | Words you'd rather never see in your files, like your street address. You type it yourself; agents are set up never to open it | Any AI tool |
| 4. Write guard | Blocks a file write that contains a listed value or a secret-shaped number. A second hook blocks commands that would show the never-write list | Claude Code and Codex |
| 5. Commit guard | Blocks a git commit that adds a listed value | Git |
| 6. Pre-push check | Scans every commit before upload, and refuses to upload to this starter repository. Before an upload to a public repository, it warns you and shows the name and email on your commits | Git |

If you downloaded the ZIP and don't use git, layers 1 to 4 still help protect
you.

**What the never-write list is for.** Some details aren't secret, but you'd still rather they never end up in your files, where they could be copied or shared by mistake. Your street address is a good example. The never-write list is a short list of words like that. Before any file is saved, the privacy guard is set up to check it for those words and stop if it finds one. The list itself is set up to stay on your computer. What you put in it is up to you.

**What doesn't belong anywhere.** Some information is too sensitive for any of this. It's a good idea never to share information like passwords, PINs, credit or debit card numbers, or bank account numbers with an AI tool, and never to put it anywhere in this system, not even in the never-write list or the private folder.

## Use at your own risk

This is free software, shared as is under the MIT License (see LICENSE), with no warranty. You decide what you share with your AI tool and what you ask it to do, and you're responsible for the results. Nothing here is legal, financial, tax or other professional advice. It's a good idea to check important work yourself before you act on it.

## License

MIT. See [LICENSE](LICENSE).
