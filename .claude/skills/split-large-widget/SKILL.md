---
name: split-large-widget
description: Extract an oversized screen/widget file in this repo into separate widget/ files, per the <200-line UI ceiling in docs/rules/code_standards.md.
---

Applies AGENTS.md's Style Rule: "Keep classes near 100 lines; split by 200 lines." This is a
pure extract-to-file refactor — no behavior, layout, or styling change, ever.

## When to use

A screen or widget file under `lib/features/{feature}/ui/{subfeature}/screen|widget/` (or a
`packages/starter_uikit` widget) is over ~150-200 lines, usually because it has one or more large
private (`_Foo`) classes or a large inline `build()` subtree that should be its own class per
AGENTS.md's UI rule "Do not create widget-returning helper functions; extract widgets."

## Procedure

1. Read the target file in full. Identify the large private classes (or `build()` subtrees that
   should be classes) — these become the extraction candidates.
2. For each candidate, create a new file under the sibling `widget/` directory (e.g.
   `lib/features/task/ui/details/widget/task_status_badge.dart`), named in snake_case matching the
   class name. Make the class top-level and non-private (drop the leading `_`) unless there's a
   clear reason to keep a small helper co-located and private inside its consumer.
3. Wire constructor params for whatever the moved widget needs that it no longer has direct access
   to (parent state, callbacks, models) — pass them in explicitly.
4. Preserve `BuildContext`/`context.read<...>()` calls exactly; verify the bloc/provider is still
   reachable from the new widget's position in the tree (it usually is, since extraction doesn't
   change the actual widget tree structure, only which file declares which class).
5. The screen file should end up focused on scaffold/bloc-wiring/orchestration — ideally ~100-150
   lines, definitely under 200. If an extracted widget is itself still large, split it further
   rather than producing one new oversized file.
6. Follow this repo's conventions throughout: package imports only (no relative imports), single
   quotes + trailing commas, `=>` preferred except `build()`, no widget-returning helper functions.

## Verification

- `fvm flutter analyze` — must be clean.
- `fvm flutter test` for whatever covers the touched screen(s) (`grep -rln <ScreenClassName> test/`)
  — fix breakage caused by the move (e.g. a test constructing a formerly-private widget directly).
- `dart format` on every touched/created file.
- Report final line counts of every touched/created file.

## Known gotchas from prior runs

- If two sibling subfeatures each have their own `widget/` directory (`ui/details/widget/` vs
  `ui/list/widget/`), don't cross-mix — extracted files belong in the SAME subfeature's
  `widget/` dir as their consumer.
- A widget genuinely shared across subfeatures/features (e.g. a status badge used by both a list
  screen and a details screen) may not belong in either consumer's own `widget/` dir — check
  actual usage before deciding its final home; don't force it into whichever file you happened to
  extract it from first.
- If a `StatefulWidget` manages a real platform resource (map controller, animation controller,
  stream subscription), keep it a `StatefulWidget` after the move — don't accidentally flatten it
  to `StatelessWidget` during extraction.
