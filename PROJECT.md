# Website Cloning Automation — Project Doc

**Status:** Exploration / Research Phase
**Last Updated:** 2026-03-31
**Owner:** Mike

---

## Background

A significant chunk of our current workflow is cloning existing websites, then redesigning them to look differentiated. The cloning step has been identified as highly automatable — this project is about making that happen.

Previously explored a similar direction with **Antigravity**, which gave us useful reference points on where the hard problems actually are.

---

## Core Challenge

The tricky part isn't the cloning itself — it's the **validation loop**:

> Implement something → check if the output actually matches the original → fix what's off → repeat.

Without supervision, models tend to drift and do their own thing. The goal is to close this loop autonomously so human review only happens at the redesign stage, not the cloning stage.

---

## Tools / Models to Explore

### Clawvis (OpenClaw Agent)
- An OpenClaw agent running on a **separate PC** (not this machine)
- Reportedly runs **Codex 5.4** under the hood
- Key question: can it manage the implement → validate → fix loop autonomously over longer sessions?
- Note: OpenClaw's creator (Peter Steinberger) built the tool using OpenAI's Codex and recommends Claude Opus as the best general-purpose agent — so Codex under the hood makes sense for code-heavy cloning tasks

### MiniMax / MaxClaw (formerly referred to as "Max")
- **Confirmed identity:** MiniMax — a Shanghai-based AI company (minimax.io), listed on the Hong Kong Stock Exchange in January 2026
- **MaxClaw** is MiniMax's cloud-hosted AI agent platform (launched Feb 25, 2026) — a managed, cloud-based version of an OpenClaw-style agent. This is likely what the boss was referring to as "Max"
- Powered by **MiniMax M2.5** under the hood — a Mixture-of-Experts (MoE) model with 229B total parameters (~10B activated per token)
- MaxClaw fully inherits the **OpenClaw tool ecosystem**, supporting web browsing, code execution, file analysis, and automation scripts
- MiniMax M2 is open-source (Apache 2.0) and ranks #1 among open-source models for agentic tool-calling tasks, with an 80.2% SWE-Bench Verified score
- M2 is specifically engineered for **coding-run-fix loops** and multi-file edits — directly relevant to our validation loop problem
- Available at ~8% of the price of Claude Sonnet and twice the speed
- Worth benchmarking against Clawvis for the cloning use case — MaxClaw's OpenClaw compatibility means it could slot into the same workflow

---

## Research Findings: OpenClaw Agent Loop

OpenClaw's architecture looks promising for the validation loop problem. Here's what the agent loop supports:

**Core loop:** intake → context assembly → model inference → tool execution → streaming replies → persistence. This maps well to implement → validate → fix.

**Session serialization:** Runs are serialized per session key, preventing tool/session races and keeping state consistent across long-running sessions. This is critical — it means the agent won't lose track of where it is in the cloning process.

**Hook system:** OpenClaw has hooks at key points in the loop:
- `before_tool_call` / `after_tool_call` — can intercept and validate tool outputs (useful for checking if a clone matches the original)
- `before_prompt_build` — can inject context (e.g., reference screenshots or DOM snapshots of the target site)
- `before_compaction` / `after_compaction` — manages context window over long sessions

**OpenClaw 2.0 Multi-Agent System (MAS):** Introduces specialized agent roles. For our use case, we could potentially set up:
- A **Cloning Agent** — does the implementation
- A **Validation Agent** — compares output to the original
- A **Fix Agent** — patches discrepancies
- This architecture could be the key to closing the validation loop autonomously

**MaxClaw compatibility note:** Since MaxClaw inherits the OpenClaw tool ecosystem, a MAS setup tested locally with Clawvis could potentially be deployed to MaxClaw's cloud for hands-off operation.

**Event-driven:** The loop only spins up when a message arrives. For autonomous operation, we'd need to wire up a trigger mechanism (e.g., the validation agent sends a message back to the cloning agent when it finds diffs).

---

## Other Tools in the Space (for reference)

| Tool | Notes |
|------|-------|
| **Same.new** | AI website cloner, reportedly pixel-perfect. Has phishing concerns — probably not suitable for production use |
| **Perfect-Web-Clone** | Open-source, multi-agent architecture built on Claude Agent SDK. Clones from CSS & structured blocks, not screenshots |
| **UXMagic** | Clone-to-editable-design tool |
| **Energent.ai** | AI website cloner for instant replication |

These are worth watching but our main focus is on Clawvis (OpenClaw) and MiniMax/MaxClaw since that's what the boss flagged.

---

## Action Items

- [x] Identify the Chinese model — it's **MiniMax** (and their agent platform **MaxClaw**), not "Max" or "Manus"
- [x] Research OpenClaw's agent loop and whether it supports autonomous validation
- [x] Research MiniMax M2/M2.5 capabilities and MaxClaw platform
- [ ] Test Clawvis on a sample clone task and document results
- [ ] Set up OpenClaw 2.0 MAS with separate Cloning / Validation / Fix agents
- [ ] Benchmark MaxClaw vs Clawvis on the same sample site
- [ ] Explore the `after_tool_call` hook for automated screenshot comparison
- [ ] Evaluate MaxClaw cloud deployment for hands-off autonomous cloning
- [ ] Document recommended setup/workflow for the team

---

## Goal

Automate the website cloning step **end-to-end** so the team can focus time on redesign work and take on more clients. The redesign stage stays human-driven; the cloning stage should not require supervision.

---

## Notes

- Clawvis runs on a **separate PC** — integration/orchestration needs to account for remote execution
- OpenClaw 2.0's multi-agent architecture looks like the most promising path for autonomous validation loops
- MaxClaw (MiniMax's cloud agent) is OpenClaw-compatible, which means we could potentially run our setup in the cloud without managing infrastructure
- MiniMax M2.7 (released March 2026) is their latest model — "self-evolving" with the ability to update its own memory and run RL experiments autonomously. Worth monitoring for future upgrades
- MiniMax listed on HKEX in Jan 2026, well-funded ($79M revenue in 2025, 236M+ users) — not a fly-by-night operation

---

## Sources

- [OpenClaw Agent Loop Docs](https://docs.openclaw.ai/concepts/agent-loop)
- [OpenClaw 2.0: Architecting Agentic Workflows](https://kollox.com/openclaw-2-0-architecting-agentic-workflows-for-enterprise-scale-2/)
- [How OpenClaw Works — Inside the Agent Loop (Medium)](https://tomaszs2.medium.com/how-does-openclaw-work-inside-the-agent-loop-that-powers-200-000-github-stars-e61db2bbfcbb)
- [MiniMax Official Site](https://www.minimax.io/)
- [MiniMax M2 & Agent Announcement](https://www.minimax.io/news/minimax-m2)
- [MiniMax M2.5 Announcement](https://www.minimax.io/news/minimax-m25)
- [MiniMax M2.7 Announcement](https://www.minimax.io/models/text/m27)
- [MaxClaw — Cloud AI Agent by MiniMax](https://maxclaw.ai/)
- [What is MaxClaw? (WaveSpeed AI)](https://wavespeed.ai/blog/posts/what-is-maxclaw/)
- [MiniMax-M2 GitHub (Open Source)](https://github.com/MiniMax-AI/MiniMax-M2)
- [MiniMax-M2 on VentureBeat](https://venturebeat.com/ai/minimax-m2-is-the-new-king-of-open-source-llms-especially-for-agentic-tool)
- [MiniMax Wikipedia](https://en.wikipedia.org/wiki/MiniMax_(company))
- [OpenClaw + Codex (Fortune)](https://fortune.com/2026/02/02/openai-launches-codex-app-to-bring-coding-models-to-more-users-openclaw-ai-agents/)
- [Perfect-Web-Clone (GitHub)](https://github.com/ericshang98/perfect-web-clone)
- [Same.new](https://same.new/)
