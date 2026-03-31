# Website Cloning Automation Loop (Clawvis)

## Objective
Automate the **clone phase** end-to-end so human time is focused on redesign and client-facing quality.

---

## Problem to Solve
Current bottleneck is not raw generation speed, but loop reliability:

1. Implement clone step
2. Validate against source
3. Detect mismatch
4. Fix deltas
5. Repeat until quality threshold

Models drift without a strict loop + hard validation gates.

---

## Proposed OpenClaw Loop Architecture

## A) Session Roles
- **Main session (Clawvis):** planning, control, reporting to Kenji/Mike
- **Isolated worker session(s):** implementation + validation cycles for each website

## B) Loop Stages (per target page)
1. **Input capture**
   - Target URL(s), screenshot baseline, viewport spec (desktop/mobile)
2. **Initial implementation**
   - Generate HTML/CSS/JS clone scaffold
3. **Automated validation**
   - Pixel/layout checks (structure + spacing + typography + responsive behavior)
   - DOM/component parity checks where possible
4. **Delta scoring**
   - Assign mismatch score by section (header/hero/cards/footer)
5. **Patch iteration**
   - Apply focused fixes to highest-impact diffs first
6. **Stop criteria**
   - Exit when score is below threshold or max iterations reached
7. **Handoff**
   - Deliver clone package for redesign phase

## C) Guardrails
- Hard cap on iteration count and token budget per page
- Save checkpoints every iteration (`/artifacts/iter-N`)
- If loop stalls for 2 cycles, escalate with concise blocker report

---

## Validation Strategy (Practical)

## Primary checks
- Desktop screenshot diff (full page)
- Mobile screenshot diff
- Key section bounding boxes alignment
- Font-size and spacing drift thresholds

## Secondary checks
- Navigation and CTA positions
- Image sizing/crop parity
- Scroll behavior and breakpoints

## Suggested threshold
- Pass when visual mismatch score <= 10% (tune after first 3 test sites)

---

## Heartbeat Setup (30m)
Heartbeat purpose: continue highest-impact unfinished cloning task autonomously.

## Heartbeat behavior
On each heartbeat:
1. Load active cloning queue
2. Resume the top-priority target
3. Execute **one full implement→validate→fix cycle**
4. Persist iteration result + score
5. If blocked, alert with exact blocker
6. If no actionable work, `HEARTBEAT_OK`

---

## Suggested HEARTBEAT.md

```md
# Cloning Automation Heartbeat

- Continue highest-priority unfinished cloning task.
- Run one cycle: implement -> validate -> fix.
- Save iteration summary with mismatch score.
- If blocked for external reason (auth/captcha/missing assets), alert with blocker + next action.
- If no actionable task exists, reply HEARTBEAT_OK.
```

---

## Tooling Focus
- OpenClaw agent loop as orchestrator
- Browser automation + screenshot capture for validation
- Optional secondary model benchmarking (MiniMax/other) only after baseline loop is stable

---

## Execution Plan (Next)
1. Build minimal pipeline on 1 real target site (single page)
2. Run 5 controlled iterations and log score trend
3. Tune validation thresholds and stop criteria
4. Expand to multi-page templates
5. Productize into repeatable “clone package” output

---

## Success Definition
- Clone phase runs with minimal supervision
- Iteration logs show improving score trend
- Human intervention only for exceptions, not routine corrections
- Throughput increase: more client projects handled in parallel
