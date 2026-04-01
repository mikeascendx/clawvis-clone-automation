# Learning Notes — Key Concepts for This Project

A plain-language breakdown of the tools and ideas relevant to the cloning automation work.

**Last Updated:** 2026-04-01

---

## Current Approach: Claude Code Custom Skills

We're building this as **custom skills for Claude Code** (the CLI tool). Not OpenClaw, not a cloud platform — just a few skills that implement the Plan → Implement → Validate loop using Playwright for browser automation.

Reason: keep it simple, see if the idea works first.

---

## What is an "Agent Loop"?

The core pattern our project runs on:

```
Receive instruction → Think → Take an action → Check the result → Repeat until done
```

For us specifically:
1. Plan Skill takes a screenshot of the target section
2. Implementation Agent clones it
3. Validation Agent checks the clone against the screenshot
4. Orchestration Agent routes fixes and moves to the next section

---

## What is Playwright?

Browser automation library. Lets code open a real browser, navigate to a URL, interact with the page, and take screenshots — all programmatically.

We use it in:
- **Plan Skill** — open the target site, use DevTools to pull font/color info, screenshot + crop the section
- **Validation Agent** — open the cloned output in a browser, take a screenshot, compare against reference

---

## What is Claude Code Skills?

Claude Code (the CLI) supports custom "skills" — reusable prompts/agents you can invoke by name. We're building the Plan, Implementation, and Validation components as skills so they can be triggered by the Orchestration Agent in a loop.

---

## Background Context (Not Our Current Build Target)

### OpenClaw

OpenClaw is an open-source AI agent platform with 250K+ GitHub stars. It can run browser automation, code execution, and multi-agent workflows. The boss evaluated it but decided we don't need that complexity right now — we just want to see if the core idea works first.

**Security note:** OpenClaw has had significant security issues (135K+ exposed instances, 9 CVEs in 4 days in March 2026, 820+ malicious skills on its registry). Worth knowing if it ever comes back into scope.

### MiniMax / MaxClaw

MiniMax is a Shanghai-based AI company. MaxClaw is their cloud-hosted agent platform (launched Feb 2026), compatible with OpenClaw's ecosystem. Their M2 model runs at ~8% of Claude Sonnet's cost and 2x the speed — worth benchmarking later for high-volume cloning if cost becomes a concern.

---

## Glossary

| Term | Meaning |
|------|---------|
| **Agent** | An AI that takes actions on a computer, not just chat |
| **Agent loop** | The cycle of think → act → check → repeat |
| **Orchestration Agent** | The "manager" agent that runs the loop and directs other agents |
| **Playwright** | Browser automation library (opens real browser, takes screenshots, etc.) |
| **DevTools** | Browser developer tools — used to inspect fonts, colors, layout |
| **Claude Code skill** | A reusable custom agent/prompt invokable from the Claude Code CLI |
| **MAS** | Multi-Agent System — multiple specialized agents working as a team |
| **MaxClaw** | MiniMax's cloud-hosted agent platform (OpenClaw-compatible) |
| **OpenClaw** | Open-source AI agent platform (not our current build target) |
