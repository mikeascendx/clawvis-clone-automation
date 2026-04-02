# German SMB Website Cloning — Implementation Reference

## Purpose
This document is a reference for the **Implementation Agent** when cloning German SMB websites. It covers the design conventions common to German business sites so the agent produces output that looks correct for this market.

Strategic decisions (niche, tone, competitors, copy) are made by humans before the clone loop starts. This document only covers what the agent needs to know to implement accurately.

---

## Visual Conventions (German SMB)

### Layout
- Desktop container: `1200–1280px`
- Section spacing: `48 / 64 / 80px`
- Prefer clean grids and left-aligned text blocks

### Shape Language
- Buttons: `border-radius: 2–4px` (or `0px` for industrial/technical sites)
- Cards: `4px`
- Inputs: `2–4px`
- Avoid soft rounded startup aesthetics

### Typography
- Common fonts: Inter, Source Sans 3, IBM Plex Sans, Noto Sans
- Base text: `16–18px`
- Headline scale: `40 / 32 / 24 / 20px`
- Line-height: `1.45–1.6`

### Colors
- Neutral base + one accent
- High contrast, no neon gradients
- Business-safe primaries: deep blue, petrol, dark green, burgundy

---

## CSS Token Baseline

```css
:root {
  --r-btn: 3px;
  --r-card: 4px;
  --r-input: 3px;

  --space-1: 8px;
  --space-2: 12px;
  --space-3: 16px;
  --space-4: 24px;
  --space-5: 32px;
  --space-6: 48px;
  --space-7: 64px;

  --border-default: 1px solid #DADDE2;
  --shadow-subtle: 0 2px 8px rgba(0,0,0,.06);

  --btn-height: 46px;
  --input-height: 44px;
}
```

---

## Cloning Loop Integration

With the **Codex webapp + ai-website-cloner-template** approach, the clone skill handles the full pipeline automatically:

1. **Reconnaissance** — Screenshots target at desktop + mobile, extracts fonts/colors/assets via `getComputedStyle()`
2. **Foundation Build** — Sets up fonts, design tokens, TypeScript interfaces, downloads assets
3. **Component Spec & Dispatch** — Writes spec files per section, dispatches parallel builder agents
4. **Page Assembly** — Wires sections into layout, verifies build passes
5. **Visual QA** — Side-by-side screenshot comparison, fixes discrepancies

The German SMB conventions above still apply — the clone skill extracts the target site's actual design values, so these serve as a quality check reference rather than generation input.

**Output format:** Next.js + React + Tailwind (not plain HTML like the legacy Clawvis flow).

---

## Legal Elements (must be present in final output)
- Impressum
- Datenschutz
- Cookie consent
- Full contact/company identity in footer

These are checked during Phase 5 (Visual QA) of the clone skill.
