# AI Context

Compact references for AI agents. Start with `AGENTS.md` (or `CLAUDE.md`), then open only the topic files the task
needs. If a compact file conflicts with a source doc, the source doc wins and this directory should be fixed.

Project context: fill-in templates [`product-context.md`](../project/product-context.md) and
[`engineering-context.md`](../project/engineering-context.md) when starting a new app from the starter. The `work/`
directory (plans, reviews) is scratch and usually absent — don't rely on it.

## Rule Map

- [architecture.md](architecture.md) - layers, folders, DI, codegen. Source: [architecture](../guides/architecture.md), [structure](../guides/structure.md).
- [bloc.md](bloc.md) - BLoCs, events, states, UI state matching. Source: [bloc rules](../rules/bloc.md).
- [exception.md](exception.md) - errors, exception mapping, failure UI. Source: [exception handling](../guides/exception_handling.md).
- [repository_executor.md](repository_executor.md) - executor composition, caching, executor tests. Source: [repository executor](../guides/repository_executor.md).
- [rules.md](rules.md) - style, naming, comments, forbidden patterns. Source: [code standards](../rules/code_standards.md), [code preferences](../rules/code_preferences.md), [naming](../rules/naming.md); shared widgets: [uikit](../rules/uikit.md).
- [mocking.md](mocking.md) - `Mock*DataSource` twins, scenarios, `MockNetworkBehavior`. Source: [mocking](../guides/mocking.md).
- [pagination.md](pagination.md) - `PaginatedData`, load-more, refresh. Source: [pagination](../guides/pagination.md).
- [polymorphism.md](polymorphism.md) - sealed types / UI models instead of repeated enum switches. Source: [polymorphism](../guides/polymorphism.md).
- [testing.md](testing.md) - tests. Source: [testing](../guides/testing.md).
- [code_review.md](code_review.md) - review checklist. Source: [code review](../guides/code_review.md).
- [git.md](git.md) - branch, commit, PR naming. Source: [git workflow](../rules/git_workflow.md).
- [estimation.md](estimation.md) - estimates. Source: [estimation](../guides/estimation.md).

Also: [ai_agent.md](../guides/ai_agent.md) (context layers, subagents, `work/` savepoints) · [deployment.md](../guides/deployment.md) (CI/CD: TestFlight + Firebase App Distribution).

## Fast Loading Paths

- Feature: `architecture.md` -> `bloc.md` -> `exception.md` -> `testing.md` (+ `pagination.md` for paged lists).
- UI-only: `rules.md` -> `architecture.md`; check `starter_uikit` before custom widgets (`polymorphism.md` if a type is switched in 3+ places).
- Data-layer/API: `../project/engineering-context.md` -> `architecture.md` -> `mocking.md` -> `exception.md` -> `testing.md`.
- Test-only: `testing.md` -> `rules.md` (`mocking.md` for twins).
- Review: `code_review.md` first, then topic files for any suspicious area.
