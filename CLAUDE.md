# CLAUDE.md

> **AI Context**: Claude-Code-specific guidance. Project rules, architecture, style, and commands live in [`AGENTS.md`](./AGENTS.md) — that file is the single source of truth and applies regardless of which AI tool is used. This file only adds what's specific to working in Claude Code: subagents, slash commands, and skills.

## Read This First

1. **Read `AGENTS.md` first.** It has the project overview, essential commands, architecture rules, BLoC/exception/testing/style conventions, and the `docs/ai-context/` map. Everything there applies here unchanged.
2. This file adds: which subagent to delegate to, which slash command to run, and which skill governs comments.

---

## Use Subagents for Different Tasks

Prefer delegating to the matching subagent (`.claude/agents/*.md`) over doing the work inline — each is scoped to one kind of task and reports back in a fixed format.

| Task shape | Agent | Notes |
|---|---|---|
| "Where is X", "what calls Y", "which files touch Z" — fact-finding only | `explorer` | Reports file:line findings. Never diagnoses or edits. |
| Plan before implementing, root-cause an unknown failure, judge a naming/design choice | `planner` | Writes Markdown under `work/` (plans, analyses). Never touches source, never `docs/`. |
| Write a code review report on finished work, or author architecture/reference docs | `reviewer` | Writes Markdown under `work/` (or `docs/` only if explicitly asked). Never touches source. |
| Apply an existing plan, or a change the prompt spec already fully describes | `implementer` | Needs a plan (a `work/` file or the prompt's own steps) — writes code + tests, verifies with `fvm flutter analyze`/`test`. |
| Rename a class/file, move a declaration, mass find-and-replace, update imports everywhere | `mechanic` | Change is already decided; job is completeness, not judgment. |
| Add/trim/remove comments and doc comments only | `documenter` | Applies the `comment-rules` skill. Never changes behavior. |

Typical chain: `explorer` gathers facts → `planner` turns them into a plan (`work/plans/<slug>.md`, with a Test Cases section written before Steps and a Review Criteria acceptance checklist) → `implementer` executes it, writing those tests first → `reviewer` (or `/com_review`) checks the result.

---

## Slash Commands (`.claude/commands/`)

| Command | Does |
|---|---|
| `/com_commit` | Stage and commit current changes, grouped into logical commits, per `docs/ai-context/git.md` format. |
| `/com_fix` | Fix every analyzer + `starter_lints` error across the app and `packages/`. |
| `/com_format` | `dart format` + analyze (incl. `starter_lints`) on branch-changed files, a path, or a described scope. |
| `/com_cleanup` | Remove temp artifacts (stray untracked scratch/logs) and analyzer-confirmed dead code. Never deletes tracked files under `work/`. |
| `/com_review` | Delegates to `reviewer`; writes `work/review.md` following `docs/ai-context/code_review.md` exactly (rule IDs, severities, Verdict). |
| `/com_read_branch` | Delegates to `explorer`; writes `work/branch_context.md` — a neutral handover doc (what changed, how to verify, edge cases), not a review. |
| `/com_to_test` | Writes a Russian, non-technical test note in Confluence markup to `work/test_note.txt`, for testers/PMs. |

## Skills

- `comment-rules` (`.claude/skills/comment-rules/SKILL.md`) — the rules `documenter` applies to every comment/doc-comment decision (max line length, WHY-only, no location-justification comments, etc).
- `split-large-widget` (`.claude/skills/split-large-widget/SKILL.md`) — extract-to-file procedure for a screen/widget file over the ~200-line ceiling in `docs/rules/code_standards.md`.
