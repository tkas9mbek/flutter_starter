---
description: Remove temp artifacts (work/, logs, scratch) and unused files/imports/vars/dead code. No arg → branch-changed files; arg → a directory.
argument-hint: [directory, optional]
---

Clean up temporary artifacts and dead code. Argument: "$ARGUMENTS"

Resolve the code-cleanup scope:
- Empty → files changed in this branch: `git diff --name-only main...HEAD` plus uncommitted
  changes; fall back to `origin/main` if local `main` is stale and say so.
- A directory path → all files under it.

Run two passes.

## 1. Temp artifacts (repo-wide — these are never source, ignore the scope)

- `work/` in this repo is TRACKED and holds real survey/reference docs (check
  `git ls-files work/` first) — never delete tracked files here. Only remove files
  under `work/` that are untracked (`git status --porcelain work/` shows `??`) AND
  clearly stale AI scratch output (old plans/reviews from a finished, unrelated task).
  When in doubt, list the file for me instead of deleting it.
- Delete junk regardless of tracking: `.DS_Store`, stray `*.log` (e.g.
  `custom_lint.log`), scratch/fixture files you or agents left behind
  (`*_fixture.dart`, temp scripts) — confirm via `git status` that each is untracked
  before removing.
- List exactly what you removed, and confirm each was untracked.

## 2. Unused code (within the scope only)

- Run `fvm flutter analyze` (+ `fvm dart run custom_lint` in affected packages) and
  remove analyzer-confirmed dead code: unused imports, unused local variables, unused
  private fields/elements, unreachable/dead code, empty stubs and backwards-compat
  aliases (see `docs/ai-context/code_review.md` STYLE rules). These are mechanical —
  remove them.
- Unused whole FILES: before deleting, grep the entire repo for imports of the file and
  references to its public symbols. Delete only when there are **zero** references anywhere.
  Watch for indirect use — auto_route routes, `@Injectable`/`@LazySingleton`/`AppModule`
  DI registration, and generated code (`*.g.dart`, `*.freezed.dart`, `*.gr.dart`) can
  reference a file you won't find by import alone.
- Re-run `fvm flutter analyze` over the scope to confirm nothing broke.

## Rules

- Never touch files outside the scope (the temp pass is the only exception).
- Never remove public API, app entry points, or generated files (`*.g.dart`,
  `*.freezed.dart`, `*.config.dart`, `*.gr.dart`, `*.mocks.dart`).
- No `// ignore:`. Do not commit.
- When a whole-file deletion is judgment-heavy (any doubt about references), list it for
  me instead of deleting.

Report: temp/artifacts removed, unused code removed (file:line + what), files deleted (with
the zero-reference evidence), and anything left for my decision.