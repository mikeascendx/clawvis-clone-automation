# Learning Notes — Key Concepts for This Project

A plain-language breakdown of the tools and ideas relevant to the cloning automation work.

**Last Updated:** 2026-04-02

---

## Current Approach: Clawvis (OpenClaw) + Codex Clone Skill

**Clawvis** is an OpenClaw agent accessible via Telegram. It receives cloning tasks from Kenji, orchestrates the process, and delivers results to GitHub. For the actual website building, Clawvis delegates to the **Codex webapp** (`chatgpt.com/codex`) using the **ai-website-cloner-template** skill — instead of generating HTML/CSS on its own (which produced pale, simple, unmatched output).

The template implements the Plan → Implement → Validate loop with higher fidelity: real CSS extraction via `getComputedStyle()`, parallel builder agents in git worktrees, and Next.js + React + Tailwind output.

See `CODEX-INTEGRATION.md` for full details.

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

Claude Code (the CLI) supports custom "skills" — reusable prompts/agents you can invoke by name. Originally we planned to build the Plan, Implementation, and Validation components as Claude Code skills. We now use the Codex webapp with a pre-built clone skill instead (see below).

---

## What is OpenAI Codex?

OpenAI's cloud-based coding agent, accessed at `chatgpt.com/codex`. Available as a webapp, CLI (`npm i -g @openai/codex`), and SDK. Requires ChatGPT Plus ($20/mo) or Pro ($200/mo).

Key feature: **Agent Skills** — reusable skill packages (a `SKILL.md` file + scripts/assets) stored in `.agents/skills/` or `.codex/skills/` directories. Skills are auto-discovered when a repo is connected to the webapp.

We use it with the **ai-website-cloner-template** (`github.com/JCodesMore/ai-website-cloner-template`) — a 7K+ star MIT-licensed skill that implements a 5-phase cloning pipeline with parallel builder agents.

---

## What is getComputedStyle()?

A browser API that returns the actual computed CSS values of any DOM element. Unlike guessing colors/fonts from a screenshot, `getComputedStyle()` gives you the exact hex codes, font families, pixel sizes, margins, and paddings the browser is rendering. The ai-website-cloner-template uses this to extract precise design tokens from the target site.

---

## What is OpenClaw?

OpenClaw is an open-source AI agent platform with 250K+ GitHub stars. It can run browser automation, code execution, and multi-agent workflows. **Clawvis runs on OpenClaw** — it's how you interact with Clawvis via Telegram.

**Security note:** OpenClaw has had significant security issues (135K+ exposed instances, 9 CVEs in 4 days in March 2026, 820+ malicious skills on its registry). Hardening is important for any production deployment.

---

## Background Context

### MiniMax / MaxClaw

MiniMax is a Shanghai-based AI company. MaxClaw is their cloud-hosted agent platform (launched Feb 2026), compatible with OpenClaw's ecosystem. Their M2 model runs at ~8% of Claude Sonnet's cost and 2x the speed — worth benchmarking later for high-volume cloning if cost becomes a concern.

---

## Glossary

| Term | Meaning |
|------|---------|
| **Agent** | An AI that takes actions on a computer, not just chat |
| **Agent loop** | The cycle of think → act → check → repeat |
| **Agent Skill** | A reusable skill package (`SKILL.md` + scripts/assets) — open standard supported by Codex, Claude Code, Cursor, etc. |
| **Browser MCP** | Browser automation integration (Playwright, Browserbase, Chrome, Puppeteer) used by the clone skill to interact with target sites |
| **Claude Code skill** | A reusable custom agent/prompt invokable from the Claude Code CLI |
| **Clawvis** | Our OpenClaw agent, accessible via Telegram. Orchestrates the cloning workflow, delegates website building to Codex |
| **Codex** | OpenAI's cloud-based coding agent (`chatgpt.com/codex`) — used by Clawvis for the website cloning step |
| **DevTools** | Browser developer tools — used to inspect fonts, colors, layout |
| **getComputedStyle()** | Browser API that returns exact computed CSS values from DOM elements |
| **MAS** | Multi-Agent System — multiple specialized agents working as a team |
| **MaxClaw** | MiniMax's cloud-hosted agent platform (OpenClaw-compatible) |
| **OpenClaw** | Open-source AI agent platform — Clawvis runs on it |
| **Orchestration Agent** | The "manager" agent that runs the loop and directs other agents |
| **Playwright** | Browser automation library (opens real browser, takes screenshots, etc.) |
| **SKILL.md** | The definition file for an Agent Skill — contains name, description, and instructions |
| **Worktree** | A git feature that allows multiple working directories from one repo — used by the clone skill to run parallel builder agents |
