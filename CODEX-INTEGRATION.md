# Codex Webapp Integration Plan

**Status:** Testing
**Last Updated:** 2026-04-02
**Why:** Clawvis doing everything on its own produces low-fidelity clones (pale, simple, unmatched). Kenji wants Clawvis to use the Codex webapp + skills for the website building step instead of generating HTML/CSS on its own.

---

## What Changed

Clawvis is an **OpenClaw agent** accessible via Telegram — that stays the same. What changes is the implementation step: instead of Clawvis generating HTML/CSS on its own, it now delegates website cloning to **OpenAI Codex** (`chatgpt.com/codex`) with the **ai-website-cloner-template** skill. Clawvis still handles orchestration, auth preflight, GitHub delivery, and collaborator management.

The template implements a production-ready cloning pipeline with higher fidelity output (Next.js + React + Tailwind, parallel builder agents, real CSS extraction via `getComputedStyle()`).

---

## The Tool: ai-website-cloner-template

**Repo:** `github.com/JCodesMore/ai-website-cloner-template`
**Stars:** 7,000+ | **License:** MIT

### Why It's Better Than Clawvis Building Alone

| Problem with Clawvis doing it solo | How the Template Fixes It |
|---|---|
| Guesses colors from screenshots | Extracts exact `getComputedStyle()` values from live DOM |
| Generates plain HTML/CSS | Produces Next.js + React + Tailwind (production-grade) |
| Single agent, sequential | Parallel builder agents in git worktrees (one per section) |
| No structured extraction | Writes spec files per component before building |
| No automated QA | Phase 5 does side-by-side screenshot diff + interactive testing |

### 5-Phase Pipeline

1. **Reconnaissance** — Screenshots (desktop + mobile), extract fonts/colors/favicons, map page topology
2. **Foundation Build** — Set up fonts, globals.css, TypeScript interfaces, download all assets
3. **Component Specification & Dispatch** — Extract DOM + computed styles per section, write spec files, dispatch parallel builder agents
4. **Page Assembly** — Wire sections into page layout, verify build passes
5. **Visual QA Diff** — Side-by-side comparison, fix discrepancies, `npm run build` must pass

### Requirements

- **Browser MCP** is mandatory (Playwright, Browserbase, Chrome, or Puppeteer)
- **Node.js 24+**
- Tech stack: Next.js 16, React 19, Tailwind CSS v4, shadcn/ui

---

## How to Test (Step by Step)

### Option A: Codex Webapp (What Kenji Wants)

**Prerequisites:**
- ChatGPT Plus ($20/mo) or Pro ($200/mo) subscription
- GitHub account connected to Codex

**Steps:**

1. **Go to** `chatgpt.com/codex`

2. **Fork the template repo:**
   ```
   gh repo fork JCodesMore/ai-website-cloner-template --clone --org clawvisx
   ```

3. **Connect the forked repo** in Codex settings:
   - Go to `chatgpt.com/codex/settings/environments`
   - Add the `clawvisx/ai-website-cloner-template` repo

4. **Run the clone task** in Codex webapp:
   ```
   $clone-website https://pala-consulting.de
   ```
   The `$clone-website` skill is auto-discovered from `.codex/skills/clone-website/SKILL.md` in the repo.

5. **Review output** — Codex shows a diff view of all generated files. Approve and merge.

6. **Deploy or transfer** — Pull the result, restructure if needed for our delivery format.

### Option B: Codex CLI (For Automation)

```bash
# Install Codex CLI
npm i -g @openai/codex

# Clone the template
git clone https://github.com/JCodesMore/ai-website-cloner-template.git pala-consulting-clone
cd pala-consulting-clone

# Run the cloner skill
codex exec "$clone-website https://pala-consulting.de" --full-auto
```

### Option C: Install Skill Without Forking

Inside any Codex session (webapp or CLI):
```
$skill-installer install --repo JCodesMore/ai-website-cloner-template --path .codex/skills/clone-website
```
Then restart Codex. The skill is now available globally.

---

## How This Fits With Clawvis

Clawvis is an **OpenClaw agent** you chat with on Telegram. The user-facing flow stays the same — you send Clawvis a URL, Clawvis delivers a GitHub repo. What changes is that Clawvis delegates the website building to Codex instead of doing it solo.

```
Before:  Kenji → Telegram → Clawvis (OpenClaw) does everything alone → bad output
After:   Kenji → Telegram → Clawvis (OpenClaw) triggers Codex clone skill → good output
```

### What Clawvis Still Handles

- Receiving tasks via Telegram
- Auth preflight (`gh auth status`, etc.)
- Triggering Codex `$clone-website` skill (via `codex exec` or Codex webapp)
- GitHub repo creation under `clawvisx` org
- Adding collaborators (`mikeascendx`, `KIshiharaHCI`)
- Delivery notification (repo URL back to Telegram)

### What Codex Handles

- The actual website cloning (the `$clone-website` skill)
- Browser automation, CSS extraction, asset downloading
- Parallel builder agents
- Visual QA diff
- Producing the Next.js + React + Tailwind output

---

## Output Format Difference

The template outputs **Next.js + React + Tailwind**, not our current plain HTML structure:

| Our Current Format | Template Output |
|---|---|
| `index.html` | `src/app/page.tsx` |
| `css/styles.css` | `src/app/globals.css` + Tailwind |
| `images/` | `public/images/` |

**Decision needed:** Do we adapt to the Next.js output (better quality, modern stack) or add a post-processing step to convert to plain HTML? Recommend: **keep Next.js output** — it's production-grade and deployable.

---

## Cost

| Plan | Price | Cloud Tasks per 5hr |
|---|---|---|
| ChatGPT Plus | $20/mo | ~10-60 |
| ChatGPT Pro | $200/mo | ~50-400 |
| API key (CLI) | ~$0.12-0.64/task | Usage-based |

For testing: ChatGPT Plus is enough. For production volume: evaluate API key pricing.

---

## Immediate Next Steps

1. [ ] Get ChatGPT Plus subscription (if not already active)
2. [ ] Fork `ai-website-cloner-template` to `clawvisx` org
3. [ ] Connect repo to Codex webapp
4. [ ] Test `$clone-website https://pala-consulting.de` in Codex
5. [ ] Compare output quality against old Clawvis-solo output
6. [ ] Share results with Kenji
7. [ ] Wire Clawvis to trigger Codex `$clone-website` skill (via `codex exec` CLI) instead of building solo
