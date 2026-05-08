# AI Context

Concise, scannable rule references designed for AI agents (Claude Code, Cursor) to load without burning context on full prose docs. Each file mirrors a human-friendly source under `../guides/` or `../rules/`.

| File | Topic | Full source |
|------|-------|-------------|
| [architecture.md](architecture.md) | Layer rules + folder layout | [../guides/architecture.md](../guides/architecture.md), [../guides/structure.md](../guides/structure.md) |
| [bloc.md](bloc.md) | BLoC + Freezed patterns | [../rules/bloc.md](../rules/bloc.md), [../guides/freezed_bloc.md](../guides/freezed_bloc.md) |
| [exception.md](exception.md) | Exception model + codegen | [../guides/exception_handling.md](../guides/exception_handling.md) |
| [rules.md](rules.md) | Style + naming + forbidden patterns | [../rules/coding-rules.md](../rules/coding-rules.md), [../rules/code_formatting.md](../rules/code_formatting.md), [../rules/naming.md](../rules/naming.md) |
| [testing.md](testing.md) | Test layout + mocktail rules | [../guides/testing.md](../guides/testing.md) |
| [code_review.md](code_review.md) | Severity-based PR checklist | [../guides/code_review.md](../guides/code_review.md) |
| [estimation.md](estimation.md) | Story-point model + modifiers | [../guides/estimation.md](../guides/estimation.md) |
| [git.md](git.md) | Branch / commit / PR format | [../rules/git_workflow.md](../rules/git_workflow.md) |

## When to read which

- **Implementing a feature**: `architecture.md` → `bloc.md` → `exception.md`.
- **Reviewing code**: `code_review.md`.
- **Estimating a task**: `estimation.md`.
- **Writing tests**: `testing.md`.
- **Stuck on style or naming**: `rules.md`.
- **Naming branches / commits / PRs**: `git.md`.

If a rule here conflicts with a full guide, the full guide wins — flag and fix the AI-context file.
