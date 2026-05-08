# Git Workflow — AI Context

Concise format reference. Full guide: [../rules/git_workflow.md](../rules/git_workflow.md).

## Branches

```
<category>/[<TICKET-ID>_]<kebab-case-description>
```

| Category | Use when |
|----------|----------|
| `feature/` | Any tracked work (ticketed) **or** new feature without a ticket |
| `fix/` | Bug fix without a ticket |
| `refactor/` | Cleanup / restructuring without a ticket |
| `research/` | PoC / experiment |
| `release/` | Release prep |

**Rule**: ticketed work always uses `feature/` regardless of work type.

## Commits

```
TICKET-ID: Capitalized imperative description       # with ticket
type: Capitalized imperative description            # without ticket
```

`type` ∈ `{feature, fix, refactor, research, release}`.

| Rule | Note |
|------|------|
| Capitalize first letter | `PROJ-156: Add OTP validation` |
| No trailing period | — |
| ≤ 72 characters | Subject only |
| Imperative mood | "Add" / "Fix" — never "Adding" / "Fixed" |
| One logical change per commit | — |

## PR / MR titles

Same format as commits — usually the primary commit message.

## Quick examples

```bash
# Branch
feature/PROJ-152_payment-redesign
fix/crash-on-login
refactor/clean-auth-repository

# Commit
PROJ-152: Refactor payment module
fix: Resolve null pointer in notification handler
```

## Adapt the prefix

Replace `PROJ-` with whatever your tracker uses (`LIN-`, `MOBILE-`, `#123`, …) or use the `type:` form for everything if there's no tracker.
