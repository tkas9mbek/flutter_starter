# Git Workflow — AI Context

Concise format reference. Full guide: [../rules/git_workflow.md](../rules/git_workflow.md).

## Branches

`<category>/[<TICKET-ID>_]<kebab-case-description>`

| Category | Use when |
|----------|----------|
| `feature/` | Any ticketed work (**regardless of work type**) or a new feature without a ticket |
| `fix/` | Bug fix without a ticket |
| `refactor/` | Cleanup / restructuring without a ticket |
| `research/` | PoC / experiment |
| `release/` | Release prep |

## Commits (and PR/MR titles — usually the primary commit message)

```
TICKET-ID: Capitalized imperative description       # with ticket
type: Capitalized imperative description            # without ticket
type(scope): Capitalized imperative description     # optional scope, e.g. a package
```

`type` ∈ `{feature|feat, fix, refactor, research, release, docs, style, test, chore}`. Capitalized first letter, no trailing period, subject ≤ 72 chars, imperative mood ("Add", never "Adding"/"Fixed"), one logical change per commit.

## Examples

```
feature/PROJ-152_payment-redesign      fix/crash-on-login      refactor/clean-auth-repository
PROJ-152: Refactor payment module      fix: Resolve null pointer in notification handler
feat(starter_lints): Port advisory rules
```

Replace `PROJ-` with your tracker's prefix (`LIN-`, `MOBILE-`, `#123`, …), or use the `type:` form everywhere if there's no tracker.
