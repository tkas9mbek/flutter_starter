# Docs sync from jetjat_mobile — architecture deltas not adopted

`jetjat_mobile` (a sibling app originally forked from this starter) has diverged in a few places
beyond naming. When syncing applicable docs into `flutter_starter` for the 3.1 release, the
following jetjat-only decisions were **deliberately not adopted** — they describe code that does
not exist in `flutter_starter` today, or contradict this project's current, verified behavior.
Flagged here as candidates for a future, explicit decision — not silently applied.

## 1. `AppException`: sealed Freezed vs. concrete class hierarchy

flutter_starter still uses `sealed class AppException implements Exception` with Freezed-style
factories (verified in `packages/starter_toolkit/lib/data/exceptions/app_exception.dart`).
jetjat_mobile moved to a plain `sealed class` hierarchy of `final class ... extends AppException`
with no Freezed factories. Docs referencing "sealed Freezed" for `AppException` were left
unchanged (`docs/rules/coding_rules.md`, `docs/guides/architecture.md`, `docs/ai-context/architecture.md`,
`docs/guides/exception_handling.md`, `docs/ai-context/exception.md` — the latter two were skipped
entirely).

## 2. Freezed pattern-matching convention: `switch`/`if-case` vs. `maybeMap`/`whenOrNull`

flutter_starter's actual code (e.g. `lib/features/auth/ui/register/screen/registration_screen.dart`)
uses Freezed 3 exhaustive `switch (state)` / `if-case` pattern matching, and the docs say so
explicitly ("Freezed 3 removed the generated `whenOrNull`/`maybeMap` methods"). jetjat_mobile's
docs teach the opposite — `maybeMap`/`maybeWhen`/`mapOrNull`/`whenOrNull` — implying a different
Freezed major version or a reverted convention. This is a hard divergence, not a wording tweak.
None of that content was copied. If the two apps are meant to converge on one pattern-matching
style, that needs an explicit decision (and a real migration), not a docs sync.

## 3. Pagination primitives

jetjat_mobile ships `PaginatedData<T>`, `BlocLoadState`, `PaginatedListView`/`SliverPaginatedListView`,
and `RefreshableBloc` in `jetjat_toolkit`/`jetjat_uikit`, plus `docs/guides/pagination.md` and
`docs/ai-context/pagination.md` describing them. None of these exist in `starter_toolkit`/
`starter_uikit`. Not copied — the guides would describe code that doesn't exist. Worth
considering as a real feature addition (toolkit/uikit code + tests + docs together) if/when a
flutter_starter-based app needs infinite scroll.

## 4. Freezed query models + pagination-driven ARCH rules

jetjat's `ARCH-9`/`ARCH-10` ("list endpoints take a Freezed query model", "no pagination constants
in data sources") and the architecture.md DTO-escape-hatch note are tied to the pagination work
above and to jetjat's own endpoints (e.g. `RestaurantsQuery`). flutter_starter has no `*Query`
models or DTOs today (verified via grep). Not copied.

## 5. `docs/project/product-context.md` / `engineering-context.md`

jetjat_mobile's versions are filled in with its own business content (food delivery in Bishkek,
its Figma file, its feature list). flutter_starter's versions are intentionally empty fill-in
templates for whoever starts a new app from the starter — left as-is.

## What WAS applied

Naming (`naming.md`), structure (`structure.md`), code review severity labels, several `rules.md`/
`coding_rules.md`/`code_formatting.md` clarifications that matched flutter_starter's *actual*
current code (two-file BLoC split, 80-char `dart format` page width, `SvgIcon`/form-UI-model
conventions, `final`-by-default, workspace-pubspec no-version-constraints, `RepositoryCache`
adoption status), and the `Remote*DataSource` → `Api*DataSource` rename throughout code and docs.
See the `release/3.1.0` branch diff for the full set.
