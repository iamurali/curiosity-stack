---
name: source-credibility
description: >
  Activate at Layer 1 and Layer 5 of any decomposition to surface
  the user's highest-rated sources for the current sector and layer.
  Activate after any session to prompt source rating.
  Activate when user says "rate this source", "how good is [source]",
  "which sources should I use for [sector]", or "update my sources".
  Never activate mid-conversation unless at L1 or L5 transition.
---

# Source Credibility

## Purpose

A personal source registry that builds over time. Tracks which publications, analysts, and databases the user finds valuable at which layer and sector. Surfaces the right sources at the right moment — before the user goes looking. Ratings are a combination of plugin-suggested (based on usage patterns across the decomposition library) and user-confirmed.

---

## Step 0 — Surface at Layer 1 and Layer 5

**At Layer 1 (Mechanics):**
Check `local.md` sources registry for entries matching:
- Current sector
- Layers: L1 or general

If high-rated sources exist for this sector at L1, surface them:
```
For [sector] mechanics, your top-rated sources are:
→ [Source 1] — [why useful at this layer]
→ [Source 2] — [why useful at this layer]

Want me to prioritise these? (yes / no / skip always)
```

**At Layer 5 (Value Chain Actors):**
Check for sources rated high at L5 for this sector, especially India-specific:
```
For [sector] company research, your top sources are:
→ [Source 1] — [e.g. "strong for India L5, especially funding rounds"]
→ [Source 2] — [e.g. "reliable for global players, less India coverage"]

Prioritise these for Layer 5? (yes / no)
```

---

## Step 1 — Track Sources During Session

Silently note every source cited or used during the decomposition:
- Web search results referenced
- Sources from connected Drive / Notion / Gmail
- Databases queried (Tracxn, Screener, NASSCOM, Inc42)
- Publications mentioned by name

Store temporarily for the post-session rating prompt.

---

## Step 2 — Post-Session Rating

After output is generated and library save prompt is complete, ask:

```
Quick source check — 60 seconds.
Help me learn which sources work best for you.

[Source 1] at [Layer] — useful?
  1. Very useful
  2. Somewhat useful  
  3. Not useful
  4. Skip

[Source 2] at [Layer] — useful?
  [same options]
```

Show maximum 3 sources per session to avoid fatigue. Prioritise sources that haven't been rated yet.

After rating:
```
Saved. I'll prioritise these next time you research [sector].
```

---

## Step 3 — Plugin-Suggested Ratings

After 5+ decompositions in the library, the plugin analyses patterns:

- Sources that appeared at the same layer across 3+ decompositions in the same sector → suggest `high`
- Sources cited once → no suggestion yet
- Sources the user rated `not useful` → flag as `low`, deprioritise

Present suggestions periodically (not every session):
```
Based on your research patterns, I'd suggest rating these:

→ Inc42 for India L5 (Fintech): high — appeared in 6 of your 8 India sessions
→ Tracxn for India L5 (all sectors): high — consistent across 9 sessions
→ [Source] for L1 (EVs): medium — cited twice but you haven't rated it

Confirm these? (yes / edit / skip)
```

---

## Step 4 — Source Registry Format

Stored in `curiosity-stack.local.md` under `sources`:

```yaml
sources:
  - name: Inc42
    type: publication
    sectors:
      - fintech
      - deeptech
      - EVs
      - all-india
    layers:
      - L5
      - L6
    rating: high
    rated_by: user
    times_cited: 12
    notes: "Strong for India funding rounds and new entrants. Weaker on technical depth at L1."
    last_cited: [date]

  - name: Tracxn
    type: database
    sectors:
      - all
    layers:
      - L5
    rating: high
    rated_by: plugin-suggested, user-confirmed
    times_cited: 9
    notes: ""
    last_cited: [date]

  - name: Economic Times
    type: publication
    sectors:
      - all-india
    layers:
      - L0
      - L1
    rating: medium
    rated_by: user
    times_cited: 4
    notes: "Good for signals and headlines, not for deep mechanics."
    last_cited: [date]
```

**Source types:** `publication` / `database` / `analyst` / `newsletter` / `government` / `exchange`

---

## Step 5 — Cross-Decomposition Pattern Surfacing

After 10+ decompositions, activate a periodic meta-insight (once per month maximum):

```
Pattern I've noticed across your research:

3 of your recent decompositions — EV batteries, grid storage,
and solar manufacturing — all converge at the power electronics
layer (L4). The same 2 companies appear across all three.

Want to map this as a cross-cutting theme in your library?
This would let you track that layer as a single watchlist item
rather than separately across three topics.
```

This surfaces non-obvious connections the user might have missed.

---

## local.md additions

```yaml
source_rating_enabled: true / false
source_auto_accept_suggestions: true / false

sources:
  - name: [source name]
    type: publication / database / analyst / newsletter / government / exchange
    sectors: [list]
    layers: [list]
    rating: high / medium / low
    rated_by: user / plugin-suggested / plugin-suggested-user-confirmed
    times_cited: [integer]
    notes: [freetext]
    last_cited: [date]
```
