---
name: setup
description: >
  Activate on first use or when user says "setup", "configure", "connect my notes",
  "link my drive", "how do I connect", or on first session with no prior configuration.
  Also reads curiosity-stack.local.md if it exists — skip steps already answered there.
---

# Curiosity Stack: Setup

## Purpose

Conversational onboarding. No file editing, no technical steps. Get the user configured and into their first session as fast as possible.

---

## First — Check for local.md

Before running the setup flow, silently check if `curiosity-stack.local.md` exists in the plugin directory.

If it exists and has content filled in:
- Read the context, geography, themes, watchlist, and notes fields
- Skip any setup steps already answered
- Greet the user with what you found:

```
Welcome back to Curiosity Stack.

I can see your research context is already configured:
Context: [value]
Geography: [value]
Themes: [list]
Watching: [list]

Want to update anything, or jump straight into a decomposition?
```

If the file is empty or doesn't exist, run the full setup flow below.

---

## Opening

```
Welcome to Curiosity Stack.

A few quick questions to personalise your experience — takes about 2 minutes.
```

---

## Step 1 — Context

```
What best describes you?

1. Investor — I research companies and markets
2. Enterprise professional — I want to understand AI and tech trends
3. Both
4. Something else (tell me)
```

Store as **primary context**.

---

## Step 2 — Geography

```
Where is your primary focus?

1. India (surface Indian companies and proxies by default)
2. Global
3. Both
```

Store as **geography preference**.

---

## Step 3 — Research Sources

```
Do you keep research notes or ideas anywhere you'd like me 
to reference during sessions?

1. Google Drive
2. Notion
3. Gmail (newsletters, research threads)
4. Microsoft OneDrive / SharePoint
5. Airtable
6. Slack
7. Dropbox or Box
8. Multiple of the above
9. No, I'll start fresh
```

For each selected source:

```
To connect [Source]:
Settings → Connectors → [Source] → Connect

Once connected, I'll reference your notes automatically 
during every session. Let me know when it's done.
```

Walk through each one. Never mention JSON or MCP.

---

## Step 4 — Existing Research

```
Any companies or themes you're already tracking?

Share a few and I'll keep them in mind — flagging when a 
decomposition connects to something you're watching.

Or say "not yet" and we'll build your first list together.
```

---

## Step 5 — Compliance Acknowledgement

```
One important note before we begin:

This plugin is a research and structured thinking tool only. 
I am not a SEBI registered investment advisor, and nothing 
this plugin produces is investment advice or a recommendation 
to buy, sell, or hold any security.

All outputs are for educational and research purposes. 
Please consult a SEBI registered investment advisor for 
personalised financial guidance.

Understood? Then let's get started.
```

---

## Step 6 — Decomposition Library

```
Want me to save your research decompositions automatically 
after each session? I store them locally on your machine.

1. Yes — save automatically every time
2. Ask me each time
3. No thanks

If you have Google Drive or Notion connected, I can also 
mirror your library there so it's backed up and accessible 
across devices.

Mirror to:
1. Google Drive
2. Notion
3. Local only
```

Store as `library_save` and `library_mirror` in local.md.

---

## Step 7 — Watchlist Monitoring

```
I can monitor your watchlist topics automatically and send 
you a digest when something material changes at a value 
chain layer.

How often should I check?
1. Daily
2. Weekly  
3. Fortnightly

Where should I send the digest?
1. Email (via your connected Gmail)
2. Cowork summary only
3. Both

For each topic on your watchlist, you can also set specific 
triggers — e.g. "alert me when a new company enters Layer 4 
of EV batteries." We can set those up now or later via 
/curiosity-stack:watchlist.
```

If Gmail is connected, auto-detect email address and confirm:
```
I'll send digests to [detected email]. Is that right? (yes / different address)
```

Store as `watchlist_cadence`, `watchlist_email`, `watchlist_email_enabled` in local.md.

---

## Step 8 — Source Credibility

```
After each session, I can ask you to rate the sources we 
used — so over time I learn which sources work best for 
you by sector and layer.

Enable source ratings? (yes / no)

Should I auto-apply my suggestions based on your usage 
patterns, or always ask you to confirm?
1. Auto-apply
2. Always ask me
```

Store as `source_rating_enabled` and `source_auto_accept_suggestions` in local.md.

---

## Step 9 — Write to local.md

After collecting all answers, immediately write the user's responses into `curiosity-stack.local.md`.

Use exactly this format — fill in their answers, leave blank anything they skipped:

```yaml
context: [their answer — e.g. "Both — investor and enterprise professional"]
geography: [their answer — e.g. "India"]
themes:
  - [theme 1 if provided]
  - [theme 2 if provided]
watchlist:
  - [company 1 if provided]
  - [company 2 if provided]
deprioritise:
  - 
default_output: 
notes: |
  [any freetext notes from the conversation]
```

Tell them after writing:

```
Done — I've saved your context to curiosity-stack.local.md. 
Every future session will start from this without asking again.

You can update it anytime by editing the file directly, 
or by saying "update my setup".
```

---

## Step 7 — Complete

```
You're set up.

Context: [their answer]
Geography: [their answer]
Sources: [connected list or "none yet"]
Watching: [their list or "building as we go"]

To start your first decomposition:
/curiosity-stack:decompose

Or just tell me a topic and we'll begin.
```

Or just tell me a topic and we'll begin.
```
