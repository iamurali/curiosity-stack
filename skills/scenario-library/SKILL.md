---
name: scenario-library
description: >
  Activate when user says "I don't know what to research", "give me ideas",
  "what can I decompose", "show me scenarios", "browse topics", "not sure where
  to start", "what topics are available", or runs /curiosity-stack:scenarios.
  Also activate on first session if local.md session_count is 0 or empty —
  surface the library automatically after the welcome message.
  Never activate mid-decomposition.
---

# Scenario Library

## Purpose

A curated library of 18 pre-built decomposition starting points organised into
6 categories. Removes the blank-slate problem for new users. Each scenario is
a launchpad — not just an example — that pre-fills the topic and starts the
decomposition automatically when selected.

---

## Display

Generate an interactive HTML artifact using the design system below.
This is the full scenario library interface.

**Design system:**
- Background: `#fafaf8`
- Text: `#2c2c2c` primary, `#6b6558` secondary
- Accent: `#1b5e52` (teal)
- Borders: `0.5px solid #e0ddd6`
- Border radius: 12px cards, 8px chips
- Font: system-ui
- Attribution badge top: `⬡ Curiosity Stack · Scenario Library · v3.2.1`

**Layout:**
- Search bar at top
- Category tabs: All / India Themes / Geopolitics / Global Trends / AI / Cybersecurity / Energy & Climate
- When AI tab is active — show sub-filter: All AI / Global AI / AI — India
- Card grid: `repeat(auto-fill, minmax(210px, 1fr))`
- Preview panel below grid when card is selected

**Each card shows:**
- Category dot + label (color-coded)
- Topic title (13px, font-weight 500)
- 2-line description (12px, muted)
- Estimated session time
- "Preview →" button

**Preview panel shows:**
- Category label
- Topic title
- Full description + "The plugin walks you through all 6 layers — one question at a time."
- 7 layer chips — each showing layer label + what it reveals for this specific topic
- "Start decomposition ↗" button
- "Cancel" button
- Estimated time

---

## On "Start decomposition" click

Pass the topic directly to the curiosity-framework skill:

```
Help me understand the value chain for: [scenario title]
```

The curiosity-framework skill picks this up automatically and begins at Layer 0.
Do not show any intermediate message — go straight into the decomposition.

---

## Categories and Scenarios

### 🇮🇳 India Themes
Color: `#1b5e52`

1. **Semiconductor packaging in India** (8 min)
   Where does India sit in the global OSAT value chain and what are the build requirements?
   L0: TSMC dependency signal | L1: What OSAT actually does | L2: Geopolitical root causes | L3: India fab solution space | L4: Capital, talent, land needs | L5: India players + global comps | L6: Listed vs pre-IPO access

2. **India defence manufacturing** (9 min)
   Post-PLI, what is India actually building and who sits in the supply chain?
   L0: Indigenisation push | L1: What gets made locally | L2: Import dependency causes | L3: Solution categories by segment | L4: Tech + capital requirements | L5: HAL, BEL, private OEMs | L6: Listed vs defence funds

3. **India GCC opportunity** (8 min)
   Global Capability Centres expanding in India — where is value actually accumulating?
   L0: MNC investment surge | L1: What GCCs actually do | L2: Why India wins this | L3: Service + infra industries | L4: Talent, RE, connectivity | L5: Service cos, RE players | L6: How to access this theme

4. **Pharma API supply chain** (8 min)
   India is the pharmacy of the world. What does the value chain actually look like?
   L0: API dependency headlines | L1: What APIs are and who needs them | L2: China concentration root cause | L3: API + CDMO solution space | L4: Chemistry, regulatory, capex | L5: Divi's, Laurus, Aurobindo | L6: Listed plays + CDMO funds

---

### 🌍 Geopolitics
Color: `#993c1d`

5. **Middle East conflict → oil supply** (9 min)
   How does escalation travel through the global oil value chain to Indian businesses?
   L0: Strait of Hormuz signal | L1: Oil flow mechanics | L2: Supply route dependency causes | L3: Substitute energy industries | L4: Refining, logistics, storage | L5: Refiners, shippers, downstream | L6: How to track and access

6. **Russia-Ukraine → energy transition** (9 min)
   How did the war permanently accelerate the European energy transition and what does India gain?
   L0: Gas dependency exposed | L1: European energy mechanics | L2: Structural shift to renewables | L3: Renewable component industries | L4: Panels, inverters, storage | L5: Indian component exporters | L6: Export-linked listed plays

7. **US-China tariffs → supply chain** (10 min)
   Where are supply chains actually moving and which Indian sectors are direct beneficiaries?
   L0: Tariff escalation signal | L1: China+1 mechanics | L2: Why companies are moving | L3: Electronics, textiles, chemicals | L4: Factory, labour, infra needs | L5: Indian beneficiaries by sector | L6: PLI plays, ETFs, themes

8. **Taiwan risk → semiconductor chain** (9 min)
   What happens to the global semiconductor supply chain if Taiwan becomes inaccessible?
   L0: TSMC concentration risk | L1: Semiconductor flow mechanics | L2: Why concentration happened | L3: Diversification industries | L4: Fab capex, talent, IP | L5: Intel, Samsung, India ISMC | L6: How to access resilience plays

---

### 🌐 Global Trends
Color: `#185fa5`

9. **Space economy infrastructure** (9 min)
   Beyond the headlines — what is the actual value chain being built in the commercial space economy?
   L0: Launch cost collapse signal | L1: Space economy segments | L2: Why now — cost + regulation | L3: Launch, satellite, ground infra | L4: Propulsion, components, data | L5: SpaceX, Planet Labs, India plays | L6: Listed vs private access

10. **Precision medicine data layer** (9 min)
    Genomics and AI are converging. What is the data infrastructure value chain underneath this?
    L0: Personalised medicine signal | L1: How precision medicine works | L2: Data and compute root causes | L3: Genomics, data, AI platform sectors | L4: Sequencing, storage, compute | L5: Illumina, NVIDIA, India biotech | L6: Research + listed access

---

### 🤖 AI — Global
Color: `#533ab7`

11. **AI inference demand** (8 min)
    Training is won. Inference is the next battleground. Who sits at each layer of this chain?
    L0: Inference cost bottleneck | L1: What inference actually is | L2: Why demand is compounding | L3: Chip, cloud, model industries | L4: Compute, memory, power, cooling | L5: Nvidia, AMD, cloud providers | L6: Listed vs private access

12. **AI data centre infrastructure** (9 min)
    Every AI model needs a data centre. What is the full build requirement value chain?
    L0: Hyperscaler capex surge | L1: What a data centre requires | L2: Why demand is structural | L3: Power, cooling, construction sectors | L4: Land, energy, water, fibre | L5: Power cos, cooling, REITs | L6: Listed infra plays + REITs

---

### 🤖 AI — India
Color: `#7c3aed`

13. **Indian IT services in the AI era** (10 min)
    AI is automating the work Indian IT services companies sell. What does the value chain impact look like?
    L0: Services automation signal | L1: What IT services actually do | L2: Why LLMs threaten the model | L3: AI-augmented service industries | L4: Talent, IP, client relationships | L5: TCS, Infosys, new entrants | L6: Listed IT vs new-age tech

14. **India AI data annotation layer** (8 min)
    AI models need training data. India has the talent. What is the actual business opportunity here?
    L0: Data labelling demand signal | L1: How annotation works | L2: Why India is positioned | L3: Annotation, eval, fine-tuning sectors | L4: Talent, tools, quality control | L5: Scale AI equivalents, India plays | L6: Mostly private, pre-IPO stage

---

### 🔒 Cybersecurity
Color: `#3b6d11`

15. **Enterprise cybersecurity demand** (9 min)
    Every breach, every regulation, every AI system creates more demand. Map the full value chain.
    L0: Attack surface expansion signal | L1: What enterprise cyber covers | L2: Regulatory + threat root causes | L3: Endpoint, identity, cloud security | L4: Talent, data, AI models | L5: CrowdStrike, Palo Alto, India plays | L6: Listed cos + cyber ETFs

16. **OT security in critical infrastructure** (9 min)
    Operational technology is being connected to the internet. What is the security value chain?
    L0: ICS/SCADA breach signal | L1: What OT security covers | L2: IT-OT convergence root cause | L3: OT-specific security industries | L4: Sensors, protocols, monitoring | L5: Claroty, Dragos, India plays | L6: Mostly US-listed, few India plays

---

### ⚡ Energy & Climate
Color: `#854f0b`

17. **Grid-scale battery storage** (9 min)
    The world needs to store renewable energy at scale. Who builds what in this value chain?
    L0: Intermittency problem signal | L1: How grid storage works | L2: Renewable penetration root cause | L3: Chemistry, integration, software sectors | L4: Lithium, manganese, BMS, grid | L5: CATL, Fluence, India plays | L6: Listed vs project finance

18. **Green hydrogen economy** (9 min)
    Everyone is announcing green hydrogen. What is actually being built and where in the chain?
    L0: Net zero commitment signal | L1: What green hydrogen is | L2: Hard-to-abate sectors root cause | L3: Electrolyser, storage, offtake sectors | L4: Electrolyser capex, water, renewable power | L5: ITM, Nel, NTPC green H2 | L6: Early stage — mostly project finance

---

## After a scenario is selected and decomposition completes

Apply all normal post-output flows from output-generator skill:
- Feedback prompt
- Shareable card
- Save to library
- session_count increment
