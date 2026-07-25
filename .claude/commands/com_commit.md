---
description: Stage and commit current changes with proper messages
---

Stage and commit the current changes. Group unrelated changes into separate commits.

Message format per `docs/ai-context/git.md`: `TICKET-ID: Description` when the branch
has a ticket, otherwise `type: Description` (`type` ∈ feature/fix/refactor/research/
release) — optionally with a `(scope)`, matching this repo's existing log (e.g.
`refactor(uikit): Factory-based widgets`). Imperative mood, capitalized, no trailing
period, under 72 chars, one logical change per commit.

Do not push, do not merge. Report the commits created.
