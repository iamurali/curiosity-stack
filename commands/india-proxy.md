---
name: india-proxy
description: >
  Find Indian companies at each layer of any global value chain.
  Runs the india-proxy-agent autonomously — fetches NASSCOM Deep Tech,
  DPIIT, GeM portal, 12 VC portfolios, BSE SME, NSE Emerge, and
  specialist publications. Returns a structured HTML research table.
usage: "/curiosity-stack:india-proxy [topic or value chain]"
example: "/curiosity-stack:india-proxy enterprise cybersecurity"
agent: india-proxy-agent
---

# India Proxy

Activates the India Proxy Agent.

The agent follows a mandatory sourcing checklist defined in its
skill file. It must complete all sourcing blocks before generating
output. Do not summarise in chat text — the output is always an
HTML artifact using the ipa-wrap table format.

Sourcing blocks the agent must complete:
- Block A: NASSCOM Deep Tech, DPIIT, GeM portal, DSCI, BSE SME, NSE Emerge
- Block B: All 12 seeded VC portfolio pages (web_fetch each URL)
- Block C: Analyst coverage, Inc42, Tracxn, Crunchbase India

Output format: HTML artifact starting with <style> .ipa-wrap {
Never output a markdown table. Never summarise in chat text.
Never paste raw CSS or HTML into the chat response.
The artifact is the entire output. Chat response must be empty.
The artifact includes the domain knowledge add form at the bottom.

*All outputs are research framing only. Not investment advice.
Not a recommendation to buy, sell, or hold any security.*
