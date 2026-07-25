---
description: Create work/branch_context.md — what this branch does, edge cases to test, everything a new dev needs to check this work. Not a review; for issues use /com_review.
---

Produce a handover document for this branch: enough for a developer who has never seen
this task to understand it and verify another dev's work. Context, not critique — no
issue-hunting here; that's /com_review.

Delegate the diff reading to the explorer agent (branch vs main: changed files grouped
by package/feature, commit messages) so the raw diff stays out of this conversation.

Write `work/branch_context.md`:

# Branch: <name>

## What is done
2-4 sentences: the task and how it was solved, inferred from commits, branch name, and
change shape.

## Changes by area
Per package/feature, what changed and why — behavior-level ("CalendarBloc now
refreshes on tab focus instead of on every rebuild"), not file lists.

## How to verify
The flows to run, in order, with expected outcomes. Include the entry points
(screen/route names) and any setup needed (accounts, flags, real device).

## Edge cases to test
Concrete cases this change could break: empty/null data, repeat visits, offline,
process death, locale, first-run vs returning user — whichever apply to THESE changes,
derived from the actual diff, not a generic checklist.

## Touches / regression surface
Shared code changed (core, shared, design system) and which other features consume it.

## State
Finished / in progress; leftover TODOs, temp code, work/ or temp/ artifacts.

In this conversation return only the path and the "What is done" section.
