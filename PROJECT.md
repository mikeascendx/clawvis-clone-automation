# Website Cloning Automation — Project Doc

**Status:** Testing Codex Integration
**Last Updated:** 2026-04-02
**Owner:** Mike

---

## Background

A significant chunk of our current workflow is cloning existing websites, then redesigning them. The cloning step is highly automatable — this project is about making that happen.

Previously explored a similar direction with **Antigravity**: you screenshot a section, give it to the model, it clones it, you check the output, fix issues, move to the next section. That manual process is exactly what we're automating.

---

## Approach

**Clawvis** is an OpenClaw agent accessible via Telegram. It receives cloning tasks, orchestrates the process, and delivers results to GitHub. For the actual website building step, Clawvis delegates to the **Codex webapp** (`chatgpt.com/codex`) using the **ai-website-cloner-template** skill — instead of generating HTML/CSS on its own (which produced poor results).

| Component | Role |
|-----------|------|
| **Clawvis (OpenClaw)** | Telegram interface. Receives tasks, runs auth preflight, triggers Codex, handles GitHub delivery + collaborators |
| **Codex + clone skill** | The website cloning engine. Extracts real CSS via `getComputedStyle()`, dispatches parallel builder agents, produces Next.js + React + Tailwind output, runs visual QA |

The flow: `Kenji → Telegram → Clawvis → Codex $clone-website → Clawvis delivers to GitHub`

---

## What This Is NOT

- Not SEO analysis
- Not competitor research

Those are human decisions. The automation handles clone → validate → fix → deliver, nothing else.

---

## Tools

- **OpenClaw** — Clawvis agent platform (Telegram interface, orchestration)
- **OpenAI Codex** — website cloning via `$clone-website` skill (`chatgpt.com/codex`)
- **ai-website-cloner-template** — the clone skill (5-phase pipeline with parallel builders)
- **Browser MCP** (Playwright/Browserbase) — browser automation used by the clone skill

---

## Pivot: Codex Webapp + Clone Skill (2026-04-02)

Clawvis building websites on its own produced too-low quality output (pale, simple, unmatched colors/fonts). Kenji's direction: have Clawvis use the **OpenAI Codex webapp** (`chatgpt.com/codex`) with the **ai-website-cloner-template** skill for the website building step.

The template already implements our Plan → Implement → Validate loop, but with:
- Real CSS extraction (`getComputedStyle()`) instead of screenshot guessing
- Parallel builder agents in git worktrees
- Next.js + React + Tailwind output (production-grade)
- Automated visual QA with side-by-side screenshot comparison

See **CODEX-INTEGRATION.md** for full details.

## Action Items

- [ ] Get ChatGPT Plus subscription active
- [ ] Fork `ai-website-cloner-template` to `clawvisx` org
- [ ] Connect repo to Codex webapp at `chatgpt.com/codex`
- [ ] Test `$clone-website https://pala-consulting.de` in Codex
- [ ] Compare output quality against Clawvis-only output
- [ ] Share results with Kenji and decide: full Codex switch or hybrid
- [ ] Wire Clawvis to trigger `codex exec "$clone-website [URL]"` instead of building solo

---

## Goal

Automate screenshot → clone → validate → fix so the team focuses time on redesign, not manual cloning.

---

## Notes

- Start with one section of one page. Get the loop working before expanding.
- Clawvis runs on OpenClaw. MiniMax/MaxClaw are background context — see LEARNING-NOTES.md.
- Output format changes: template produces Next.js + React + Tailwind instead of plain HTML. Decision pending on whether to keep this or convert.
