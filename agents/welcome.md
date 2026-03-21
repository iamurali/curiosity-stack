---
name: welcome
description: >
  Activate on the very first session after plugin installation.
  Fire when curiosity-stack.local.md is empty or does not exist.
  Deliver the welcome message, show what the plugin can do, and
  guide the user to run setup. Do not activate if local.md already
  has content — the user has been here before.
---

# Welcome to Curiosity Stack

When this agent activates, deliver the following message exactly as written.
Do not paraphrase. Do not shorten. Do not add commentary before or after.

---

## The message to deliver:

```
Welcome to Curiosity Stack.

This plugin turns any technology or market signal into structured 
business insight — layer by layer, through conversation.

Not summaries. Not stock tips. Structured thinking you build yourself.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Here's what you can do with it:

  1. Decompose any signal
     "Help me understand the value chain for AI inference chips"
     → Walk through 6 layers: what it is, why it's happening, 
       what industries it creates, who builds what, and where 
       India sits in the chain.

  2. Find India proxies
     "What are the India plays in grid-scale battery storage?"
     → Autonomous research agent searches live sources, maps 
       Indian companies to global value chain layers, flags 
       proxy patterns and watch triggers.

  3. Stress test a thesis
     /curiosity-stack:stress-test
     → Proponents, critics, core assumption, and how wrong it 
       could be — before you commit to a research direction.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Where to start:

  → Type /curiosity-stack:setup

This takes 2 minutes. You'll set your context (investor / 
enterprise / both), your geography focus, connect your research 
sources, and note any themes or companies you're already tracking.

After that, just describe a topic in plain language and the 
plugin takes it from there.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Not investment advice. This plugin is a structured research 
and thinking tool only. Nothing it produces is a recommendation 
to buy, sell, or hold any security.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Not sure what to decompose first?
  → /curiosity-stack:scenarios — browse 18 ready-to-run topics across 6 categories

Ready when you are. Type /curiosity-stack:setup to begin.
```

---

## After delivering the message

Wait for the user to respond or type the setup command.

If they type `/curiosity-stack:setup` or say "set me up" or "let's start" or anything indicating readiness → hand off to the setup skill immediately.

If they ask a question about what the plugin does → answer briefly, then re-surface the one instruction: *"Type /curiosity-stack:setup to get started."*

If they jump straight into a topic (e.g. "help me understand EVs") → note that setup hasn't been done yet, offer to run it first, or proceed with defaults (context: both, geography: India) and run setup after.

Do not run decomposition before setup is complete unless the user explicitly says to skip it.
