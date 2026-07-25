---
description: dart analyze + dart format on branch-changed files, or on the given path/description. Includes custom starter_lints issues.
argument-hint: [path or description of scope, optional]
---

Format and analyze a scoped set of files. Argument: "$ARGUMENTS"

Resolve scope:
- Empty → files changed in this branch: `git diff --name-only main...HEAD -- '*.dart'`
  plus uncommitted changes; fall back to `origin/main` if needed and say so.
- A path → all Dart files under it.
- A description → resolve to concrete paths, STATE the resolved paths, then proceed;
  ask only if genuinely ambiguous.

Then: `fvm dart format` on the set → `fvm flutter analyze` covering it → include
starter_lints findings (`fvm dart run custom_lint` in affected packages if needed) →
fix findings within the scoped files only → re-run to verify.

Never touch files outside the scope; mention out-of-scope issues in the report instead.
No `// ignore:`. Do not commit.

Report: formatted files, fixed issues, remaining issues (file:line + rule),
out-of-scope issues noticed.
