# Learning Notes — Key Concepts for This Project

A plain-language breakdown of the tools, models, and ideas that came up in the boss's brief. Use this as a reference to get up to speed.

**Last Updated:** 2026-03-31

---

## What is OpenClaw?

OpenClaw is an open-source AI agent platform — think of it as a framework that lets you run AI "assistants" that can actually do things on a computer (browse the web, run code, manage files, etc.), not just chat.

It started as a side project called **Moltbot**, got renamed to **Clawdbot**, and finally became **OpenClaw** in January 2026. By March 2026 it had 250,000+ GitHub stars, making it one of the fastest-growing open-source projects ever.

**Why it matters for us:** OpenClaw is what Clawvis runs on. When the boss says "set it up using OpenClaw," he means configure an OpenClaw agent (on the other PC) that can clone websites autonomously.

**Key links:**
- Official site: [openclaw.ai](https://openclaw.ai/)
- GitHub: [github.com/openclaw/openclaw](https://github.com/openclaw/openclaw)
- Agent Loop docs: [docs.openclaw.ai/concepts/agent-loop](https://docs.openclaw.ai/concepts/agent-loop)

---

## What is an "Agent Loop"?

This is probably the most important concept for our project. An agent loop is the cycle an AI goes through to complete a task:

```
Receive instruction → Think about it → Take an action → Check the result → Repeat until done
```

In OpenClaw specifically, the loop looks like this:

```
Intake → Context Assembly → Model Inference → Tool Execution → Reply → Save State
```

Breaking that down in normal terms:

1. **Intake** — the agent receives a task ("clone this website")
2. **Context assembly** — it gathers everything it knows (previous attempts, the target site's code, screenshots, etc.)
3. **Model inference** — the AI model (like Codex 5.4) thinks about what to do next
4. **Tool execution** — it actually does something (writes code, takes a screenshot, compares images)
5. **Reply** — it reports what it did
6. **Save state** — it remembers where it left off so it doesn't lose progress

**Why it matters for us:** The "implement → validate → fix" loop the boss described IS an agent loop. The question is whether OpenClaw's loop is robust enough to keep going without a human checking in.

---

## What is Codex 5.4?

Codex is OpenAI's coding-focused AI model. Version 5.4 is the one reportedly running inside Clawvis. Think of it as the "brain" while OpenClaw is the "body" — Codex decides what code to write, OpenClaw executes it on the machine.

Fun fact: OpenClaw's creator (Peter Steinberger) actually built OpenClaw using Codex, though he personally recommends Claude Opus for general-purpose agent tasks. Different models are better at different things.

---

## What is Clawvis?

Clawvis is our team's name for the specific OpenClaw agent instance running on the other PC. It's not a separate product — it's OpenClaw configured with Codex 5.4, pointed at website cloning tasks.

Think of it like this: OpenClaw is the car, Codex 5.4 is the engine, and "Clawvis" is what we named our specific car.

---

## What is MiniMax? (The "Max" Model)

The Chinese model/platform the boss mentioned as "Max" is actually **MiniMax** — specifically their agent platform called **MaxClaw**. Here's the breakdown:

### The Company

**MiniMax** is a Shanghai-based AI company founded in 2022. They build multimodal AI models and consumer applications. They listed on the Hong Kong Stock Exchange in January 2026 and had $79M revenue in 2025 with 236M+ users across 200+ countries. This is a legit, well-funded operation — not some random startup.

### The Models (MiniMax M-Series)

MiniMax builds their own AI models. The key ones to know:

| Model | What It Is |
|-------|-----------|
| **MiniMax M2** | Open-source (Apache 2.0). 230B total parameters, 10B activated per token (MoE architecture). Ranked #1 among open-source models for agentic tool-calling. Specifically built for coding and agent workflows. |
| **MiniMax M2.5** | Released Feb 2026. 80.2% on SWE-Bench Verified. State-of-the-art in coding, agentic tool use, and search tasks. Powers MaxClaw. |
| **MiniMax M2.7** | Released March 18, 2026. "Self-evolving" — can update its own memory and run reinforcement learning experiments without human intervention. Latest and most advanced. |

**The killer stat:** MiniMax M2 runs at ~8% of the price of Claude Sonnet and twice the speed. For a high-volume cloning operation, that cost difference could be significant.

### MaxClaw (The Agent Platform)

This is probably what the boss was actually thinking of when he said "Max." **MaxClaw** launched on February 25, 2026, and it's MiniMax's cloud-hosted AI agent platform.

**What it is:** A managed, cloud-based agent that works like OpenClaw but runs entirely in MiniMax's cloud. No local setup, no infrastructure management. One-click deployment in ~10 seconds.

**What it can do:** MaxClaw fully inherits the **OpenClaw tool ecosystem** — web browsing, code execution, file analysis, automation scripts. It handles complex multi-step workflows autonomously and maintains memory across sessions.

**Why this is big for us:** Because MaxClaw is OpenClaw-compatible, anything we build/test locally with Clawvis could potentially be deployed to MaxClaw's cloud. That means we could run the cloning pipeline without keeping a dedicated PC running.

### How MiniMax M2 Handles Code

This is directly relevant to our cloning use case. MiniMax M2 is specifically engineered for:
- **Coding-run-fix loops** — exactly the implement → validate → fix cycle we need
- **Multi-file edits** — can work across HTML, CSS, JS files simultaneously
- **Shell + Browser + Python** tool coordination — can browse a target site, write clone code, execute it, and verify results
- **204K token context window** — can hold entire codebases in memory without losing coherence

**Why it matters for us:** MiniMax/MaxClaw is a strong alternative to Clawvis. Its OpenClaw compatibility means it's not an either/or choice — we could test both on the same task using the same workflow. The cloud-hosted nature of MaxClaw is also attractive since it removes the need for a dedicated local machine.

**Key links:**
- MiniMax official site: [minimax.io](https://www.minimax.io/)
- MaxClaw: [maxclaw.ai](https://maxclaw.ai/)
- MiniMax M2 GitHub: [github.com/MiniMax-AI/MiniMax-M2](https://github.com/MiniMax-AI/MiniMax-M2)
- MiniMax M2.5 announcement: [minimax.io/news/minimax-m25](https://www.minimax.io/news/minimax-m25)
- MiniMax Agent download: [agent.minimax.io/download](https://agent.minimax.io/download)

---

## OpenClaw 2.0 — Multi-Agent System (MAS)

This is a newer feature of OpenClaw (released in 2026) and could be the key to solving our validation loop problem.

**Old way (single agent):** One AI does everything — clones the site, checks if it's right, fixes mistakes. Problem: it can lose focus and drift.

**New way (multi-agent):** You set up a *team* of specialized agents, each with a specific job:

| Agent Role | What It Does |
|------------|--------------|
| **Cloning Agent** | Writes the code to replicate the target website |
| **Validation Agent** | Compares the clone to the original (screenshots, DOM structure, etc.) |
| **Fix Agent** | Takes the validation report and patches the differences |

These agents talk to each other. The Cloning Agent does its work, hands off to the Validation Agent, which flags issues to the Fix Agent, which makes corrections and kicks it back to Validation. The loop runs until the Validation Agent says "looks good."

**Why it matters for us:** This is probably the architecture we'd want to set up. Instead of hoping one agent can do everything perfectly, we split the job into roles that check each other's work. Both Clawvis (local) and MaxClaw (cloud) support this architecture since they share the OpenClaw ecosystem.

---

## OpenClaw Hooks (The Technical Bits)

OpenClaw lets you inject custom logic at specific points in the agent loop. These are called "hooks." The ones most relevant to us:

- **`before_tool_call` / `after_tool_call`** — Runs before/after the agent takes an action. We could use `after_tool_call` to automatically take a screenshot and compare it to the target site after every change.
- **`before_prompt_build`** — Lets you inject extra context before the AI thinks. We could inject reference screenshots of the target site here so the agent always "sees" what it's aiming for.
- **`before_compaction` / `after_compaction`** — Manages the AI's memory when conversations get too long. Important for long-running cloning sessions where the agent might otherwise "forget" earlier decisions.

You don't need to understand these deeply right now — just know they exist and give us fine-grained control over what the agent does at each step.

---

## Other Tools Worth Knowing About

These came up during research. Not our focus, but good to be aware of:

**Same.new** — An AI tool that clones websites "pixel-perfect," including backend behavior. Sounds amazing, but it's had major issues with being used for phishing (cloning login pages to steal credentials). Probably not something we'd want to use in production, but the technology is impressive.

**Perfect-Web-Clone** — An open-source project on GitHub that uses a multi-agent architecture (similar idea to OpenClaw 2.0 MAS). It clones from CSS and structured HTML blocks rather than screenshots, which can produce more accurate results. Built on Claude Agent SDK. Worth keeping on our radar.

---

## Glossary

| Term | Meaning |
|------|---------|
| **Agent** | An AI that can take actions on a computer, not just chat |
| **Agent loop** | The cycle of think → act → check → repeat that agents use |
| **MAS** | Multi-Agent System — multiple specialized agents working as a team |
| **Hook** | A point in the agent loop where you can inject custom code |
| **Session serialization** | Ensuring the agent processes one thing at a time so it doesn't get confused |
| **Compaction** | Shrinking the AI's conversation history when it gets too long, so it can keep working |
| **DOM** | Document Object Model — the structure/code behind a webpage |
| **Codex** | OpenAI's coding-focused AI model |
| **MoE** | Mixture of Experts — an architecture where only a subset of the model's parameters activate per task (used by MiniMax M2) |
| **MaxClaw** | MiniMax's cloud-hosted AI agent platform, OpenClaw-compatible |
| **MiniMax M2** | MiniMax's open-source coding/agentic model (230B params, 10B activated) |
| **SWE-Bench** | A benchmark that tests AI models on real-world software engineering tasks |
