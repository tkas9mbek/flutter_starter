# Estimation — AI Context

Concise rules. Full guide: [../guides/estimation.md](../guides/estimation.md).

## Base unit (1 SP)

| Unit | Includes |
|---|---|
| Vertical slice | 1 data-source method + repo method + 1 BLoC event/handler + 1 UI action |
| Display screen | 1 route + 1 screen rendering only constructor / route data |

## Flow

1. State the outcome in one sentence.
2. Split into vertical slices or display screens.
3. Count base SP (1 per slice / screen).
4. Add modifiers.
5. Round to Fibonacci: `1, 2, 3, 5, 8, 13`.

## Modifiers

| Factor | Add |
|---|---:|
| Extra BLoC event/handler in same slice | `+0.5` |
| Extra screen in the same flow | `+1` |
| New Freezed model (5+ fields or nested mapping) | `+0.5` |
| New `AppException` factory + codegen run | `+0.5` |
| Cross-package update (`starter_*`) | `+0.5` per package |
| Complex widget composition (multiple `BlocBuilder` / `BlocListener`) | `+1` |
| Pure codegen run | `+0` |

## Mapping

| SP | Scope |
|---:|---|
| 1 | One slice, or one passive display screen |
| 2 | Two slices, or one slice with moderate state handling |
| 3 | One feature-level screen (list / action / error / loading) |
| 5 | Multi-step feature, several events / states |
| 8 | Cross-package feature with multiple BLoCs / screens |
| 13 | Refactor / migration — likely should split |

## Don't count

Formatting / lint, file renames, import-only updates, pure codegen, test implementation (estimate separately).

## Limit

A single phase ≤ **21 SP**. Above that → split into independently deliverable phases.

## Pitfalls

1. Counting by file count instead of behavior.
2. Ignoring UI state-management complexity.
3. Underestimating cross-package changes (`starter_*` always triggers a publish step).
4. Skipping the Fibonacci rounding.
