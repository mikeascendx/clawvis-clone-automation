# Clawvis — Generic Cloning Workflow

How to go from a task from Kenji to a delivered clone via Clawvis.

**Last Updated:** 2026-04-02

---

## What Changed (2026-04-02)

Clawvis doing everything on its own produced low-quality output (pale, simple, unmatched designs). Clawvis now uses the **Codex webapp** (`chatgpt.com/codex`) with the **ai-website-cloner-template** skill for the actual website cloning step. You still talk to Clawvis on Telegram — the interface hasn't changed. What changed is how Clawvis builds the clone internally.

See `CODEX-INTEGRATION.md` for full technical details.

---

## Step 1 — Receive task from Kenji

Kenji sends you a URL and any notes (e.g. "skip placeholder sections", "only real content").

---

## Step 2 — Send to Clawvis on Telegram

Open the Clawvis Assistant chat and send:

```
Follow instructions: https://raw.githubusercontent.com/mikeascendx/clawvis-clone-automation/main/cloning-loop-plan.md

Target: [URL]
```

Clawvis derives the repo name from the domain automatically. GitHub token is set globally in `~/.bashrc`.

---

## Step 3 — Clawvis runs the loop (now using Codex)

Clawvis will automatically:
- Trigger the `$clone-website` skill via the Codex webapp/CLI
- Codex handles the heavy lifting:
  - Opens the target site in a browser (via Browser MCP)
  - Screenshots at desktop + mobile breakpoints
  - Extracts real CSS values (fonts, colors, spacing) via `getComputedStyle()`
  - Downloads all assets (images, icons, favicons)
  - Writes spec files for each section
  - Dispatches parallel builder agents (one per section, each in its own git worktree)
  - Assembles all sections into a Next.js + React + Tailwind project
  - Runs visual QA diff against the original and fixes discrepancies
  - Verifies `npm run build` passes
- Clawvis handles orchestration, auth, delivery, and collaborator management

---

## Step 4 — Clawvis delivers to GitHub

When done, Clawvis will automatically:
- Create a private GitHub repo under `clawvisx` org
- Push all output files
- Add `mikeascendx` and `KIshiharaHCI` as collaborators
- Reply to you with the repo URL

---

## Step 5 — Review

Open the repo link Clawvis sends. You and Kenji can review the clone and leave feedback.

---

## Example — Pala Consulting

**Kenji's task:**
> Clone https://pala-consulting.de/ — skip placeholder/template sections, only real content.

**Message sent to Clawvis:**
```
Follow instructions: https://raw.githubusercontent.com/mikeascendx/clawvis-clone-automation/main/cloning-loop-plan.md

Target: https://pala-consulting.de/
```

Clawvis triggers Codex `$clone-website https://pala-consulting.de`, handles delivery to GitHub, replies with the repo URL.

---

## Notes

- Clawvis is an **OpenClaw agent** accessible via Telegram — that part hasn't changed
- The Codex `$clone-website` skill is what actually builds the website clone now (instead of Clawvis generating HTML/CSS on its own)
- `CODEX-INTEGRATION.md` has full setup instructions, cost info, and technical details
- The clone skill uses Browser MCP (Playwright/Browserbase) — this is mandatory
- Output is Next.js + React + Tailwind (not plain HTML like the old Clawvis-only flow)
- Requires ChatGPT Plus ($20/mo) or Pro ($200/mo) for Codex access
- The `ai-website-cloner-template` repo must be forked to `clawvisx` org and connected in Codex settings
