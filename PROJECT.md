# Website Cloning Automation — Project Doc

**Status:** Building MVP
**Last Updated:** 2026-04-01
**Owner:** Mike

---

## Background

A significant chunk of our current workflow is cloning existing websites, then redesigning them. The cloning step is highly automatable — this project is about making that happen.

Previously explored a similar direction with **Antigravity**: you screenshot a section, give it to the model, it clones it, you check the output, fix issues, move to the next section. That manual process is exactly what we're automating.

---

## Approach

Build a few **custom Claude Code skills** that implement the cloning loop. No complicated infrastructure — first goal is to prove the concept works.

Architecture is BMAD-style, optimized for cloning:

| Component | Role |
|-----------|------|
| **Orchestration Agent** | Cron/heartbeat. Manages the loop, waits for agents, directs next steps |
| **Plan Skill** | Opens browser via Playwright, extracts fonts/colors/assets, screenshots and crops the target section, returns handover prompt to Orchestration |
| **Implementation Agent** | Receives plan output, generates the HTML/CSS clone of that section |
| **Validation Agent** | Opens clone in browser, screenshots it, compares against reference, returns fix list to Orchestration |

The loop: `Plan → Implement → Validate → fix → re-validate → next section`

---

## What This Is NOT

- Not SEO analysis
- Not competitor research
- Not complex infrastructure (no OpenClaw setup for now)

Those are human decisions. The automation handles screenshot → clone → validate → fix, nothing else.

---

## Tools

- **Claude Code custom skills** — the primary build target
- **Playwright** — browser automation for the Plan and Validation skills
- Browser DevTools (via Playwright) — extract font family, hex color codes

---

## Action Items

- [ ] Build Plan Skill: Playwright opens URL, DevTools extraction, screenshot + crop, returns handover prompt
- [ ] Build Implementation Agent: takes plan handover, generates HTML/CSS clone
- [ ] Build Validation Agent: screenshots clone output, compares to reference, returns fix list
- [ ] Build Orchestration Agent: manages the loop between the three above
- [ ] Test the full loop on one real section of one real page
- [ ] Tune from there

---

## Goal

Automate screenshot → clone → validate → fix so the team focuses time on redesign, not manual cloning.

---

## Notes

- Start with one section of one page. Get the loop working before expanding.
- OpenClaw and MiniMax/MaxClaw are background context — see LEARNING-NOTES.md — but not the build target right now.
