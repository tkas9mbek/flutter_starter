# Story Point Estimation Guide

> Goal: estimate implementation effort consistently, not perfectly.

This guide assumes the project layout in [structure.md](./structure.md) (data → domain → ui with BLoC) and the BLoC patterns in [freezed_bloc.md](./freezed_bloc.md). If your slicing differs, adjust the modifiers — the framework still applies.

---

## Base Rule: 1 SP

Use **1 SP** as one complete, testable unit of development:

| Unit type | Includes |
|---|---|
| **A. Vertical slice** | 1 data-source method + repository method + 1 BLoC event/handler + 1 small UI action |
| **B. Simple display screen** | 1 route + 1 screen that only renders constructor / route data (no BLoC integration) |

### Vertical Slice (A) in practice

```
data/         : 1 data-source method (API call or local data method)
domain/       : 1 repository method delegating to the abstract data source
ui/bloc/      : 1 event + 1 handler
ui/widget/    : 1 small interactive element (button / toggle / item action)
```

If all of the above are needed for one user action, count it as **1 SP** before modifiers.

---

## Estimation Flow (use every time)

1. Define the outcome in one sentence.
2. Split work into vertical slices or simple screens.
3. Count base SP — 1 SP per slice / screen.
4. Add complexity modifiers.
5. Round to Fibonacci: `1, 2, 3, 5, 8, 13`.

---

## Complexity Modifiers

| Factor | Add |
|---|---:|
| Additional BLoC event / handler in the same slice | `+0.5` |
| Additional screen in the same feature flow | `+1` |
| New Freezed model (5+ fields or nested mapping) | `+0.5` |
| New `AppException` factory + codegen run | `+0.5` |
| Cross-package update (`starter_toolkit`, `starter_uikit`, `starter_lints`) | `+0.5` per package |
| Complex widget composition (multiple `BlocBuilder` / `BlocListener`) | `+1` |
| Pure code generation run (`build_runner` only) | `+0` |

---

## Worked Example 1 — Small (2 SP)

Task: Add a "Freeze card" action on the card details screen.

| Item | Count |
|---|---:|
| Vertical slice for freeze action (data source + repository + BLoC handler + button) | `1.0` |
| One extra BLoC event (`freezeStatusRequested`) | `+0.5` |
| Reactive state handling on existing screen (loading / error / success) | `+0.5` |
| **Raw total** | `2.0` |
| **Final estimate (Fibonacci)** | **2 SP** |

Why 2 SP: one primary slice plus extra state flow and UX states beyond a single fire-and-forget button.

---

## Worked Example 2 — Medium (5 SP)

Task: Add transaction filters (date + amount + status) with paginated API support.

| Item | Count |
|---|---:|
| Slice 1 — fetch filtered data (data source / repo / BLoC handler) | `1.0` |
| Slice 2 — apply / reset filter action handling | `1.0` |
| Extra BLoC events (`filterChanged`, `filterApplied`) | `+1.0` |
| New Freezed model (`TransactionFilterParams`) | `+0.5` |
| Complex UI state sync (filters + pagination + empty / error) | `+1.0` |
| Cross-package update (shared filter widget in `starter_uikit`) | `+0.5` |
| **Raw total** | `5.0` |
| **Final estimate (Fibonacci)** | **5 SP** |

Why 5 SP: multiple slices plus synchronization complexity between filters, pagination, and UI states.

---

## Quick Mapping Reference

| SP | Typical scope |
|---:|---|
| 1 | One simple vertical slice or passive display screen |
| 2 | Two simple slices, or one slice with moderate state handling |
| 3 | One feature-level screen (list / action / error / loading) |
| 5 | Multi-step feature or medium-complexity flow with several events / states |
| 8 | Complex cross-package feature with multiple BLoCs / screens |
| 13 | Large refactor / migration that should likely be split |

---

## What Not to Count

- Formatting / lint-only changes
- File renames without behavior change
- Import-only path updates
- Pure codegen execution (`build_runner`, `intl_utils`, exception generator)
- Test implementation (estimate separately if your process tracks testing independently)

---

## Phase Limit

A single phase should not exceed **21 SP**.
If the estimate is above 21, split into independently deliverable phases.

---

## Common Mistakes

1. Counting tasks by file count instead of behavior.
2. Ignoring state-management complexity in the UI.
3. Underestimating cross-package changes (`starter_*` updates always trigger a publish step).
4. Not rounding to Fibonacci — gives false precision.

---

## Final Checklist

1. Is each SP tied to user-visible behavior?
2. Did you include BLoC / state-complexity modifiers?
3. Did you include cross-package impact?
4. Did you round to Fibonacci?
5. Is each planned phase independently testable?
