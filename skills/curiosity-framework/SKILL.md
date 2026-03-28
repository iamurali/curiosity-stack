---
name: curiosity-framework
description: >
  The core 6-layer decomposition framework. Activates when a user
  describes any topic, technology, market signal, or global event.
  Also activates when a scenario card is clicked via sendPrompt,
  or when /curiosity-stack:decompose is run. Guides the user through
  L0 to L6 using Socratic conversation — one layer at a time.
triggers:
  - describe any topic or signal
  - start a decomposition
  - /curiosity-stack:decompose
---

# Curiosity Framework — Core Decomposition Skill

## CRITICAL — Artifact format rule

NEVER wrap output in <!DOCTYPE html>, <html>, <head>, or <body> tags.
Cowork artifacts are HTML FRAGMENTS only — not full documents.
Starting an artifact with <!DOCTYPE html> causes raw code to display
instead of rendering. Always start directly with <style> or <div>.

Wrong:  <!DOCTYPE html><html><head>...
Correct: <style>...</style><div>...

## The six layers

| Layer | Label | Question |
|---|---|---|
| L0 | Signal | What is happening and why now? |
| L1 | Mechanics | What is this really at a technical level? |
| L2 | Cause Tree | What are the root causes — structural vs cyclical? |
| L3 | Solution Space | What industries does each cause create? |
| L4 | Build Requirements | What inputs and infrastructure does each solution require? |
| L5 | Value Chain Actors | Who does this work — globally and in India? |
| L6 | Research Landscape | How is this space typically accessed by investors? |

---

## Conversation mode — text only until L6

CRITICAL TOKEN RULE: Do NOT generate any HTML artifact during the
decomposition conversation. Every layer (L0 through L6) is delivered
as plain text in chat. No artifacts, no HTML, no CSS during the flow.

The artifact is generated ONCE — only after L6 is complete and the
user asks for it. This saves 60-70% of output tokens.

### How each layer is delivered — plain text format

Each layer response in chat follows this structure:

```
**L[N] · [LAYER NAME]**

[2-3 sentence answer for this topic — substantive, specific]

→ [Key insight 1]
→ [Key insight 2]
→ [Key insight 3 — always include a non-obvious point]

*[L N of 6 — visual artifact generates at the end]*
```

The italic progress line at the bottom is mandatory on every layer.
It reminds the user the visual is coming and keeps them in the flow.

### L5 — mandatory India Proxy Agent offer

After delivering L5 plain text, ALWAYS show this exact prompt:

```
Want me to find the Indian companies at each layer of this chain?
I can run the India Proxy Agent now — it searches NASSCOM, DPIIT,
analyst reports, and VC portfolios to surface listed, SME-listed,
and private players you won't find in a Google search.

Just say "find India proxies" or "yes" and I'll run it.
Or say "continue" to move to L6.
```

CRITICAL ROUTING RULE — when user says "yes", "find India proxies",
"yes find them", or any affirmative to the above prompt:
→ Activate the India Proxy Agent immediately
→ Do NOT generate company cards yourself
→ Do NOT list companies in plain text
→ The India Proxy Agent is the ONLY thing that surfaces Indian companies
→ It will generate its own structured table artifact with domain knowledge form

Never generate your own list of Indian companies at any layer.
If the user asks about Indian companies at any point, always route
to the India Proxy Agent — never answer it yourself.

### Socratic transition

After each layer's plain text response (except L5 which has its own
prompt above), ask ONE focused question to move to the next layer.
Keep it short and conversational.
One question only. Wait for user response before continuing.

### After L6 — action menu in chat

After L6 plain text response, show this in chat (not as artifact):

```
Decomposition complete — [TOPIC] across all 6 layers.

What would you like to do?

→ **Generate visual artifact** — full 6-layer document with
  stat cards, cause trees, value chain table (burns more tokens)
→ **Find India proxies** — run India Proxy Agent at L5
→ **Add to watchlist** — monitor this topic weekly
→ **Stress test** — challenge the core assumptions
→ **Save to library** — store this decomposition
→ **Start a new topic**
```

Wait for user choice. Do not auto-trigger anything.

### When user says "generate" / "generate visual" / "yes generate"

Only NOW generate the full HTML artifact with all 6 layers.
Use the CSS and layer card templates below.
This is the only time any artifact is generated in the decomposition flow.

The artifact is an HTML FRAGMENT — start with <style>, never with DOCTYPE.

```html
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    font-family: 'Georgia', 'Times New Roman', serif;
    background: #fafaf8;
    color: #2c2c2c;
    max-width: 860px;
    margin: 0 auto;
    padding: 24px 20px 60px;
  }

  /* ── HEADER ── */
  .doc-header {
    border-bottom: 2px solid #1b5e52;
    padding-bottom: 16px;
    margin-bottom: 28px;
  }
  .doc-eyebrow {
    font-family: 'Courier New', monospace;
    font-size: 10px;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    color: #1b5e52;
    margin-bottom: 6px;
  }
  .doc-title {
    font-size: 26px;
    font-weight: 700;
    color: #1a1a1a;
    line-height: 1.2;
    margin-bottom: 4px;
  }
  .doc-sub { font-size: 13px; color: #6b6b6b; }

  /* ── PROGRESS BAR ── */
  .progress-wrap { display: flex; gap: 4px; margin-bottom: 32px; align-items: center; }
  .progress-step { flex: 1; height: 4px; background: #e0ddd6; border-radius: 2px; }
  .progress-step.done { background: #1b5e52; }
  .progress-step.active { background: #2d8c72; }
  .progress-label { display: flex; justify-content: space-between; margin-bottom: 6px; }
  .progress-label span { font-family: 'Courier New', monospace; font-size: 9px; letter-spacing: 0.08em; color: #9a9690; text-transform: uppercase; }
  .progress-label span.done { color: #1b5e52; font-weight: 700; }
  .progress-label span.active { color: #2d8c72; font-weight: 700; }

  /* ── LAYER CARD ── */
  .layer-card { margin-bottom: 28px; border: 1px solid #e0ddd6; border-radius: 10px; overflow: hidden; background: white; }
  .layer-header { display: flex; align-items: center; justify-content: space-between; padding: 12px 18px; background: #1b5e52; }
  .layer-label { font-family: 'Courier New', monospace; font-size: 10px; letter-spacing: 0.12em; text-transform: uppercase; color: rgba(255,255,255,0.7); }
  .layer-name { font-size: 12px; font-weight: 700; color: white; letter-spacing: 0.06em; text-transform: uppercase; }
  .layer-body { padding: 20px 22px; }
  .layer-body p { font-size: 14px; line-height: 1.75; color: #2c2c2c; margin-bottom: 14px; }
  .layer-body p:last-child { margin-bottom: 0; }

  /* ── STATS ROW ── */
  .stats-row { display: grid; grid-template-columns: repeat(auto-fit, minmax(140px, 1fr)); gap: 10px; margin: 16px 0; }
  .stat-card { background: #fafaf8; border: 1px solid #e0ddd6; border-radius: 8px; padding: 12px 14px; text-align: center; }
  .stat-number { font-size: 22px; font-weight: 700; color: #1b5e52; line-height: 1; margin-bottom: 4px; }
  .stat-label { font-size: 11px; color: #7a7770; line-height: 1.3; }

  /* ── BULLET LIST ── */
  .insight-list { list-style: none; margin: 14px 0; }
  .insight-list li { display: flex; gap: 10px; align-items: flex-start; font-size: 13.5px; line-height: 1.65; color: #2c2c2c; margin-bottom: 8px; padding-bottom: 8px; border-bottom: 1px solid #f0ede8; }
  .insight-list li:last-child { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }
  .insight-list li::before { content: '→'; color: #1b5e52; font-weight: 700; flex-shrink: 0; margin-top: 1px; }

  /* ── KEY INSIGHT CALLOUT ── */
  .insight-callout { background: #f0f7f4; border-left: 3px solid #1b5e52; border-radius: 0 6px 6px 0; padding: 12px 16px; margin: 16px 0; font-size: 13px; line-height: 1.65; color: #2c2c2c; font-style: italic; }
  .insight-callout strong { font-style: normal; color: #1b5e52; }

  /* ── CAUSE TREE (L2) ── */
  .cause-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin: 14px 0; }
  .cause-card { background: #fafaf8; border: 1px solid #e0ddd6; border-radius: 8px; padding: 12px 14px; }
  .cause-type { font-family: 'Courier New', monospace; font-size: 9px; letter-spacing: 0.1em; text-transform: uppercase; color: #1b5e52; margin-bottom: 5px; }
  .cause-label { font-size: 13px; font-weight: 600; color: #2c2c2c; margin-bottom: 4px; }
  .cause-desc { font-size: 12px; color: #7a7770; line-height: 1.5; }

  /* ── VALUE CHAIN TABLE (L5) ── */
  .vc-table { width: 100%; border-collapse: collapse; margin: 14px 0; font-size: 12.5px; }
  .vc-table th { background: #f0f7f4; padding: 8px 12px; text-align: left; font-family: 'Courier New', monospace; font-size: 9px; letter-spacing: 0.1em; text-transform: uppercase; color: #1b5e52; border-bottom: 2px solid #1b5e52; }
  .vc-table td { padding: 10px 12px; border-bottom: 1px solid #f0ede8; vertical-align: top; line-height: 1.5; }
  .vc-table tr:last-child td { border-bottom: none; }
  .seg-tag { display: inline-block; background: #e8f3f0; color: #1b5e52; font-size: 10px; font-weight: 700; padding: 2px 7px; border-radius: 20px; margin-bottom: 4px; }

  /* ── COMPANY PILLS ── */
  .company-pill { display: inline-flex; align-items: center; font-size: 11px; font-weight: 500; padding: 2px 8px; border-radius: 20px; margin: 2px; white-space: nowrap; }
  .pill-global { background: #e6f1fb; color: #0c447c; border: 0.5px solid #85b7eb; }
  .pill-listed { background: #eaf3de; color: #27500a; border: 0.5px solid #97c459; }
  .pill-private { background: #faeeda; color: #633806; border: 0.5px solid #ef9f27; }
  .sme-badge { font-size: 8px; font-weight: 700; background: #c0dd97; color: #27500a; padding: 1px 3px; border-radius: 2px; margin-left: 3px; }

  /* ── SEBI DISCLAIMER (inline) ── */
  .sebi-inline { background: #fff8f0; border: 1px solid #f0d090; border-radius: 6px; padding: 8px 14px; margin: 14px 0; font-size: 11px; color: #5a3a00; font-style: italic; line-height: 1.5; }

  /* ── FOOTER ── */
  .doc-footer { margin-top: 40px; padding-top: 16px; border-top: 1px solid #e0ddd6; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 8px; }
  .doc-footer-left { font-size: 11px; color: #9a9690; font-family: 'Courier New', monospace; letter-spacing: 0.04em; }
  .doc-footer-right a { font-size: 11px; font-weight: 700; color: #1b5e52; text-decoration: none; letter-spacing: 0.04em; }

  /* ── TEXT SIZE TOGGLE ── */
  .size-toggle { position: sticky; top: 0; background: #fafaf8; border-bottom: 1px solid #e0ddd6; padding: 8px 20px; display: flex; justify-content: flex-end; gap: 6px; z-index: 10; margin: -24px -20px 24px; }
  .size-btn { font-size: 11px; padding: 3px 10px; border: 1px solid #e0ddd6; border-radius: 4px; background: white; cursor: pointer; color: #6b6b6b; }
  .size-btn.active { background: #1b5e52; color: white; border-color: #1b5e52; }
</style>

<div id="cs-wrap" style="font-size:14px">

<div class="size-toggle">
  <button class="size-btn active" onclick="setSize(14,this)">A</button>
  <button class="size-btn" onclick="setSize(16,this)">A+</button>
  <button class="size-btn" onclick="setSize(18,this)">A++</button>
</div>

<div class="doc-header">
  <div class="doc-eyebrow">⬡ Curiosity Stack · [CATEGORY] · Decomposition</div>
  <div class="doc-title">[TOPIC NAME]</div>
  <div class="doc-sub">Layer-by-layer value chain analysis · [DATE]</div>
</div>

<div class="progress-label">
  <span class="[L0_STATE]">L0 Signal</span>
  <span class="[L1_STATE]">L1 Mechanics</span>
  <span class="[L2_STATE]">L2 Causes</span>
  <span class="[L3_STATE]">L3 Solutions</span>
  <span class="[L4_STATE]">L4 Build</span>
  <span class="[L5_STATE]">L5 Actors</span>
  <span class="[L6_STATE]">L6 Research</span>
</div>
<div class="progress-wrap">
  <div class="progress-step [L0_BAR]"></div>
  <div class="progress-step [L1_BAR]"></div>
  <div class="progress-step [L2_BAR]"></div>
  <div class="progress-step [L3_BAR]"></div>
  <div class="progress-step [L4_BAR]"></div>
  <div class="progress-step [L5_BAR]"></div>
  <div class="progress-step [L6_BAR]"></div>
</div>

<!-- LAYERS RENDER HERE — each appended below the previous -->

[LAYER_CARDS]

<div class="doc-footer">
  <div class="doc-footer-left">
    Not SEBI registered · Not investment advice · For research purposes only
  </div>
  <div class="doc-footer-right">
    <a href="https://curiositystack.app" target="_blank">⬡ curiositystack.app</a>
  </div>
</div>

<script>
function setSize(px, btn) {
  // Target wrapper div since artifacts are fragments, not full documents
  const wrapper = document.getElementById('cs-wrap');
  if (wrapper) wrapper.style.fontSize = px + 'px';
  else if (document.body) document.body.style.fontSize = px + 'px';
  document.querySelectorAll('.size-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
}
</script>

</div>
```

---

## Layer card templates

### L0 — Signal card

```html
<div class="layer-card">
  <div class="layer-header">
    <span class="layer-label">L0</span>
    <span class="layer-name">Signal — What is happening and why now?</span>
  </div>
  <div class="layer-body">
    <p>[2-3 sentence answer explaining the signal and why it matters now]</p>
    <div class="stats-row">
      <div class="stat-card">
        <div class="stat-number">[KEY NUMBER]</div>
        <div class="stat-label">[What this measures]<br>[Source, Year]</div>
      </div>
      <div class="stat-card">
        <div class="stat-number">[KEY NUMBER]</div>
        <div class="stat-label">[What this measures]<br>[Source, Year]</div>
      </div>
      <div class="stat-card">
        <div class="stat-number">[KEY NUMBER]</div>
        <div class="stat-label">[What this measures]<br>[Source, Year]</div>
      </div>
      <div class="stat-card">
        <div class="stat-number">[KEY NUMBER]</div>
        <div class="stat-label">[What this measures]<br>[Source, Year]</div>
      </div>
    </div>
    <ul class="insight-list">
      <li><strong>[Driver 1].</strong> [1-2 sentence explanation]</li>
      <li><strong>[Driver 2].</strong> [1-2 sentence explanation]</li>
      <li><strong>[Driver 3].</strong> [1-2 sentence explanation]</li>
    </ul>
    <div class="insight-callout">
      <strong>Non-obvious insight:</strong> [The thing most people miss about this signal]
    </div>
  </div>
</div>
```

### L1 — Mechanics card

```html
<div class="layer-card">
  <div class="layer-header">
    <span class="layer-label">L1</span>
    <span class="layer-name">Mechanics — What is this really?</span>
  </div>
  <div class="layer-body">
    <p>[Clear technical explanation — what this actually is, not the headline version]</p>
    <ul class="insight-list">
      <li>[Mechanism 1 — how it works technically]</li>
      <li>[Mechanism 2 — key distinction from common perception]</li>
      <li>[Mechanism 3 — what this means for the value chain]</li>
    </ul>
    <div class="insight-callout">
      <strong>The critical distinction:</strong> [What separates deep understanding from surface-level]
    </div>
  </div>
</div>
```

### L2 — Cause Tree card

```html
<div class="layer-card">
  <div class="layer-header">
    <span class="layer-label">L2</span>
    <span class="layer-name">Cause Tree — Root causes</span>
  </div>
  <div class="layer-body">
    <p>[1-2 sentences framing structural vs cyclical split]</p>
    <div class="cause-grid">
      <div class="cause-card">
        <div class="cause-type">Structural — permanent</div>
        <div class="cause-label">[Cause name]</div>
        <div class="cause-desc">[Why this is structural, not temporary]</div>
      </div>
      <div class="cause-card">
        <div class="cause-type">Structural — permanent</div>
        <div class="cause-label">[Cause name]</div>
        <div class="cause-desc">[Explanation]</div>
      </div>
      <div class="cause-card">
        <div class="cause-type">Cyclical — timing-dependent</div>
        <div class="cause-label">[Cause name]</div>
        <div class="cause-desc">[Why this is cyclical]</div>
      </div>
      <div class="cause-card">
        <div class="cause-type">Cyclical — timing-dependent</div>
        <div class="cause-label">[Cause name]</div>
        <div class="cause-desc">[Explanation]</div>
      </div>
    </div>
  </div>
</div>
```

### L3 — Solution Space card

```html
<div class="layer-card">
  <div class="layer-header">
    <span class="layer-label">L3</span>
    <span class="layer-name">Solution Space — What industries does this create?</span>
  </div>
  <div class="layer-body">
    <p>[Frame how each cause maps to a solution category / industry]</p>
    <ul class="insight-list">
      <li><strong>[Solution category 1]</strong> — [what this industry does and why this cause needs it]</li>
      <li><strong>[Solution category 2]</strong> — [explanation]</li>
      <li><strong>[Solution category 3]</strong> — [explanation]</li>
      <li><strong>[Solution category 4]</strong> — [explanation]</li>
    </ul>
  </div>
</div>
```

### L4 — Build Requirements card

```html
<div class="layer-card">
  <div class="layer-header">
    <span class="layer-label">L4</span>
    <span class="layer-name">Build Requirements — What does this need?</span>
  </div>
  <div class="layer-body">
    <p>[Frame the key inputs, infrastructure, and talent required]</p>
    <div class="cause-grid">
      <div class="cause-card">
        <div class="cause-type">Hardware / Infrastructure</div>
        <div class="cause-label">[Requirement]</div>
        <div class="cause-desc">[Why needed, who supplies it]</div>
      </div>
      <div class="cause-card">
        <div class="cause-type">Software / Data</div>
        <div class="cause-label">[Requirement]</div>
        <div class="cause-desc">[Explanation]</div>
      </div>
      <div class="cause-card">
        <div class="cause-type">Talent / Skills</div>
        <div class="cause-label">[Requirement]</div>
        <div class="cause-desc">[Explanation]</div>
      </div>
      <div class="cause-card">
        <div class="cause-type">Regulatory / Policy</div>
        <div class="cause-label">[Requirement]</div>
        <div class="cause-desc">[Explanation]</div>
      </div>
    </div>
    <div class="insight-callout">
      <strong>The bottleneck:</strong> [The one build requirement that is hardest to satisfy and why]
    </div>
  </div>
</div>
```

### L5 — Value Chain Actors card

```html
<div class="layer-card">
  <div class="layer-header">
    <span class="layer-label">L5</span>
    <span class="layer-name">Value Chain Actors — Who operates at each layer?</span>
  </div>
  <div class="layer-body">
    <p>[1-2 sentences framing the competitive landscape]</p>
    <div class="sebi-inline">
      ⚠ All companies listed are analytical actors in this value chain —
      for research framing only. Not a recommendation to buy, sell, or
      hold any security. Consult a SEBI registered investment advisor.
    </div>
    <table class="vc-table">
      <tr>
        <th style="width:140px">Sub-segment</th>
        <th>Global players</th>
        <th>India angle</th>
      </tr>
      <tr>
        <td>
          <span class="seg-tag">[Sub-segment]</span>
          <div style="font-size:11px;color:#7a7770;margin-top:3px">[context]</div>
        </td>
        <td>
          <span class="company-pill pill-global">[Company]</span>
          <span class="company-pill pill-global">[Company]</span>
          <div style="font-size:11px;color:#7a7770;margin-top:4px">[context note]</div>
        </td>
        <td>
          <span class="company-pill pill-listed">[Company]</span>
          <span class="company-pill pill-private">[Company]</span>
          <div style="font-size:11px;color:#7a7770;margin-top:4px">[context note]</div>
        </td>
      </tr>
    </table>
  </div>
</div>
```

### L6 — Research Landscape card

```html
<div class="layer-card">
  <div class="layer-header">
    <span class="layer-label">L6</span>
    <span class="layer-name">Research Landscape — How is this space accessed?</span>
  </div>
  <div class="layer-body">
    <p>[Frame how investors / researchers typically access this theme]</p>
    <ul class="insight-list">
      <li><strong>[Access route 1]</strong> — [description, examples]</li>
      <li><strong>[Access route 2]</strong> — [description, examples]</li>
      <li><strong>[Access route 3]</strong> — [description, examples]</li>
    </ul>
    <div class="insight-callout">
      <strong>Where the edge is:</strong> [The non-obvious access route or the layer most investors miss]
    </div>
  </div>
</div>
```

---

## Colour rule — absolute

Layer card header background is ALWAYS #1b5e52.
Never use any other colour for .layer-header — not blue, not grey,
not the scenario category colour. Always #1b5e52.

---

## Stat numbers — sourcing rules

Every number in a stat card must have a source label below it.
Format: `[Source family], [Year]`
Never fabricate a number. Never show a number without a source label.

---

## Socratic transition after each layer

After each plain text layer response, ask ONE focused question to
move to the next layer. Keep it short and conversational.
Only one question. Never ask multiple questions.
Wait for user response before continuing to next layer.

Example transitions:
- After L0: "What do you think is actually driving this — structural shift or a cycle?"
- After L1: "Given how this works, where do you think the real bottleneck sits?"
- After L2: "Which of these causes feels most permanent to you?"
- After L3: "Which solution category has the clearest business model?"
- After L4: "Which build requirement do you think India is best positioned to supply?"
- After L5: "How do you think most investors are currently positioned on this theme?"

Never ask two questions. Never explain what the next layer will cover.

---

## After L6 — action menu

After L6 plain text response, show this menu in chat:

```
Decomposition complete — [TOPIC] across all 6 layers.

What would you like to do?

→ Generate visual artifact (full 6-layer document — burns more tokens)
→ Find India proxies (India Proxy Agent)
→ Add to watchlist
→ Stress test this thesis
→ Save to decomposition library
→ Start a new topic
```

Do not auto-trigger anything. Wait for user choice.

When user chooses "Generate visual artifact" — generate the full
HTML artifact using the CSS and layer card templates in this skill.
Include all 6 layers in one document.

---

## Tone

- Socratic — ask before telling
- One question at a time, always
- Each layer feels like a discovery, not a lecture
- India angle at L5 is mandatory — never skip it
- Never recommend buying, selling, or holding any security
- Company names at L5 are analytical actors only

---

## SEBI compliance

Apply sebi-compliance skill at all times.
The inline SEBI disclaimer in the L5 card is mandatory.
