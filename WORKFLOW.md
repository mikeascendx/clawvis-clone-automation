# Clawvis — Generic Cloning Workflow

How to go from a task from Kenji to a delivered clone via Clawvis.

---

## Step 1 — Receive task from Kenji

Kenji sends you a URL and any notes (e.g. "skip placeholder sections", "only real content").

---

## Step 2 — Send to Clawvis on Telegram

Open the Clawvis Assistant chat and send:

```
Follow instructions: https://raw.githubusercontent.com/mikeascendx/clawvis-clone-automation/main/cloning-loop-plan.md/cloning-loop-plan.md

Target: [URL]
Repo name: [site-name-clone]
```

That's all you need to send. Everything else is handled by the plan doc.

---

## Step 3 — Clawvis runs the loop

Clawvis will automatically:
- Open the target site in a browser
- Identify real content sections (skip placeholders/templates)
- For each section: screenshot → clone → validate → fix (max 3 attempts per section)
- Assemble all sections into a single `index.html`

---

## Step 4 — Clawvis delivers to GitHub

When done, Clawvis will automatically:
- Create a private GitHub repo with the name you provided
- Push all output files
- Add `mikeascendx` and `KIshiharaHCI` as collaborators
- Reply to you with the repo URL

---

## Step 5 — Review

Open the repo link Clawvis sends. You and Kenji can review the clone and leave feedback.

---

## Example — Pala Consulting

**Kenji's task:**
> Clone https://pala-consulting.de/ — skip placeholder/template sections, only real content.

**Message sent to Clawvis:**
```
Follow instructions: https://raw.githubusercontent.com/mikeascendx/clawvis-clone-automation/main/cloning-loop-plan.md/cloning-loop-plan.md

Target: https://pala-consulting.de/
Repo name: pala-consulting-clone
```

---

## Notes

- The plan doc (`cloning-loop-plan.md`) is the brain — update it when the process changes, not every task
- Clawvis already has GitHub token access configured
- If a section is too broken after 3 fix attempts, Clawvis logs it and moves on — review those manually in the final repo
