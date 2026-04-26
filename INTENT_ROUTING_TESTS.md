# Intent Routing Test Matrix

Use this matrix to validate single-entry skill routing behavior.

## High-confidence routes

| User utterance | Expected route |
|---|---|
| "set me up for India-focused research" | `setup` |
| "help me understand AI inference demand" | `curiosity-framework` |
| "show scenarios" | `scenario-library` |
| "manage my watchlist for EV batteries" | `watchlist-tracker` |
| "open my library" | `decomposition-library` |
| "manage my domain knowledge" | `domain-knowledge` |
| "stress test this thesis" | `thesis-stress-test` |
| "find India proxies for this chain" | `india-proxy-agent` |

## Lifecycle/state routes

| Context | User utterance | Expected route |
|---|---|---|
| after L5 prompt | "yes" | `india-proxy-agent` |
| watchlist cadence elapsed | "hi" | `watchlist-tracker` scheduled run, then normal flow |
| first session (`session_count=0`) | "hello" | `welcome`, then `setup`/`scenario-library` guidance |

## Ambiguity and tie cases

| User utterance | Expected behavior |
|---|---|
| "help me track this and break it down" | Clarify: decomposition vs watchlist |
| "I want ideas and setup" | Clarify: onboarding first vs scenarios |
| "add this company and set alert" | Clarify: domain knowledge vs watchlist trigger |

Clarification format must be:

`Do you want me to [option A] or [option B]?`

## Negative checks

- No default suggestion should require slash command usage.
- Command files may exist as legacy aliases, but routing should not depend on them.
- If confidence is low and no lifecycle gate exists, ask one clarification question.
