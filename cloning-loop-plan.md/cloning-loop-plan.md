# Website Cloning Automation Loop (Clawvis)

## Objective
Automate the clone-validate-fix cycle section by section using Claude Code custom skills — no complicated setup, just prove the idea works first.

---

## Core Concept

The loop mirrors what you'd do manually with Anti-Gravity:
1. Open the target website in a browser
2. Screenshot a section
3. Give the screenshot to the model and tell it to clone that section
4. Check the output — fix text deformation, spacing issues, etc.
5. Move to the next section and repeat

Everything below is just that loop, made autonomous.

---

## Architecture (BMAD-style, optimized for cloning)

Four components. Three are Claude Code custom skills, one is an agent.

---

### 1. Orchestration Agent (Heartbeat / Cron)
- Runs as a cron job or heartbeat
- Maintains an ordered queue of sections to process (top to bottom of the page)
- Waits for each skill/agent to finish before directing the next step
- Creates and initializes new agents as needed
- Tracks which sections are done, which need fixing, and what's next
- **Max 3 fix attempts per section** — if Validation still reports issues after 3 tries, log it and move on rather than looping forever

---

### 2. Plan Skill
Uses Playwright (or similar browser tool) to analyze and capture the target section.

**What it does:**
- Opens the target URL in a real browser
- Uses DevTools to extract:
  - Font family and size
  - Hex color codes
- Extracts assets needed for the section: icons, images
- Filters out files not relevant to the current section
- Takes a screenshot of the full section
- Crops to just the section being cloned

**Returns to Orchestration Agent:**
- Saves all outputs to `/workspace/section-N/` (screenshot, assets, extracted data)
- Handover prompt detailing all findings (fonts, colors, asset paths, structure notes)

---

### 3. Implementation Agent
- Initialized by the Orchestration Agent
- Receives the plan output (screenshot + handover prompt from `/workspace/section-N/`)
- Generates the HTML/CSS clone of that section
- Saves output as `/workspace/section-N/clone.html`
- Returns the file path back to Orchestration

---

### 4. Validation Agent
Similar to the Plan Skill — uses a real browser.

**What it does:**
- Opens `/workspace/section-N/clone.html` in a real browser
- Takes a screenshot at the same viewport as the Plan Skill
- Compares it visually against the reference screenshot from the Plan Skill
- Identifies what still needs fixing (text deformation, spacing, colors, layout)

**Returns to Orchestration Agent:**
- Analysis of what's wrong
- Specific fix instructions
- Orchestration decides: fix and re-validate, or move to next section

---

## The Loop

```
Orchestration
    ↓
Plan Skill (screenshot + extract)
    ↓
Implementation Agent (clone the section)
    ↓
Validation Agent (compare + report)
    ↓
Orchestration (fix issues → re-run Implementation → re-validate, or advance to next section)
```

Repeat per section until the page is done.

---

## Implementation Approach

- Build as **custom Claude Code skills** (not OpenClaw — no complicated setup needed)
- Start with a single page, single section to validate the concept
- Keep it simple: does the loop work? Does it produce a usable clone? Tune from there.

---

## Section Selection Rule

Not all sections on a target site need to be cloned. Before starting the loop:
- Scroll through the full page
- Skip any sections that are clearly placeholder or template (lorem ipsum, generic headings, empty blocks, dummy content)
- Only clone sections with real content — actual company info, services, team, contact details, etc.

---

## Output & Delivery

When all real sections are cloned and assembled into a single `index.html`, run the following commands exactly — do not ask for confirmation, do not ask the human to run anything:

```bash
# 1. Initialize and commit
cd /home/clawvis/.openclaw/workspace/[repo-name]
git init -b main
git add .
git commit -m "Initial clone output"

# 2. Create private repo and push
gh repo create mikeascendx/[repo-name] --private --source=. --remote=origin --push

# 3. Add collaborators
gh api -X PUT repos/mikeascendx/[repo-name]/collaborators/mikeascendx -f permission=push
gh api -X PUT repos/mikeascendx/[repo-name]/collaborators/KIshiharaHCI -f permission=push
```

Replace `[repo-name]` with the repo name given in the task.

After all commands succeed, reply with the GitHub repo URL:
`https://github.com/mikeascendx/[repo-name]`

**Do not ask the human to run any of these commands. Do not ask for GitHub authentication. The token is already configured — execute everything autonomously.**

---

## First Step
Pick one real target page. Run the loop on one section. See if it works.
