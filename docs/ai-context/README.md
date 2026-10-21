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

Also: [deployment.md](../guides/deployment.md) (CI/CD: TestFlight + Firebase App Distribution); [common_problems.md](../guides/common_problems.md) (recipes: sign-out, stale data across screens, form errors).

## Fast Loading Paths

- Feature: `architecture.md` -> `bloc.md` -> `exception.md` -> `testing.md` (+ `pagination.md` for paged lists).
- UI-only: `rules.md` -> `architecture.md` (+ [uikit rules](../rules/uikit.md) when touching `starter_uikit`); check `starter_uikit` before custom widgets (`polymorphism.md` if a type is switched in 3+ places).
- Data-layer/API: `../project/engineering-context.md` -> `architecture.md` -> `mocking.md` -> `exception.md` -> `testing.md`.
- Test-only: `testing.md` -> `rules.md` (`mocking.md` for twins).
- Review: `code_review.md` first, then topic files for any suspicious area.

## Maintaining These Docs

Shape every `docs/ai-context/<topic>.md` the same way:

| Rule | As done today |
|---|---|
| Title + one-line source pointer | `# Testing — AI Context` / `Concise rules. Full guide: [../guides/testing.md](../guides/testing.md).` |
| Rule IDs with a topic prefix, in a table | `A1`-`A8` architecture, `T1`-`T8` testing, `S1`-`S9` style, `M1`-`M10` mocking, `PAG-1`…`PAG-9`, `POLY-1`…`POLY-10`; review IDs `ARCH/BLOC/EXC/UI/NAME/FILE/TEST/STYLE/REUSE/MODEL-n` |
| IDs are stable keys | Append (`T9`); never renumber or reuse — reviews, prompts and `TODO`s cite them |
| Tables over prose; one example per pattern, ≤ ~30 lines | `bloc.md` shows one simple and one nested-status state |
| Pointer, not duplication; a `Don't` list at the end | Link the guide section; each `Don't` is a concrete anti-pattern |
| Size | Aim under ~150 lines; `code_review.md` is the largest |

- **Source doc wins on conflict.** `docs/guides/` / `docs/rules/` are the source (BLoC rules live only in [`rules/bloc.md`](../rules/bloc.md)); fix the compact file (and `AGENTS.md`) and flag it in the PR.
- **`AGENTS.md` and `ai-context` stay in sync.** `AGENTS.md` repeats the `A*`, `T*`, `S*` tables and the BLoC / exception / git summaries — a rule change edits both, same wording, same ID.
- **`[lint]` in `code_review.md`** means `starter_lints` / the analyzer catches it; reviewers skip it.
- **Agent and command files are context too** — keep `.claude/agents/*.md` and `.claude/commands/*.md` aligned with `git.md` / `code_review.md` wording (severity names, commit types, hand-off targets).
- **`work/`** holds plans, analyses and reviews for the current task. It is scratch, not documentation; durable knowledge goes to `docs/`.

Adding a topic file: (1) write or confirm the source under `docs/guides/` or `docs/rules/`; (2) create `docs/ai-context/<topic>.md` with a new ID prefix; (3) add it to the Rule Map above with its `Source:` link, and to a Fast Loading Path if a task type needs it; (4) add a row to `AGENTS.md`'s Documentation Map; (5) cross-reference from related compact files; (6) touch `CLAUDE.md` only if a Claude-specific agent, command or skill changes.
