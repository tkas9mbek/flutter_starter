---
description: Stage and commit current changes with proper messages
---

Stage and commit the current changes. Group unrelated changes into separate commits.

Message format per `docs/ai-context/git.md`: `TICKET-ID: Description` when the branch
has a ticket, otherwise `type: Description` (`type` ∈ feature|feat, fix, refactor,
research, release, docs, style, test, chore) — optionally with a `(scope)`, matching
this repo's existing log (e.g. `style(uikit): Replace chevron icons with stroked arrows`). Imperative mood, capitalized, no trailing
period, under 72 chars, one logical change per commit.

Do not push, do not merge. Report the commits created.
