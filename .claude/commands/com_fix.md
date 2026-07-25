---
description: Fix all analyzer errors in the app and every package under packages/, including custom starter_lints issues
---

Fix every analyzer error in the root app and every project under `packages/`
(`starter_toolkit`, `starter_uikit`, `starter_lints`).

1. Enumerate all Dart projects (directories containing pubspec.yaml): the repo root
   plus everything under `packages/`. Run `fvm flutter analyze` covering all of them;
   run `fvm dart run custom_lint --no-fatal-infos --no-fatal-warnings` where the
   starter_lints rules only surface that way.
2. Fix all errors. Fix warnings and custom-lint issues where the fix is mechanical;
   list the rest instead of guessing.
3. Re-run until clean or until remaining issues need my decision.

Rules: fix causes, not symptoms — no `// ignore:` and no rule suppression unless I ask.
No reformatting of files you didn't fix. Do not commit.

Report per project: found → fixed → remaining, with file:line + rule + why for each
remaining issue.
