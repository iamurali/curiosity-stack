# Curiosity Stack Intent Routing Spec

This document is the single source of truth for intent resolution.
All skills and agents should follow this precedence and taxonomy.

## Objective

Use one entry point (`welcome`) and resolve user intent into skill routing
without requiring command invocation.

## Routing Precedence

Apply in this strict order:

1. **Compliance hard rules**
   - Apply `sebi-compliance` constraints to all outputs.
2. **Lifecycle/state gates**
   - Current stage, layer, and cadence-based triggers.
   - Examples: post-L5 India proxy offer, watchlist cadence elapsed.
3. **High-confidence intent phrases**
   - Direct phrase/synonym matches from skill intent metadata.
4. **Semantic match**
   - Match user text to skill purpose and trigger examples.
5. **Clarify if ambiguous**
   - If top two candidates are close, ask a short disambiguation question.

## Session State Keys

Use these state keys while routing:

- `stage`: welcome | setup | decompose | post_decompose | watchlist | library | knowledge
- `layer`: L0 | L1 | L2 | L3 | L4 | L5 | L6 | none
- `session_count`: integer from `curiosity-stack.local.md`
- `watchlist_cadence`: daily | weekly | fortnightly
- `watchlist_last_run`: date
- `last_skill`: skill id

## Intent Taxonomy

| Intent | Route target | Phrase examples |
|---|---|---|
| onboarding_setup | `setup` | "set me up", "configure", "connect my notes" |
| decompose_topic | `curiosity-framework` | "help me understand", "break down", "decompose" |
| scenario_discovery | `scenario-library` | "give me ideas", "show scenarios", "not sure where to start" |
| watchlist_manage | `watchlist-tracker` | "show my watchlist", "add trigger", "watchlist digest" |
| domain_knowledge_manage | `domain-knowledge` | "manage my domain knowledge", "add company to knowledge" |
| thesis_stress_test | `thesis-stress-test` | "stress test this", "challenge this thesis" |
| library_manage | `decomposition-library` | "open my library", "load prior decomposition", "compare previous" |
| india_proxy_run | `india-proxy-agent` | "find India proxies", "Indian companies in this chain" |

## Tie-break Rules

When confidence is close:

1. Continue current workflow if user context is clearly mid-flow.
2. Prefer narrower skill over generic skill.
3. Prefer explicit lifecycle trigger over phrase-only trigger.
4. Ask one clarifying question if still tied.

## Clarification Prompt Pattern

Use one short question:

`Do you want me to [option A] or [option B]?`

Do not ask more than one question at a time.

## Routing Debug Mode (Internal)

For tuning and QA, produce an internal one-line trace after routing:

`route_debug: intent=<intent_id>; winner=<skill_or_agent>; confidence=<0-1>; reason=<rule_or_phrase>; runner_up=<intent_or_none>`

Rules:
- Never expose `route_debug` in normal user-facing output.
- Enable only in test/debug sessions.
- Use logs to tune phrase overlaps and tie thresholds.

## Deprecated Command Path

Command files in `commands/` are legacy compatibility references.
They must not be treated as primary routing entry for new sessions.
