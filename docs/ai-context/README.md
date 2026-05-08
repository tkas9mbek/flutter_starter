# AI Context

Concise, scannable rule references designed to be loaded by AI agents (Claude Code, Cursor) without burning context on full prose docs.

| File | Topic | Full source |
|------|-------|-------------|
| [architecture.md](architecture.md) | Layer rules + folder layout | [../guides/architecture.md](../guides/architecture.md) |
| [bloc.md](bloc.md) | BLoC + Freezed patterns | [../guides/freezed_bloc.md](../guides/freezed_bloc.md) |
| [exception.md](exception.md) | Exception model + codegen | [../guides/exception_handling.md](../guides/exception_handling.md) |
| [rules.md](rules.md) | Style + naming + forbidden patterns | [../rules/](../rules/) |
| [testing.md](testing.md) | Test layout + mocktail rules | [../guides/testing.md](../guides/testing.md) |

## When to read which

- **Implementing a feature**: `architecture.md` → `bloc.md` → `exception.md`.
- **Reviewing code**: [`../guides/code_review.md`](../guides/code_review.md).
- **Estimating a task**: [`../guides/estimation.md`](../guides/estimation.md).
- **Writing tests**: `testing.md`.
- **Stuck on style/lint**: `rules.md`.
- **Naming branches / commits / PRs**: [`../rules/git_workflow.md`](../rules/git_workflow.md).

If a rule here conflicts with a full guide, the full guide wins — flag and fix the AI-context file.
