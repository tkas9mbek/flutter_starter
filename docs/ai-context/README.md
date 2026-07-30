# AI Context

Compact references for AI agents. Start here after `AGENTS.md` or `CLAUDE.md`, then open only the topic files
needed for the task. If a compact file conflicts with a source doc, the source doc wins and this directory should
be fixed.

## Project Context

- Product and engineering context are project-specific fill-in templates — see
  [`../project/product-context.md`](../project/product-context.md) and
  [`../project/engineering-context.md`](../project/engineering-context.md). Fill them in when starting a new
  app from the starter.
- Supplemental overview, when present: [`../../work/project-overview.md`](../../work/project-overview.md).
- Older `work/` API/planning docs may be absent or stale; prefer `docs/project/` unless a task
  explicitly targets `work/`.

## Rule Map

- [architecture.md](architecture.md) - features, folders, DI, repositories, data sources.
  Source: [architecture](../guides/architecture.md), [structure](../guides/structure.md).
- [bloc.md](bloc.md) - BLoCs, events, states, UI state matching.
  Source: [bloc rules](../rules/bloc.md).
- [exception.md](exception.md) - errors, exception mapping, failure UI.
  Source: [exception handling](../guides/exception_handling.md).
- [repository_executor.md](repository_executor.md) - executor composition, caching, executor tests.
  Source: [repository executor guide](../guides/repository_executor.md).
- [rules.md](rules.md) - style, naming, comments, imports, forbidden patterns.
  Source: [coding](../rules/coding_rules.md), [formatting](../rules/code_formatting.md), [naming](../rules/naming.md).
- [testing.md](testing.md) - tests.
  Source: [testing guide](../guides/testing.md).
- [code_review.md](code_review.md) - review checklist.
  Source: [code review guide](../guides/code_review.md).
- [estimation.md](estimation.md) - estimates.
  Source: [estimation guide](../guides/estimation.md).
- [git.md](git.md) - branch, commit, PR naming.
  Source: [git workflow](../rules/git_workflow.md).

## Fast Loading Paths

- Feature implementation: `architecture.md` -> `bloc.md` -> `exception.md` -> `testing.md`.
- UI-only change: `rules.md` -> `architecture.md`; check `starter_uikit` before custom widgets.
- Data-layer/API work: `../project/engineering-context.md` -> `architecture.md` -> `exception.md` -> `testing.md`.
- Test-only change: `testing.md` -> `rules.md`.
- Review: `code_review.md` first, then topic files for any suspicious area.
