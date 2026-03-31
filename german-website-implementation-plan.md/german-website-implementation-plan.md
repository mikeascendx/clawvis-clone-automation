# Detailed Implementation Plan: German SMB Website Cloning & Production

## 1) Strategic Design Direction (German-Trust UI)

German SMB websites convert best when they emphasize:
- clarity over novelty,
- trust over hype,
- structure over artistic chaos,
- practical information over branding theater.

### Core principles
1. **Klarheit** – instantly understandable value proposition.
2. **Seriosität** – visible trust markers early.
3. **Struktur** – predictable hierarchy and clean grids.
4. **Nützlichkeit** – relevant details above decorative content.
5. **Verbindlichkeit** – concrete next steps and real contact data.

---

## 2) Visual System Specification

## 2.1 Grid & Layout
- Desktop container: `1200–1280px`
- Grid: 12 columns desktop / 8 tablet / 4 mobile
- Section spacing rhythm: `48 / 64 / 80px`
- Maintain consistent left alignment for text-heavy sections
- Prefer balanced rectangular compositions

## 2.2 Shape Language (Sharp edges default)
- Buttons: `border-radius: 2–4px` (or `0px` for technical/industrial niches)
- Cards: `4px`
- Inputs: `2–4px`
- Media blocks: mostly square or subtle radius (`0–4px`)

## 2.3 Typography
- Fonts: Inter, Source Sans 3, IBM Plex Sans, Noto Sans
- Base text: `16–18px`
- Headline scale (desktop): `40 / 32 / 24 / 20`
- Line-height: `1.45–1.6`
- Max line length: `65–80ch`
- Strict German grammar/capitalization QA

## 2.4 Color Strategy
- Neutral base + one controlled accent
- High contrast, no trendy neon gradients by default
- Primary CTA color should feel business-safe (deep blue/petrol/dark green/burgundy)
- Keep color complexity low for trust and consistency

## 2.5 Component Behavior
- Buttons: strong rectangular look, precise labels (e.g. „Angebot anfragen“)
- Cards: clean border + minimal shadow
- Inputs/forms: simple, legible, low ornament
- Icons: functional, non-playful in B2B contexts

---

## 3) Information Architecture for German SMB Conversion

## Homepage sequence
1. Hero with concrete promise (what + who + where)
2. Trust strip (years, projects, ratings, response time)
3. Service blocks with defined scope
4. Process section (3–5 steps)
5. References/case snippets/testimonials
6. Pricing logic or entry-level transparency
7. FAQ (timeline, ownership, support, revisions)
8. Final CTA section
9. Full legal footer

## Mandatory legal elements
- Impressum
- Datenschutz
- Cookie settings/consent
- AGB (if used)
- Full contact/company identity

---

## 4) German vs US-Modern Implementation Rules

## Prefer
- concrete statements,
- practical density,
- restrained animation,
- visible evidence (certifications, local references),
- obvious contact options.

## Avoid
- oversized abstract hero with little substance,
- excessive whitespace,
- soft rounded startup aesthetic everywhere,
- buzzword-heavy copy,
- buried legal details.

---

## 5) Copywriting System (DE-first)

Use per section:
1. Problem framing (customer reality)
2. Practical solution (exact deliverables)
3. Proof (numbers/references/region)
4. Action (clear next step)

## CTA bank
- „Kostenlose Erstberatung“
- „Unverbindliches Angebot erhalten“
- „Projekt anfragen“
- „Rückruf innerhalb von 24h“

Tone:
- direct, factual, competent,
- low fluff,
- short, understandable sentences.

---

## 6) Vertical Presets

## Handwerk / Bau / Elektro / Dach
- Boxier, robust visual language
- Certifications + phone prominence
- Fast contact pathways

## Steuerberater / Kanzlei / Beratung
- Conservative blue/neutral palette
- Credential-focused hierarchy
- More text clarity, less visual experimentation

## Beauty / Wellness
- Slightly softer visuals, still structured
- Balanced emotional + practical messaging

## Creative/Fotografie
- Visual-first blocks allowed, but keep practical service clarity and pricing logic

---

## 7) End-to-End Production Workflow

## Phase A — Discovery (30–45 min)
- Gather niche, city, tone, 3–5 competitors, service scope
- Identify trust assets and legal requirements
- Define primary conversion goal (call/form/WhatsApp/booking)

## Phase B — Wireframe
- Desktop-first wireframe for info density
- Mobile adaptation second
- Validate legal and contact locations before final UI

## Phase C — UI Build
- Apply design tokens
- Enforce sharp-edge style consistency
- Align all blocks to grid rules

## Phase D — Copy Integration
- Insert niche-specific German copy
- Replace generic claims with concrete, verifiable details

## Phase E — Compliance + Trust
- Legal pages connected and accessible
- Consent behavior verified
- Footer completeness check

## Phase F — Conversion QA
- CTA visible above fold
- Max 1–2 primary CTA types
- Reduce form friction

---

## 8) Cloning Loop Integration (Implement → Validate → Fix)

For each iteration, compute weighted mismatch score:
- 35% layout/parity
- 25% typography/spacing
- 20% trust/legal completeness
- 20% CTA clarity and conversion path

## Per-iteration checks
1. Radius consistency audit
2. Grid alignment audit
3. Information density audit
4. Trust-signal presence audit
5. Legal block presence audit
6. Mobile parity audit

## Stop criteria
- Pass threshold: mismatch score `<= 10%`
- Max iteration cap per page
- Escalate when stalled for 2 consecutive cycles

## Artifact policy
- Save each iteration to `/artifacts/iter-N/`
- Include screenshots (desktop/mobile), mismatch log, fix notes

---

## 9) QA Checklist (Pre-Delivery)

## Visual
- [ ] Radius and edge style consistent
- [ ] Grid integrity across breakpoints
- [ ] Contrast compliant
- [ ] No random modern-soft styling drift

## Content
- [ ] German spelling and punctuation QA passed
- [ ] Claims specific and realistic
- [ ] Service offer clear in under 20 seconds

## Trust + Legal
- [ ] Contact details visible and complete
- [ ] Business identity clear
- [ ] Impressum + Datenschutz linked
- [ ] Cookie mechanism verified

## Performance
- [ ] Mobile LCP target < 2.5s
- [ ] Images optimized
- [ ] Minimal JS overhead for static content

---

## 10) Reusable Token Baseline

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

## 11) Rollout Plan

## Sprint 1 (Immediate)
- Convert this into template baseline
- Build one “Handwerk” production template
- Run 5 cloning iterations on one real target page

## Sprint 2
- Add Kanzlei/Consulting variant
- Formalize scoring logs + artifacts
- Tune mismatch threshold after empirical data

## Sprint 3
- Expand to multi-page pipeline
- Bundle as repeatable clone package
- Prepare ZIP → GitHub → Vercel delivery path

---

## Success Definition
- Reliable autonomous clone loop with measurable score improvement
- Consistent German-style output (structured, credible, practical)
- Faster throughput with lower manual correction load
- Human intervention only for blocker cases
