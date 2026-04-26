# Curiosity Stack

**A structured research thinking tool for enterprise professionals and investors.**

Built by [Ameya Pimpalgaonkar](https://finstor85.substack.com) · [Announcement post](https://finstor85.substack.com/p/claude-plugin)

> *"The intent is not to reach the end of the process but to go through the process itself."*

---

## What This Is

A plugin that decodes any technology or market signal into 2nd and 3rd order business insights — using layer-by-layer question sequencing that takes you from noise to structured understanding.

Not a stock tips tool. Not a recommendation engine. A rigorous thinking partner for people who want to understand deeply before they decide anything.

---

## Install (Claude + Cursor)

### Claude

Use one command to register this repo as a local Claude Code marketplace and install the plugin (skills, agents, commands, hooks):

```bash
./scripts/setup-claude-plugin.sh
```

Then:

1. Restart Claude Code (or reload the project).
2. Start a new chat — the default agent from `settings.json` should load `welcome`.
3. Verify by typing a natural-language intent like: "help me understand AI inference demand."

Optional maintenance commands:

```bash
./scripts/setup-claude-plugin.sh --dry-run    # Preview actions
./scripts/setup-claude-plugin.sh --update     # Refresh after pulling repo changes
./scripts/setup-claude-plugin.sh --uninstall  # Remove plugin and marketplace entry
```

### Cursor

Use one command to install skills globally from this repo's canonical `skills/`:

```bash
./scripts/setup-cursor-skills.sh
```

This syncs `skills/*/SKILL.md` to `~/.cursor/skills/<skill-name>/SKILL.md`.

Then:

1. Restart Cursor (or reload window).
2. Start a fresh chat in the project context.
3. Verify with a natural-language request like: "set me up for India-focused research."

Optional maintenance commands:

```bash
# Preview changes only
./scripts/setup-cursor-skills.sh --dry-run

# Remove stale managed skills not present in this repo
./scripts/setup-cursor-skills.sh --clean
```

### First-run verification checklist

- Plugin loads without manifest errors.
- Welcome guidance appears from the `welcome` agent.
- A plain-language request routes to the right skill without slash commands.
- Cursor skill count should match canonical skills in this repo.
- If routing looks wrong, check repo path, plugin metadata, and reload the workspace.

---

## The Six Layers

| Layer | Question | What You Find |
|-------|----------|---------------|
| L0 | What's the signal? | Why this matters now |
| L1 | What is it really? | Actual mechanics, not headlines |
| L2 | What causes it? | The root cause tree |
| L3 | What fixes it? | Solution categories = industries |
| L4 | What does it require? | Inputs, infrastructure, talent |
| L5 | Who does this work? | Named companies — global + India |
| L6 | Research landscape | How the space is typically accessed |

---

## How It Works — Point A to Point B

**Install** -> Open Cowork/Cursor chat -> Welcome message fires automatically -> Say "set me up" (2 minutes, once) -> Describe any topic in plain language -> Walk 6 layers -> Choose output -> Done.

From the second session onwards: just describe a topic. The plugin reads your saved context silently and begins.

---

## Skill-First Entry (Commands Deprecated)

Use natural language directly. The plugin resolves intent and routes to the right skill automatically.

| Say this naturally | Routed skill |
|---------|-------------|
| "set me up" / "configure my context" | setup |
| "help me understand [topic]" | curiosity-framework |
| "show my watchlist" / "add trigger for [topic]" | watchlist-tracker |
| "open my library" / "compare past decomposition" | decomposition-library |
| "manage my domain knowledge" | domain-knowledge |
| "give me ideas" / "show scenarios" | scenario-library |
| "stress test this thesis" | thesis-stress-test |

---

## After Every Decomposition

You choose your output format — then get:

- **Value Chain diagram** — layered visual map with India 🇮🇳 badges
- **Interactive Mindmap** — radial diagram with expandable nodes and hover cards
- **Research Note** — downloadable `.md` document, professional research brief format
- **Thesis Stress Test** — proponents, critics, core assumption, how wrong this could be
- **5 curated reading recommendations** targeted at the specific topic and layers explored
- Option to save to your connected Drive, Notion, or Airtable

---

## Decomposition Library

Every completed session can be saved locally to the `library/` folder. Optionally mirrored to Google Drive or Notion for backup and cross-device access.

**What's saved:** topic, date, all 6 layer summaries, sources cited, tags (sector, geography, stage), conviction placeholder.

**Retrieval:** when you start a new decomposition, the plugin checks your library for past sessions on the same topic and asks if you want to load it — saving you ground you've already covered.

**Layer delta:** revisit a topic months later and the plugin compares the new decomposition against your saved one — showing exactly what changed at each layer.

---

## Watchlist Tracker + Trigger Alerts

Monitor any topic within its value chain — automatically, on your schedule.

**Tracker mode** — runs on your set cadence (daily / weekly / fortnightly). Covers everything on your watchlist. Maps findings to the value chain layer they affect. Scores materiality HIGH / MEDIUM / LOW with reasoning. Delivers a structured digest to your Gmail automatically, with a Cowork link to go deeper.

**Trigger mode** — set a specific condition per topic per layer:
*"Alert me when something changes at Layer 4 of EV batteries"*
The agent checks that condition each run and fires only when met — flagged as 🚨 in your digest.

Signal types monitored: news, regulatory changes, new entrants, funding rounds.

Configure by saying "manage my watchlist" or during setup.

---

## Source Credibility

A personal source registry that builds over time.

After each session, rate the sources used (30–60 seconds, max 3 per session). Over time the plugin learns which publications, databases, and analysts work best for you by sector and layer.

At Layer 1 and Layer 5 of every decomposition, your top-rated sources are surfaced automatically — so you spend less time searching and more time reading the right things.

After 5+ decompositions, the plugin suggests ratings based on your usage patterns. You confirm or override.

---

## The India Proxy Agent

The India Proxy Agent is a fully autonomous research agent, not a prompt.

You give it a global company or theme. It independently:

1. Researches the actual business model of the global reference point
2. Searches Tracxn, Inc42, Screener.in, NASSCOM, and general web sources
3. Validates each candidate against red flag criteria (AI-washing, segment size, client verifiability)
4. Returns a structured shortlist with proxy pattern, access method, validation signals, and watch triggers

If it finds nothing meaningful, it says so — that is itself a useful research finding.

---

## Connect Your Sources

Works standalone. Significantly better with your notes connected.

Works with all connectors you have enabled in Cowork — Gmail, Google Drive, Slack, Notion, GitHub, and more. Connect your tools in Cowork Settings → Connectors.

Connect by saying "set me up" — no file editing required.

---

## Making It Yours

### Option 1 — Edit `curiosity-stack.local.md` (recommended)

Fill in your context once and the plugin personalises every session without needing setup commands.

```yaml
# Core context
context:        # Investor / Enterprise professional / Both
geography:      # India / Global / Both
themes:         # Topics you are actively researching
watchlist:      # Companies or topics to track
deprioritise:   # Sectors you already know well
default_output: # value-chain / mindmap / research-note
notes:          # Depth vs breadth preference, etc.

# Library
library_save:   # always / ask / never
library_mirror: # drive / notion / local

# Watchlist monitoring
watchlist_cadence:       # daily / weekly / fortnightly
watchlist_email:         # your email address
watchlist_email_enabled: # true / false

# Source credibility
source_rating_enabled:   # true / false
```

### Option 2 — Edit the skills

The skills in `/skills/` are plain Markdown files. Customise:

- **`curiosity-framework/SKILL.md`** — adjust layer definitions, add example decompositions
- **`company-discovery/SKILL.md`** — add India proxy patterns specific to your focus areas
- **`sebi-compliance/SKILL.md`** — adjust disclaimer language for your jurisdiction
- **`source-credibility/SKILL.md`** — add sources you already know are reliable

### Option 3 — Add your own skills

Drop a new folder into `/skills/` with a `SKILL.md` file. Useful for:

- A sector-specific decomposition template
- A custom output format for your note-taking system
- A personal red flag list for company validation

---

## Important Disclaimer

**This plugin is a research and structured thinking tool only.**

I am not a SEBI registered investment advisor. Ameya Pimpalgaonkar is not a SEBI registered investment advisor. Nothing produced by this plugin constitutes investment advice, a recommendation, or a solicitation to buy, sell, or hold any security, fund, or financial instrument.

All outputs are for educational and research purposes only. Always conduct your own due diligence and consult a SEBI registered investment advisor before making any financial decision.

The SEBI disclaimer is enforced on every research output via a hook — it cannot be suppressed.

---

## Plugin Structure

```
curiosity-stack/
├── .claude-plugin/
│   └── plugin.json                   # Plugin manifest v3.1.0

├── settings.json                     # Activates welcome agent on first session
├── agents/
│   ├── welcome.md                    # First-session welcome and orientation
│   ├── india-proxy-agent.md          # Autonomous India proxy research agent
│   └── watchlist-agent.md            # Autonomous watchlist monitoring agent
├── commands/                         # Legacy command aliases (deprecated)
├── scripts/
│   └── setup-cursor-skills.sh        # One-command sync to ~/.cursor/skills
├── hooks/
│   └── hooks.json                    # SEBI disclaimer on every Stop event
├── skills/
│   ├── sebi-compliance/              # Always active — highest priority
│   ├── curiosity-framework/          # Core 6-layer method
│   ├── setup/                        # Onboarding + local.md read/write
│   ├── company-discovery/            # India proxy patterns
│   ├── output-generator/             # Value Chain / Mindmap / Research Note
│   ├── thesis-stress-test/           # Proponents / critics / assumptions
│   ├── reading-list/                 # 5 curated recommendations per session
│   ├── source-guide/                 # Where to look at each layer
│   ├── decomposition-library/        # Save, retrieve, and compare sessions
│   ├── watchlist-tracker/            # Tracker mode + trigger alerts
│   └── source-credibility/           # Personal source registry
├── library/                          # Saved decompositions (local, auto-created)
│   └── README.md
├── curiosity-stack.local.md          # Your personal research context (edit this)
├── CHANGELOG.md
├── LICENSE
└── README.md
```

---

## About

Built by [Ameya Pimpalgaonkar](https://finstor85.substack.com).

- Substack: [finstor85.substack.com](https://finstor85.substack.com) — 2,000+ subscribers
- X: [@Finstor85](https://x.com/Finstor85) — 42K+ followers
- Privacy Policy: [finstor85.substack.com/p/privacy-policy](https://finstor85.substack.com/p/privacy-policy)

---

*MIT License · v3.1.0*

---

## Attribution

Curiosity Stack is MIT licensed — free to fork, modify, and build upon.

**If you fork or build on this plugin, you must:**
1. Keep the `LICENSE` file intact
2. Include a **clickable** credit link on every output: `Built with Curiosity Stack → curiositystack.app`
3. Credit the original in your README (see `ATTRIBUTION.md`)

A non-clickable text mention is not sufficient. See [`ATTRIBUTION.md`](./ATTRIBUTION.md) for full requirements.

**Original framework by Ameya Pimpalgaonkar**
→ [curiositystack.app](https://curiositystack.app) · [@Finstor85](https://x.com/Finstor85) · [GitHub](https://github.com/ameya85/curiosity-stack)

---
