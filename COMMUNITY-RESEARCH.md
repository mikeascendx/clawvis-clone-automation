# Community Research — Background Reference

Research on tools in this space. **Clawvis** (our OpenClaw agent on Telegram) now delegates website building to the **Codex webapp + ai-website-cloner-template** skill. Other tools listed below are background context.

**Last Updated:** 2026-04-02
**Original research date:** 2026-03-31

---

## Current Direction

Clawvis runs on **OpenClaw** and is accessible via Telegram. For the website cloning step, Clawvis uses the **OpenAI Codex webapp** (`chatgpt.com/codex`) with the **ai-website-cloner-template** skill. See `CODEX-INTEGRATION.md` for setup and workflow details.

---

## OpenClaw — Community Sentiment (Clawvis Platform)

Clawvis runs on OpenClaw. OpenClaw hit 247,000+ GitHub stars in ~60 days. The community is split:

**Positive:** People are building full websites, running multi-agent teams on VPSs, automating code reviews. The multi-agent pattern (plan → implement → validate) is validated in the wild.

**Negative:** Significant security track record issues:
- 135,000+ exposed instances, 15,000+ vulnerable to remote code execution
- 9 CVEs in 4 days (March 2026), including one scoring 9.9/10 CVSS
- 820+ malicious skills found on ClawHub (OpenClaw's skill registry)
- Session sandbox escapes

Since Clawvis runs on OpenClaw, hardening is important for production deployment.

---

## MiniMax / MaxClaw — Community Sentiment (Background)

**MaxClaw** (launched Feb 25, 2026) is MiniMax's cloud-hosted agent platform, OpenClaw-compatible. MiniMax's own X account posted about "Conflictly Clone, built with MaxClaw" — so people are using it for website cloning specifically.

**MiniMax M2 vs Claude on coding tasks (community consensus):**

| Factor | MiniMax M2/M2.5 | Claude Sonnet/Opus |
|--------|-----------------|-------------------|
| Code generation | Competitive | Slightly lower on benchmarks |
| Cost | ~$0.09/workflow | ~$1.05/workflow (12x more) |
| Speed | ~2x faster | Slower |
| Complex debugging | Weaker per devs | Preferred |
| Trust/maturity | Newer, some benchmark gaming concerns | Battle-tested |

Bottom line: MiniMax is interesting for high-volume repetitive tasks (cost/speed), Claude is preferred for complex architectural work. Worth benchmarking later if cloning volume scales up.

---

## Other Tools in the Space

| Tool | Notes |
|------|-------|
| **ai-website-cloner-template** | **Our current tool.** 7K+ stars, MIT license. Agent skill for Codex/Claude Code/Cursor/etc. 5-phase pipeline with parallel builders, `getComputedStyle()` extraction, Next.js + React + Tailwind output. Repo: `github.com/JCodesMore/ai-website-cloner-template` |
| **Perfect-Web-Clone** | Open-source, multi-agent, built on Claude Agent SDK + Playwright. Extracts real DOM/CSS (not screenshots). Highest fidelity alternative. Repo: `github.com/ericshang98/perfect-web-clone` |
| **CopyWeb** | SaaS (`copyweb.ai`). URL/screenshot/Figma to code. Exports React, Vue, or HTML/CSS. Recommended as top pick for end-to-end UI-to-code in 2026 |
| **Same.new** | AI website cloner, reportedly pixel-perfect. Has phishing abuse concerns — not for production use |
| **UXPilot** | SaaS (`uxpilot.ai/website-cloner`). URL input, generates editable layouts. Better for design exploration than exact cloning. Exports to Figma |

---

## Sources (for reference if needed)

- [OpenClaw instances exposed (The Register)](https://www.theregister.com/2026/02/09/openclaw_instances_exposed_vibe_code/)
- [MaxClaw launch (TestingCatalog on X)](https://x.com/testingcatalog/status/2026678621545320623)
- [MiniMax — "Conflictly Clone, built with MaxClaw"](https://x.com/MiniMax_AI/status/2029076215651537148)
- [MiniMax M2 open-source launch](https://x.com/MiniMax__AI/status/1986815058249408541)
- [Perfect-Web-Clone (GitHub)](https://github.com/ericshang98/perfect-web-clone)
- [TechCrunch — OpenClaw skepticism](https://techcrunch.com/2026/02/16/after-all-the-hype-some-ai-experts-dont-think-openclaw-is-all-that-exciting/)
