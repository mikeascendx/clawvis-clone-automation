# Community Research — Background Reference

Research on tools in this space. Kept as background context — our current build target is Claude Code custom skills, not OpenClaw or MaxClaw.

**Last Updated:** 2026-04-01
**Original research date:** 2026-03-31

---

## Current Direction

We're building custom Claude Code skills with Playwright. The OpenClaw/MiniMax research below is background only — useful if we revisit those platforms later, but not the focus now.

---

## OpenClaw — Community Sentiment (Background)

OpenClaw hit 247,000+ GitHub stars in ~60 days. The community is split:

**Positive:** People are building full websites, running multi-agent teams on VPSs, automating code reviews. The multi-agent pattern (plan → implement → validate) is validated in the wild.

**Negative:** Significant security track record issues:
- 135,000+ exposed instances, 15,000+ vulnerable to remote code execution
- 9 CVEs in 4 days (March 2026), including one scoring 9.9/10 CVSS
- 820+ malicious skills found on ClawHub (OpenClaw's skill registry)
- Session sandbox escapes

If OpenClaw ever comes back into scope, hardening is non-negotiable before deploying anything.

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
| **Same.new** | AI website cloner, reportedly pixel-perfect. Has phishing abuse concerns — not for production use |
| **Perfect-Web-Clone** | Open-source, multi-agent, built on Claude Agent SDK. Clones from CSS/HTML structure rather than screenshots |

---

## Sources (for reference if needed)

- [OpenClaw instances exposed (The Register)](https://www.theregister.com/2026/02/09/openclaw_instances_exposed_vibe_code/)
- [MaxClaw launch (TestingCatalog on X)](https://x.com/testingcatalog/status/2026678621545320623)
- [MiniMax — "Conflictly Clone, built with MaxClaw"](https://x.com/MiniMax_AI/status/2029076215651537148)
- [MiniMax M2 open-source launch](https://x.com/MiniMax__AI/status/1986815058249408541)
- [Perfect-Web-Clone (GitHub)](https://github.com/ericshang98/perfect-web-clone)
- [TechCrunch — OpenClaw skepticism](https://techcrunch.com/2026/02/16/after-all-the-hype-some-ai-experts-dont-think-openclaw-is-all-that-exciting/)
