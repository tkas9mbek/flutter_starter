# AI Agent Guide

> How to work with AI coding agents in this repo and maintain the context docs they read. The rules live in
> [`AGENTS.md`](../../AGENTS.md) and [`docs/ai-context/`](../ai-context/README.md); this guide covers using and
> maintaining them.

## 1. Context & tokens in practice

One fixed-size context window holds everything: auto-loaded instruction files, every file read, every command output,
every message. When it fills, older turns are compacted or dropped permanently.

| Rough cost | Item |
|---|---|
| ~10-20 tokens | One line of code |
| ~500-1,000 tokens | A 100-line file |
| ~2,000-3,000 tokens | `AGENTS.md` (~230 lines) |
| ~300-1,500 tokens each | A `docs/ai-context/` topic file (45-160 lines; `testing.md` is the largest) |
| 10,000+ tokens | A `docs/guides/` prose guide; a feature folder including generated files |

| Practice | Why |
|---|---|
| Load `AGENTS.md` plus the 2-4 compact topic files for the task, not `docs/guides/` | Compact files replace the prose; open a guide only when a compact file is silent or conflicts |
| Never read `*.g.dart`, `*.freezed.dart`, `*.gr.dart`, `packages/starter_uikit/lib/resources/` | Generated, large, never hand-edited |
| Push broad reading onto `explorer` / `mechanic` | Both run on `sonnet`; `planner` and `reviewer` say it outright: "your tokens are the expensive ones" |
| Keep raw diffs and long reports out of the lead conversation | `/com_review`, `/com_read_branch`, `/com_to_test` write to `work/` and return a short summary |
| One feature or package per session; fresh session for the next task | Finished-task turns are dead weight |

## 2. How this repo layers its context

| Layer | File(s) | Role |
|---|---|---|
| 1. Canonical rules | `AGENTS.md` | Single source of truth: commands, rule tables with IDs (`A1`-`A8`, `T1`-`T8`, `S1`-`S7`), BLoC / exception / git summaries, Documentation Map. Read by every tool |
| 2. Compact references | `docs/ai-context/*.md` | One file per topic: rule IDs, tables, one example per pattern. `README.md` maps each to its source doc and lists the **Fast Loading Paths** (which files to read per task type) |
| 3. Full prose | `docs/guides/`, `docs/rules/` | Reasoning and detail. **Wins on conflict** with layers 1-2; agents open it only when a compact file is insufficient |
| 4. Project context | `docs/project/product-context.md`, `engineering-context.md` | Fill-in templates for the app built from this starter; read for data-layer / API work |
| Tool layer | `CLAUDE.md` | Claude Code only: which subagent, command or skill to use. Starts with "read `AGENTS.md` first", repeats no rules |

Principle: a rule belongs in `AGENTS.md` / `docs/ai-context/`, never in a tool file. Another tool gets its own thin
layer file pointing to `AGENTS.md` the same way.

## 3. Choosing a subagent or command

Subagents live in `.claude/agents/*.md`, each with a fixed report format and a "NOT yours" list; a wrong pick returns a
hand-off line ("Out of scope … Hand off to: <agent>") instead of work.

| Agent | Use for | Writes | Never | Model |
|---|---|---|---|---|
| `explorer` | "Where is X", "what calls Y", collecting call sites / config / patterns | Findings (file:line) in chat | Diagnoses, proposes fixes, edits | sonnet |
| `planner` | Implementation plan, root-cause analysis, naming / design judgment | `work/plans/<slug>.md`, `work/analysis/<slug>.md` | Source, tests, `docs/` | fable |
| `implementer` | Apply an existing plan (a `work/` file or steps in the prompt) | Code + tests; verifies with analyze / test | `.md` files, scope expansion, unknown-cause investigation | opus |
| `mechanic` | Rename / move / mass replace / import updates — change already decided | Source via sed, `git mv`, Edit; reruns codegen | Design decisions, hand-editing generated files | sonnet |
| `documenter` | Add / trim / remove comments and dartdoc | Comments only, per `comment-rules` | Behavior changes, `docs/` | opus |
| `reviewer` | Review a finished diff or branch; author `docs/` when explicitly asked | `work/review.md`; `docs/` on request | Source, tests, builds | fable |

Typical chain: `explorer` (facts) → `planner` (Test Cases before Steps, plus a Review Criteria list) → `implementer`
(tests first, then code, then `fvm flutter analyze` / `fvm flutter test`) → `reviewer` or `/com_review`.

Slash commands (`.claude/commands/*.md`): `/com_commit` (logical commits per `git.md`, never pushes), `/com_fix`
(analyzer + `starter_lints` errors in app and `packages/*`, no `// ignore:`), `/com_format [scope]`, `/com_cleanup [dir]`
(untracked temp artifacts, analyzer-confirmed dead code), `/com_review` (→ `work/review.md`), `/com_read_branch`
(neutral handover → `work/branch_context.md`), `/com_to_test` (Russian tester note → `work/test_note.txt`).
Skills (`.claude/skills/*/SKILL.md`): `comment-rules`, `split-large-widget` (>200-line screen/widget file).

| Situation | Pick |
|---|---|
| Failure with unknown cause | `explorer` for facts → `planner` for the root cause (`work/analysis/`) |
| "Should we move / rename X?" | `planner` for the judgment, then `implementer` or `mechanic` |
| Prompt fully specifies the edit | `implementer` directly — the prompt is the plan |
| Rename across many files, no judgment | `mechanic` |
| Comments only | `documenter` |
| Done; want a verdict before merge | `/com_review`; for a handover doc instead, `/com_read_branch` |

## 4. Savepoints & recovering after a context reset

Conversation history does not survive a reset; files under `work/` do. Agents and commands write their savepoints there:

| File | Written by | Contains |
|---|---|---|
| `work/plans/<slug>.md` | `planner` | Goal, Constraints, Files in scope, Test Cases, Steps, Review Criteria, Verification, Out of scope, Open questions |
| `work/analysis/<slug>.md` | `planner` | Symptom, Evidence (file:line), Cause, Confidence, Ruled out, Recommended fix |
| `work/review.md` | `reviewer`, `/com_review` | Rule-ID findings per severity + Verdict |
| `work/branch_context.md` | `/com_read_branch` | What is done, changes by area, how to verify, edge cases, regression surface |
| `work/test_note.txt` | `/com_to_test` | Tester-facing note; reuses `review.md` / `branch_context.md` when fresh |

Lifecycle: `work/` is created on demand and is scratch for the current task, not documentation — it does not exist in a
clean checkout (`chore: Remove stale work/ planning docs` pruned the last committed files). It is not git-ignored, so
new files show as untracked. `/com_cleanup` deletes only `work/` files that are untracked **and** clearly stale and
lists anything doubtful. Durable knowledge goes to `docs/` (via `reviewer`, on explicit request).

Recovery in a new session: (1) rules — Claude Code auto-loads `CLAUDE.md` → `AGENTS.md`; other tools read `AGENTS.md`;
(2) plan — `work/plans/<slug>.md` (+ `work/analysis/<slug>.md` if it started from a failure); (3) real state —
`git status`, `git diff main...HEAD --stat`, `fvm flutter analyze`, `fvm flutter test --concurrency 4`; trust the tree,
not memory; (4) tell `implementer` which plan steps are done. `implementer` never writes `.md` files, so its
`## Implemented` / `## Left open` report is the only progress record — copy it into the plan file before the session ends.

## 5. Writing and maintaining ai-context docs

Shape every `docs/ai-context/<topic>.md` the same way:

| Rule | As done today |
|---|---|
| Title + one-line source pointer | `# Testing — AI Context` / `Concise rules. Full guide: [../guides/testing.md](../guides/testing.md).` |
| Rule IDs with a topic prefix, in a table | `A1`-`A8` architecture, `T1`-`T8` testing, `S1`-`S9` style, `M1`-`M10` mocking, `PAG-1`…`PAG-9`, `POLY-1`…`POLY-9`; review IDs `ARCH/BLOC/EXC/UI/NAME/FILE/TEST/STYLE/REUSE/MODEL-n` |
| IDs are stable keys | Append (`T9`); never renumber or reuse — reviews, prompts and `TODO`s cite them |
| Tables over prose; one example per pattern, ≤ ~30 lines | `bloc.md` shows one simple and one nested-status state |
| Pointer, not duplication; a `Don't` list at the end | Link the guide section; each `Don't` is a concrete anti-pattern |
| Size | Aim under ~150 lines; `testing.md` (~160) is the largest |

Maintenance:

- **Source doc wins on conflict.** `docs/guides/` / `docs/rules/` are the source; fix the compact file (and `AGENTS.md`)
  and flag it in the PR.
- **`AGENTS.md` and `ai-context` stay in sync.** `AGENTS.md` repeats the `A*`, `T*`, `S*` tables and the BLoC /
  exception / git summaries — a rule change edits both, same wording, same ID.
- **`[lint]` in `code_review.md`** means `starter_lints` / the analyzer catches it; reviewers skip it.
- **Agent and command files are context too** — keep `.claude/agents/*.md` and `.claude/commands/*.md` aligned with
  `git.md` / `code_review.md` wording (severity names, commit types, hand-off targets).

Adding a topic file (the steps `mocking.md` followed): (1) write or confirm the source under `docs/guides/` or
`docs/rules/`; (2) create `docs/ai-context/<topic>.md` with a new ID prefix; (3) add it to the Rule Map in
`docs/ai-context/README.md` with its `Source:` link, and to a Fast Loading Path if a task type needs it; (4) add a row to
`AGENTS.md`'s Documentation Map; (5) cross-reference from related compact files (e.g. `code_review.md` `TEST-6` cites
the `M*` rules); (6) touch `CLAUDE.md` only if a Claude-specific agent, command or skill changes.

Agents: frontmatter `name`, `description` (when to use + what it never does), `tools`, `model`, `effort`, `color`
(optional `skills`, `mcpServers`); body = fixed report format, "When to use — real examples", a "NOT yours" list, hard
rules, an explicit hand-off line. Commands: frontmatter `description` (+ `argument-hint` if the body uses
`$ARGUMENTS`); body = resolve scope → numbered steps → safety lines → "Report: …" → "In this conversation return only …"
so raw output stays out of the lead context.

## 6. Writing effective prompts and briefs

| Part | Content | Example |
|---|---|---|
| Goal | One sentence, the outcome | "Add a `.refreshed()` event to `CalendarBloc` so retry re-fetches instead of reading data back out of state" |
| Files | Exact paths or one feature folder | `lib/features/task/ui/calendar/bloc/`, tests under `test/features/task/bloc/` |
| Constraints | The rule IDs that bind | "`BLOC-11` final `return emit`; the `T2` feature-flow test must still pass; no new dependencies" |
| Ruled out | What not to do, and why | "No second bloc — `A3`; don't touch `starter_toolkit`" |
| Expected report | The format you will read | "Implementer format: Implemented / Changed files / Verification / Deviations / Left open" |
| Verification | Exact commands | `fvm flutter analyze`; `fvm flutter test test/features/task --concurrency 4` |

| Agent | Good brief | Bad brief |
|---|---|---|
| `explorer` | "Where is `AppDatePickerField` used? Report file:line." | "Look around `task/` and tell me what you think" |
| `planner` | "Plan task reminders: scope `lib/features/task`, `starter_toolkit` off-limits, Test Cases before Steps" | "Just fix it" — it never writes code |
| `implementer` | "Apply `work/plans/task-reminders.md`, steps 1-4" or numbered steps | "Re-implement task reminders" — a feature name is not a plan |
| `mechanic` | "Rename class and file `X` → `Y` across app and tests; rerun build_runner" | "Clean up the naming in `task/`" |
| `documenter` | "Add a doc comment on `RawRepositoryExecutor` noting `withErrorHandling()` must be innermost" | "Document everything" |
| `reviewer` | "Review branch vs `main` per `code_review.md`; also check the plan's Review Criteria" | "Is this good?" |

Figma links go to `implementer` only — it is the one agent with the Figma MCP server configured.

## 7. Do's and don'ts

| Do | Don't |
|---|---|
| Start from `AGENTS.md` + the Fast Loading Path for the task type | Ask an agent to read the whole codebase or all of `docs/guides/` |
| Give `explorer` the reading; keep `planner` / `reviewer` for judgment | Let an expensive agent grep its way through a feature |
| Put plans in `work/plans/`, open questions at the top | Keep the plan only in the conversation |
| Write tests first — the plan lists Test Cases before Steps | Accept "tests later" |
| Run `fvm flutter analyze` + tests after every `implementer` / `mechanic` report | Trust "done" without a Verification block |
| Cite rule IDs in prompts and reviews (`A3`, `BLOC-2`, `T2`, `M1`) | Re-explain the rule in prose each time |
| Re-run generators (`build_runner`, exception mapper, `intl_utils`, `spider`) | Let an agent hand-edit `*.g.dart`, `*.freezed.dart`, `lib/resources/` |
| Reuse `starter_uikit` / `starter_toolkit` first (AGENTS.md "Reusing Toolkit & UIKit") | Accept a new widget or helper without a "checked uikit / toolkit" note |
| Commit with `/com_commit`; review with `/com_review` | Let agents push, merge, or add `// ignore:` |
| Fresh session per feature | Carry a 200-turn conversation into the next task |

## 8. Review checklist for AI-authored changes

Run before reading the diff (`code_review.md` Workflow step 1 — a failure blocks):

```bash
fvm flutter analyze
fvm dart run custom_lint             # starter_lints, fatal on warnings / infos
fvm flutter test --concurrency 4
```

| Check | Rule / source |
|---|---|
| Scope matches the plan; differences are under "Deviations", not silent | `implementer` hard rules |
| Layers and DI: concrete repo over abstract DS, `configs/*_module.dart extends AppModule`, no BLoC → BLoC | `A1`-`A5`, `ARCH-3`…`ARCH-7` |
| Executor chain composed in the module from `const RawRepositoryExecutor().withErrorHandling()` | `repository_executor.md`, `EXC-4`, `ARCH-9` |
| BLoC: `@freezed sealed class`, catches `AppException`, `return emit`, past-tense events | `BLOC-2`…`BLOC-11` |
| New `AppException` has `@ExceptionUiConfig`, an ARB key, generator re-run; mapper not hand-edited | `EXC-1`, `EXC-2` |
| Strings via `Localizer`, colors via `ThemeProvider`, `starter_uikit` widgets reused | `A7`, `A8`, `UI-1`, `UI-3`, `UI-8` |
| New DS method has a `mock/` twin taking `MockNetworkBehavior`, backend-shaped errors; module uses `mockOrProd` | `M1`-`M10`, `TEST-6` |
| Feature-flow test: happy path + one failure state; no new per-repo test; no `wait:` for retry | `T1`, `T2`, `T6`, `TEST-3`, `TEST-5` |
| Fallback values registered for custom `any(named:)` types | `T5`, `TEST-2` |
| Naming: no `Impl` / `Helper` / `Manager`, file name == class name, class < 200 lines | `NAME-1`…`NAME-7`, `FILE-2` |
| Comments explain *why* only; `///` only on public `starter_*` APIs | `STYLE-1`, `STYLE-3`, `comment-rules` |
| No `// ignore:`, no suppressed lints, no scratch files or stale `work/` output | `/com_fix`, `/com_cleanup` |
| Commits: `type: Capitalized imperative` or `TICKET-ID: …`, ≤ 72 chars, one change each | `git.md` |

Verdict (`code_review.md` Workflow): approve only when every 🔴 is resolved and every 🟡 is fixed or carries a `TODO`
with its rule ID. `/com_review` writes this as `work/review.md`; the plan's Review Criteria are checked on top. Skip
`[lint]`-tagged rules — the analyzer owns them.
