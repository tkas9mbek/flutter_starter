# Documentation Quality Review — `docs/`

**Scope:** all 25 files under `docs/` (9 × `ai-context/`, 8 × `guides/`, 6 × `rules/`, 2 × `project/`), cross-referenced against `AGENTS.md`, `CLAUDE.md`, and the actual codebase state on `release/3.1.0`.

## Summary

The documentation set is large, ambitious, and in most places well-written — but it has **drifted into three inconsistent generations**:

1. **Oldest layer** (`docs/guides/architecture.md` §Testing, `docs/guides/exception_handling.md`, `docs/rules/naming.md` state examples, parts of `docs/rules/coding_rules.md`): predates the Freezed-3 migration, the mock-first testing rewrite, and API renames. References dead APIs (`UiLocalizer`, `FailureWidget.large(uiModel:)`, private state classes, Retrofit services).
2. **Imported layer** (`docs/guides/testing.md`): synced from `jetjat_mobile` (commit `47b611e`) without porting examples — it instructs covering widgets/blocs/fixtures that do not exist in this repo.
3. **Current layer** (`docs/ai-context/repository_executor.md`, `docs/guides/repository_executor.md`, `docs/rules/bloc.md`, most of `AGENTS.md`): matches the code.

The most dangerous property is that **the declared precedence rule points at the stale layer**: `AGENTS.md:9` and `AGENTS.md:212` say the full guides/rules "win" over the compact `ai-context/` files, yet in several verified conflicts (AppException shape aside) the guide is the wrong one. An agent that obeys the precedence rule faithfully will reintroduce dead APIs and forbidden test styles.

**Counts:** 9 High-severity findings (would actively mislead), 12 Medium, 8 Low.

---

## HIGH — would actively mislead a developer or AI agent

### H1. `AppException` is falsely described as a Freezed union; the "add an exception" recipe in `ai-context/exception.md` cannot compile
**Category:** best-practice violation (stale, fabricated API) + contradiction.

- `docs/ai-context/exception.md:16-20` instructs: add `@ExceptionUiConfig(messageKey: 'rateLimitedException', icon: 'timer_off') const factory AppException.rateLimited() = _RateLimitedAppException;`.
- **Reality:** `packages/starter_toolkit/lib/data/exceptions/app_exception.dart:9` is a *manual* `sealed class AppException implements Exception` with `final class NoInternetException extends AppException` subclasses (`:45`), each overriding `name` and `canRetry`. There are no Freezed factories.
- **Reality:** `packages/starter_toolkit/lib/data/exceptions/annotations.dart:6-21` — `ExceptionUiConfig` has only `titleKey` (optional), `descriptionKey` (required), `snackbarKey` (optional). `messageKey` and `icon` **do not exist**. `docs/ai-context/exception.md:10` also claims `ExceptionUiModel` carries an "icon" — `packages/starter_uikit/lib/models/exception_ui_model.dart` has no icon field.
- The same false "sealed Freezed" claim appears in `AGENTS.md:56` (rule A6), `AGENTS.md:77`, `docs/ai-context/architecture.md:24` (A6), and `docs/rules/coding_rules.md:432`.
- Ironically the *guides* (`exception_handling.md:16-53`, `architecture.md:399-441`) show the correct manual-subclass shape — but they are the docs labeled as stale elsewhere (see H3).

**Fix:** rewrite the "Adding a new exception" recipe in `ai-context/exception.md` around the real pattern (`final class X extends AppException` + `name`/`canRetry` overrides + real annotation params); replace "sealed Freezed" with "sealed class hierarchy" in AGENTS.md A6, `ai-context/architecture.md`, and `coding_rules.md`.

### H2. Four-way contradiction on testing doctrine (repository tests, integration mocking, retry `wait:`)
**Category:** internal contradiction (the worst in the set).

Mutually exclusive instructions, all currently live:

| Doc | Says |
|---|---|
| `docs/guides/testing.md:18` + `docs/ai-context/testing.md:22` (T1) | "**Do NOT write per-repository unit tests**" |
| `docs/guides/architecture.md:560-562` §Testing Strategy | "Data Layer Unit Tests (**Required for Repositories**): Repository (Real) → DataSource (Mock)" |
| `docs/rules/coding_rules.md:560-564` | Repository + DataSource unit tests with `ApiClient` mocks; "Integration \| Full stack \| ApiClient only" |
| `docs/guides/testing.md:402` | Anti-pattern: "Integration-test the `ApiClient` path with a full feature-flow slice" — integration wires the real `Mock*DataSource`, stubs nothing |
| `docs/guides/code_review.md:125` (TEST-5) + `docs/ai-context/code_review.md:100` | "Integration mocks **only `ApiClient`**. Everything else stays real." |
| `docs/guides/testing.md:59` + `ai-context/testing.md:28` (T6) | "`wait:` is for **debounce only** — never to sit through retry backoff" |
| `docs/guides/code_review.md:123` (TEST-3), `ai-context/code_review.md:98`, `coding_rules.md:571` | "`blocTest` … must set `wait` based on retry delay/retries (e.g. `8s` for `2s × 3`)" — exactly what testing.md calls an anti-pattern (`:398`) |

`AGENTS.md:133` (T6) even contradicts **itself in one sentence**: "`blocTest` `wait:` matches the retry config used (`~8s` for `2s×3` …) — never sit through retry backoff to assert a failure." Matching an 8-second `wait:` to the retry config *is* sitting through the backoff.

Note the shipped suite follows the *old* doctrine: per-repository unit tests exist (`test/features/task/data/task_repository_test.dart:16-40`, `test/features/auth/data/auth_repository_test.dart`, `test/features/settings/data/settings_repository_test.dart`) — so whichever direction is chosen, doc and suite must be reconciled explicitly rather than left ambiguous.

**Fix:** pick one doctrine (the mock-first one in `guides/testing.md` appears to be the intended current one), then rewrite `guides/architecture.md` §Testing Strategy, `coding_rules.md` §Testing, TEST-3/TEST-5 in both code-review docs, and the T6 sentence in AGENTS.md. Either delete the per-repo tests or document why they are grandfathered.

### H3. `docs/guides/exception_handling.md` documents a dead API surface
**Category:** best-practice violation (stale references, verified against code).

- `:88-121` and `:296-309` use `UiLocalizer` / `UiLocalizer.of(context)` — no such class exists anywhere (`grep UiLocalizer` → 0 hits). Actual: `UikitLocalizer` (`packages/starter_uikit/lib/utils/mappers/exception_ui_mapper.dart:12`).
- `:216-218` renders errors via `FailureWidget.large(uiModel: uiModel, …)` (also `guides/architecture.md:502-506`). Actual API: `FailureWidget.large({required AppException exception, onRetry})` (`packages/starter_uikit/lib/widgets/status/failure_widget.dart:16-19`) — it maps internally; UI never builds the `uiModel`.
- `:59-78` shows `ExceptionUiModel` with a `canRefresh` field (also `guides/architecture.md:451-457`) and `simple(canRetry = false)` default. Actual model (`exception_ui_model.dart`): no `canRefresh`; `snackbarDescription` is **required**; `simple` defaults `canRetry: true`.
- `:166-171` Step 2 says add the localization key to `lib/l10n/intl_ru.arb`. Wrong file and wrong base language: the exception keys are consumed by `UikitLocalizer`, so they live in `packages/starter_uikit/lib/l10n/intl_en.arb` (English base) — exactly what `coding_rules.md:461` and `ai-context/exception.md:21` correctly say.
- `:336-348` test example constructs `ExceptionUiMapper(MockBuildContext())` — the real constructor calls `UikitLocalizer.of(context)` in its initializer, so this snippet throws at runtime.

**Fix:** a targeted rewrite pass of this guide against the current `starter_uikit`/`starter_toolkit` sources; it is the "source of truth" doc for exceptions per AGENTS.md precedence, and nearly every code snippet in it is wrong.

### H4. `docs/guides/testing.md` still contains unported jetjat_mobile (food-delivery) content presented as instructions for *this* repo
**Category:** best-practice violation (stale/unported), borderline fabrication.

- `:315-329` — "**Cover these reused widgets**…" table: `RestaurantCard`, `OrderSummaryCard`, `PromoBanner`, `CourierCard`, `ProfileMenuTile`, `RatingInput`, `CuisineCarousel`, `OrderPlacedScreen`, `PaymentFailedScreen`. **None exist** in this repo (features are `application`, `auth`, `profile`, `settings`, `task`). An agent executing this checklist would try to test phantom widgets.
- `:347-357` — DI-graph example resolves `CheckoutBloc`, `FoodHomeBloc`, `SearchBloc`, `CourierChatBloc`, `OrderReviewBloc`, `AddressOnboardingBloc`, `RestaurantDetailBloc` — none exist.
- `:48` — `test/support/assets/` "shared cross-feature fixtures (cart, address, order, restaurant, promotion)" — the directory currently contains no such fixtures.
- `:388` — "logic layers (BLoC ≈ 90%, domain ≈ 70%)" states coverage numbers from the other project as fact about this one (unsupported claim presented as conclusion).
- `:192` — "Nested-status blocs (e.g. `FoodHomeBloc`, `SearchBloc`)… assert `state.visibleRestaurants`" — phantom types again.

**Fix:** keep the (good) methodology, replace every example with this repo's real types (`TasksListBloc`, `CalendarBloc`, `TaskDateGroupCard`, `SettingsCard`, …) or mark example blocks explicitly as "illustrative, from a reference app". Delete the coverage percentages or recompute them here.

### H5. `final` vs `var` for locals — AGENTS.md contradicts `ai-context/rules.md` and the analyzer config
**Category:** internal contradiction (verified against tooling).

- `AGENTS.md:148` (S6): "`var` for locals where the type is inferable." `AGENTS.md:191` (Common Issues): `omit_local_variable_types` → "Use `var` for locals."
- `docs/ai-context/rules.md:14` (S6): "Use **`final`** for locals by default; `var` only when the local is genuinely reassigned."
- **Tooling is the tiebreak:** `analysis_options.yaml:164` enables `omit_local_variable_types` *and* `:180` enables `prefer_final_locals` — so `var x = …` for a never-reassigned local is analyzer-flagged. AGENTS.md's version is wrong and its Common-Issues "fix" produces a new lint warning.

**Fix:** change AGENTS.md S6 and the Common Issues row to "drop the type annotation; prefer `final`".

### H6. State case-class visibility: two docs still teach the pre-Freezed-3 *private* states
**Category:** internal contradiction.

- `docs/rules/naming.md:178-184` and `:348-352` show `_InitialUserListState`, `_LoadingLoginState`, `_SuccessLoginState` … as the correct pattern.
- `docs/ai-context/rules.md:37` naming table: "**Private state class** | `_${Status}${Feature}State` | `_LoadingLoginState`".
- Everything else — `docs/rules/bloc.md:10`, `docs/ai-context/bloc.md:8`, `AGENTS.md:102`, BLOC-9 in both code-review docs, and the actual code — mandates **public** state case classes (`SuccessLoginState`) with private *event* classes, precisely because Freezed 3 pattern-matching needs public cases. `naming.md` is listed as a source doc for `ai-context/rules.md`, so the stale table row was faithfully copied from a stale source.

**Fix:** update the two naming examples in `naming.md` and the table row in `ai-context/rules.md` to public states / private events.

### H7. `coding_rules.md` contradicts itself twice within one file
**Category:** internal contradiction.

1. **`getIt` in repositories.** `docs/rules/coding_rules.md:61`: "`GetIt.I` … allowed only in widgets, screens, and routes. **Never** in data, domain, or BLoC code." But `:531` (§Data Layer): "Repositories call `getIt<ApiClient>()`." That is a domain-layer service-locator call the same file forbids — and also wrong architecturally: repositories never see `ApiClient` at all; *data sources* receive it via constructor in the DI module (e.g. `lib/features/profile/configs/profile_module.dart`).
2. **`Module` suffix.** `:113` forbids the suffix `Module`, while `:65` (and ARCH-6, `structure.md:157`, and the entire codebase: `AuthenticationModule`, `NotificationsModule`, …) *mandate* `configs/{feature}_module.dart extends AppModule`.

**Fix:** rewrite `:531` as "Data sources receive the typed `ApiClient` via constructor injection; never construct Dio ad-hoc"; scope the `Module` prohibition to non-DI classes.

### H8. Commit-type rules contradict the repo's own history (and the `/com_commit` pipeline consumes them)
**Category:** contradiction between doc and enforced practice.

- `docs/rules/git_workflow.md:79` / `docs/ai-context/git.md:28`: `type ∈ {feature, fix, refactor, research, release}`; `git_workflow.md:110` explicitly marks `feat: Add dark mode` as **Bad**.
- Actual recent history on this repo: `47b611e docs: Sync applicable docs…`, `8cdb01d style: deep-format pass…`, `813e58b feat(starter_lints): port 6 advisory rules…` — three commits using types (`docs`, `style`, `feat`, and a scoped `feat(...)`) the doc forbids.
- `CLAUDE.md` routes `/com_commit` through "docs/ai-context/git.md format", so an agent either violates the doc or renames types the team actually uses.

**Fix:** either extend the allowed set (`docs`, `style`, `test`, `chore`, allow scopes) or state that history predating the rule is exempt and enforce going forward. Currently the doc reads as aspirational while pretending to be descriptive.

### H9. The precedence rule ("full guide wins") is inverted relative to actual freshness
**Category:** logical/structural flaw (systemic).

`AGENTS.md:9`: "`docs/guides/` + `docs/rules/` — … Source of truth if anything here conflicts." `AGENTS.md:212`: "If a rule here conflicts with a full guide, **the guide wins** — flag it." `docs/ai-context/README.md:4-5` repeats it.

But in the verified conflicts above, the *guides* are the stale side in H2 (architecture guide's testing section), H3 (exception guide), and partially H6 (naming rules). Following the stated precedence *causes* the regressions: an agent resolving `wait: 8s` vs "debounce only" is told to trust `code_review.md`/`coding_rules.md` over `ai-context/testing.md`. A precedence rule is only safe when the privileged layer is actually maintained.

**Fix:** either (a) fix the guides so the rule holds, or (b) change the precedence statement to "current code + `ai-context/` win; guides are narrative background" until the guides are re-synced. Do not leave the current inversion.

---

## MEDIUM

### M1. ARCH-4 as written is violated by every DI module
`docs/ai-context/code_review.md:23` / `docs/guides/code_review.md:33`: "`getIt`/`GetIt.I` only in widgets / screens / routes." Every `configs/*_module.dart` registration closure calls `getIt<…>` (e.g. `lib/features/profile/configs/profile_module.dart:33-35`), and `ai-context/bloc.md:17-19` *requires* it. The rule needs "…and DI-module registration closures" or it is unenforceable/false. **Category:** ambiguous rule / contradiction.

### M2. Estimation guide's false publish-step claim, silently corrected only in the compact file
`docs/guides/estimation.md:124`: "`starter_*` updates **always trigger a publish step**." The packages are pub-workspace members, never published — which `docs/ai-context/estimation.md:55-56` explicitly says ("not published — but still cost codegen…"). The "source" doc keeps the falsehood; the derived doc fixed it. Textbook drift of duplicated content. **Fix:** port the corrected wording back into the guide.

### M3. `structure.md` package trees don't match the packages
`docs/guides/structure.md:117-122` shows `starter_toolkit/lib/` = `extensions/`, `utils/`, `validators/`. Actual: `configs/`, `data/` (client, exceptions, executors, cache, models), `l10n/`, `utils/` — no `extensions/` or `validators/` directories (validators are `utils/form/form_validators.dart`). `:129-134` shows `starter_uikit/lib/` = `theme/`, `widgets/` only; actual also has `models/`, `utils/`, `l10n/`, `resources/`, `example/`. The toolkit tree omits the package's *primary* content (the data/client/exception infrastructure the whole architecture depends on). **Category:** stale reference.

### M4. Doc-comment example uses a deleted class
`docs/rules/code_formatting.md:590-593` illustrates public-API docs with `class RetriableRepositoryExecutor extends RepositoryExecutor` — a class that exists nowhere in the codebase and is listed as deprecated in `AGENTS.md:194`. Replace with `RetryExecutor`. **Category:** stale reference.

### M5. Retrofit "Service" naming section describes an architecture this project doesn't have
`docs/rules/naming.md:273-293` prescribes `@RestApi()` Retrofit services (`UserService`, `TaskService`). Zero `@RestApi` usages exist; the documented data layer is `ApiClient` + `Api*DataSource` (and a service layer would bypass ARCH-5). A reader could reasonably introduce a Retrofit service citing this section. Similarly `docs/rules/code_formatting.md:85-87` "fixes" an SRP violation by splitting a repository into `ItemDeletionService` / `ItemSearchService` — types that fit no documented layer. **Category:** contradiction with architecture docs + stale content.

### M6. Arrow-syntax exception lists disagree, and one lint tag names a non-existent lint
- `docs/rules/code_formatting.md:374-377` gives **three** exceptions to `=>` (build, nested callbacks, `if-case` listeners); `AGENTS.md:149` (S4), `ai-context/rules.md:12`, and UI-6 list only **two**. The listener case matters in practice (every `BlocListener` per the docs' own examples).
- `docs/rules/coding_rules.md:209` tags the rule `[lint: prefer_arrow_except_build_and_nested]`; the actual lint file/name is `prefer_arrow_except_build` (`packages/starter_lints/lib/src/lints/prefer_arrow_except_build.dart`), which `coding_rules.md:651`'s own table uses. **Category:** contradiction / stale tag.

### M7. AGENTS.md S4's parenthetical reads as endorsing the pattern it forbids
`AGENTS.md:149`: "Arrow `=>` always, except `build()` and nested callbacks (`() => setState(() {})`)." The parenthetical *shows the arrow form* as the illustration of the exception — easily parsed as "this form is the sanctioned exception style", when `code_formatting.md:406-418` says the opposite (nested callbacks must use block bodies; `() => setState(() => _counter++)` is Wrong). Same wording in `ai-context/rules.md:12`. **Category:** ambiguous rule. **Fix:** "except `build()` and nested callbacks (write `onPressed: () { setState(() {…}); }`, never arrow-in-arrow)".

### M8. Severity taxonomies differ between the two code-review docs
`docs/guides/code_review.md:5-10` defines four levels (🔴 Blocking, 🟡 Mild, 🟢 Suggestion, 💬 Comment) plus a "Finding Types" table; `docs/ai-context/code_review.md:7-11` has only three and no finding types. A review produced from the compact file can't express 💬 findings the guide requires for commit/branch-naming issues. **Category:** drifted duplication.

### M9. `guides/architecture.md` BLoC example violates the project's own BLoC rules
`docs/guides/architecture.md:164-183`: public event case class (`UserListRequested` — must be `_RequestedUserListEvent` per BLOC-9/`rules/bloc.md:10`), no blank line before `emit` (BLOC-12), no `return emit(...)` on final emit (BLOC-11). As the flagship architecture example it teaches three rule violations at once. Same file's §Data Flow snippet (`:310-314`) repeats it. **Category:** internal contradiction (doc vs its own conventions).

### M10. `debugPrint` recommended under "Data Layer" headings would trip the layer lint
`docs/rules/coding_rules.md:536-541` and `docs/rules/code_formatting.md:626-635` (§"Data Layer → No `print()`") recommend `debugPrint(...)` — a `package:flutter/foundation.dart` symbol. In actual `data/`/`domain/` files that import is an ERROR under `no_flutter_in_data_domain` (`coding_rules.md:638`). The advice is fine for UI code but is filed under a Data-Layer heading. **Fix:** recommend `dart:developer` `log()` for data/domain; `debugPrint` only in presentation. **Category:** best-practice contradiction.

### M11. Test-layout claims vs actual suite
`docs/ai-context/testing.md:39` and `guides/testing.md:37-43` present `widget/` per feature as standard; the suite has **no** per-feature widget-smoke dirs (only `test/uikit/uikit_widgets_smoke_test.dart`), while it *does* contain the per-repo `data/*_repository_test.dart` files the same docs ban (H2). The "Layout" section describes an aspirational tree as if it were the current one. **Category:** stale/aspirational presented as descriptive.

### M12. `naming.md` event-naming example contradicts the project's actual event pattern
`docs/rules/naming.md:367`: fix `UserFetchEvent` → `UserRequestedEvent`. The project pattern everywhere else (and in `naming.md:164-166` itself) is `_{Verb}{Feature}Event` → `_RequestedUserEvent`. The "good" example teaches a shape that would fail review under BLOC-9. **Category:** internal inconsistency.

---

## LOW

### L1. "States are nouns" rule is enforced by example list, not by its stated principle
`docs/rules/naming.md:175-188`: rationale "states represent snapshots → nouns", then allows `initial`/`loading` and bans `loaded`/`succeeded`. "Loading" is no more a noun than "loaded"; the actual rule is "use the canonical four names", which the doc should just say. **Category:** weak reasoning (rationale doesn't derive the rule).

### L2. "Why? Better performance" for widget classes over functions
`docs/rules/code_formatting.md:352`: "Better performance, cleaner code, easier testing" asserted without mechanism. The real, defensible reason (element identity / rebuild granularity / const-ability) is never stated; as written it's an appeal to folklore. One sentence would fix it. **Category:** unsupported claim.

### L3. `ai-context/exception.md:32` — "throw directly inside the data source" example says `AppException.notFound()`
No `notFound` factory/subclass exists; the closest real pattern is `ServerException(statusCode: 404, …)` (used correctly in `coding_rules.md:553`). Minor fabricated-API echo of H1. 

### L4. Generator's own header comment propagates the Freezed myth
`utils/generators/generate_exception_mapper.dart:88` — "Analyzes AppException **Freezed** class" (it analyzes a plain sealed hierarchy). Code comment, but it's the likely origin of H1's doc error; worth fixing together.

### L5. `guides/freezed_bloc.md:10` review row points to `./code_review.md` "BLOC-* rules"
Correct target (`docs/guides/code_review.md`) — fine — but the table advertises "BLOC-*" rule IDs that the guide shares with `ai-context/code_review.md`; the two disagree on severity vocabulary (M8). Cosmetic once M8 is fixed.

### L6. `docs/guides/architecture.md:292` — "Domain Model (via Freezed @JsonSerializable)"
Conflates two packages; models use Freezed + `json_serializable` through `fromJson`/`toJson`. Cosmetic.

### L7. `docs/ai-context/README.md:13` points to `work/project-overview.md` "when present"
Not present; the sentence hedges correctly, but as the second link in the entry-point doc it wastes agent attention. Consider dropping.

### L8. `AGENTS.md:14` "Flutter 3.44.5" — currently correct (`.fvmrc`), but hard-coded in three places
(`AGENTS.md`, `docs/project/engineering-context.md:12`; template comment). Recommend "see `.fvmrc`" in all but one place to prevent the next drift.

---

## Verification notes

Every "does X exist" claim above was checked against the working tree, not inferred: `AppException`/`ExceptionUiConfig`/`ExceptionUiModel`/`FailureWidget` sources read directly; `UiLocalizer`, `@RestApi`, `RetriableRepositoryExecutor`, `CheckoutBloc` et al. grepped repo-wide (0 hits each); lint filenames globbed in `packages/starter_lints/lib/src/lints/` (19 files — `coding_rules.md`'s "All 19 lints" count is **correct**); `analysis_options.yaml` read for `prefer_final_locals`/`omit_local_variable_types`/`page_width: 80` (the 80-char and lint-name claims in `code_formatting.md` are **correct**); `utils/coverage.sh` and `utils/generators/generate_exception_mapper.dart` exist (**correct**); `withRetry` consumers are exactly `ProfileRepository`, `PushTokenRepository`, `RemoteConfigRepository` and `RepositoryCache` has no consumer (`ai-context/architecture.md:30` is **accurate**); `otp_bloc.dart`, `tasks_search_bloc.dart`, `remote_configs_bloc.dart`, `task_creation_bloc.dart` all exist (`ai-context/bloc.md` refs **accurate**).
