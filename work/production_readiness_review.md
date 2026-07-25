# Production-Readiness Review — flutter_starter template

Synthesis of three explorer audits (DI/features, starter_uikit, toolkit/lints/codegen/CI),
plus one direct verification pass on CI test coverage. Severity labels adapt
`docs/ai-context/code_review.md`: 🔴 Blocking (must fix before calling the template
production-ready), 🟡 Should-fix (acceptable short-term debt if TODO'd with owner),
🟢 Suggestion. Rule IDs cited where a checklist rule directly applies.

---

## Verdict

**Not production-ready today, but close.** The gap is not size — it is that a template's
entire value proposition is "copy this pattern," and right now the template contradicts
its own patterns in several load-bearing places. A team copying it will faithfully
reproduce the contradictions.

**Minimum blocker set (6 items, all cheap):**

1. Identical placeholder `prodBaseUrl`/`devBaseUrl` — environment switching is a no-op
   and a missed override ships silently (B1).
2. Bloc DI wiring is self-contradictory: blocs registered in DI but constructed manually
   at their own call sites, and blocs used 4× that were never registered at all (B2).
3. Bare `catch (_)` in `auth_bloc.dart` swallowing all startup-auth exceptions —
   violates the project's own 🔴 EXC-3 rule in its flagship example (B3).
4. `starter_uikit` violates its own documented Material-icon ban in 3 widgets (F1).
5. CI silently never runs `test/core/di_graph_test.dart` and
   `test/uikit/uikit_widgets_smoke_test.dart` — existing tests, excluded by the shard
   paths; the DI-graph test is the one guard for the fragile module ordering (B4).
6. Stale uikit CHANGELOG/version — post-3.0.0 API changes (factory buttons, adaptive
   spinner) shipped with no entry or bump; downstream projects pin against a lie (F2).

**Explicitly *not* blockers, with justification:**

- **Zero tests in `starter_toolkit` / `starter_lints` / `starter_uikit`.** A coverage
  gap, not a correctness defect — nothing behaves wrongly because of it, and the app-side
  test suite (27 files, bloc + data-source + integration per feature) demonstrates the
  testing pattern the template exists to teach. It becomes a should-fix with one caveat:
  `starter_lints` at 0/19 tested *and* with four confirmed logic gaps is the riskiest of
  the three, because untested lints create a false sense of enforcement (T2).
- **No build-time flavor / dart-define mechanism.** The runtime-switchable
  `AppEnvironment` is a coherent (if debatable) design choice; it only becomes dangerous
  combined with B1. Fix B1, document the choice, and this is acceptable v1 design (S6).
- **Placeholder store URLs, `FirebaseConfig.enabled = false`.** Expected, intentional
  template scaffolding; the Firebase toggle is even commented as such.

Fix the six blockers — none requires design work, all are hours not days — and the
template is defensibly production-ready with the 🟡 items logged as tracked debt.

---

## (a) Fallacies — documented/claimed behavior that doesn't match reality

| # | Severity | Finding | Fix direction |
|---|---|---|---|
| F1 | 🔴 | uikit's own doc (`svg_icon.dart:7-8`) declares Material `Icon`/`Icons` forbidden; 3 uikit widgets use them anyway (1) | Add the 3 icons to `assets/icons/`, rerun spider, use `UiSvgIcons.*`; or scope the ban honestly in the doc |
| F2 | 🔴 | `starter_uikit` CHANGELOG `[3.0.0]` (2026-07-08) predates commit `0b3c3b4` which added factory-based buttons + adaptive spinner; no entry, no version bump | Add `3.1.0` entry covering `0b3c3b4`, bump `pubspec.yaml` |
| F3 | 🟡 | Green CI implies "tests pass"; two existing test files are structurally excluded from every run (see B4 — listed there as the soundness bug, here as the false claim) | Same fix as B4 |
| F4 | 🟢 | Doc-comment coverage in `widgets/text/` is inconsistent (full param docs vs none; redundant class/ctor duplication at `title_subtitle.dart:4-9`) — STYLE-3 applies to `starter_*` public APIs | One documenter pass over `widgets/text/` |

**(1)** `empty_information_body.dart:44` (`Icons.inbox_outlined`),
`app_text_field.dart:227`, `controller_text_field.dart:279` (both
`Icons.visibility`/`visibility_off`). Every other icon in the package correctly uses
`UiSvgIcons.*`, so these are the only three offenders — cheap to close.

---

## (b) Soundness bugs — real defects independent of documentation

| # | Severity | Finding | Fix direction |
|---|---|---|---|
| B1 | 🔴 | `prodBaseUrl` and `devBaseUrl` are the identical string `'https://example.com'` (`lib/core/global/core_consts.dart:12-13`) (2) | Distinct placeholder values (e.g. `api.example.com` / `api.dev.example.com`) + a startup assert or doc callout forcing replacement |
| B2 | 🔴 | Bloc DI is self-contradictory (3): `CalendarBloc`/`TasksListBloc` registered via `registerFactory` (`task_module.dart:45-48`) but constructed manually at their own screens (`calendar_screen.dart:29`, `tasks_list_screen.dart:29`); `TaskDeleteBloc` used in 4 UI sites, never registered; `AuthModule`/`ProfileModule` register no blocs at all | Pick ONE convention (RemoteConfigModule's register-and-resolve is the only end-to-end-correct example), apply it in all 5 features, delete dead registrations |
| B3 | 🔴 | `auth_bloc.dart:77-79` bare `catch (_)` swallows ANY exception during `_onInitialized`, silently falling back to `unauthenticated()` — no log, no distinction between "no token" and storage corruption. Direct EXC-3 (🔴) violation in the template's most-copied bloc | Catch `on AppException`, log, and either emit a distinguishable failure or document why unauthenticated-fallback is correct |
| B4 | 🔴 | **Verified:** CI shard matrix (`.github/workflows/ci.yml:67-77,93`) passes only `test/features/{application,settings,auth,profile,task}` to `flutter test`; explicit paths mean `test/core/di_graph_test.dart` and `test/uikit/uikit_widgets_smoke_test.dart` never run in CI. The DI-graph test is the sole guard for the module-ordering fragility in B5 | Add a `core+uikit` shard (or run `flutter test test/` in one shard); optionally add package-test steps once packages have tests |
| B5 | 🟡 | DI module order is load-bearing but unenforced: `DataModule` resolves `AppEnvironment` at registration time (`data_module.dart:71`) and references `AuthRepository` in closures registered before `AuthModule` runs (`data_module.dart:43-44,68`). Works today purely by list order in `app_configurator.dart:19-29` | Comment the ordering contract in `app_configurator.dart`; keep `di_graph_test` running in CI (B4) as the regression guard; consider `getIt.isRegistered` asserts in `DataModule` |
| B6 | 🟡 | `push_token_repository.dart:68-70` — `_postSafely` catches `AppException` at the repository layer and only logs, silently swallowing failures; every other repo propagates to the bloc | If fire-and-forget is intentional (plausible for push tokens — inference), say so in a WHY comment; otherwise propagate |
| B7 | 🟡 | `url_launcher_helper.dart:14-18` bare `catch (e)` with unused `e`, discarding original error/type, rethrowing a fixed `UrlLaunchFailedException()` | Pass the original error/stack into the exception (cause field) or log before rethrow |
| B8 | 🟡 | `NetworkImageAvatar` hardcodes `AppColors.pureWhite` for spinner + initial-letter text (`network_image_avatar.dart:50,58`) regardless of theme — bypasses semantic colors (UI-2 spirit, not letter) | Use the theme's on-surface/on-primary semantic color |

**(2)** Worse than an ordinary placeholder: because prod and dev are *identical*, the
entire `AppEnvironment` runtime-switching feature is undemonstrable in the template, and
a downstream team that replaces one const but not the other gets zero signal — dev
traffic to prod (or vice versa) with no visible difference at the call site.

**(3)** This is the single most misleading thing in the template. A developer opening
`TaskModule` sees four blocs registered and reasonably concludes "blocs go in DI"; a
developer opening `calendar_screen.dart` sees manual construction and concludes the
opposite. Both are "the example." Only `remote_config` is internally consistent
(`remote_config_module.dart:79-88`).

---

## (c) Structural/consistency gaps — patterns a copying developer will inherit

These matter more here than in a normal app: the template's product *is* the pattern.

| # | Severity | Finding | Fix direction |
|---|---|---|---|
| S1 | 🔴 | Bloc-wiring divergence — see B2; listed here because beyond the dead registrations it is a pattern-teaching failure across all 5 features | Same as B2 |
| S2 | 🟡 | Retry-policy divergence: `AuthModule`/`TaskModule` use `.withErrorHandling()` only; `Profile`/`Notifications`/`RemoteConfig` add `.withRetry(3, 2s)` — no comment explaining the split (4) | If deliberate (mutations vs idempotent reads — inference), add a WHY comment at each opt-out and a line in `docs/ai-context/exception.md`; otherwise unify |
| S3 | 🟡 | Lifecycle divergence: `TaskModule` uses `registerFactory` for data source/repository; every other feature uses `registerLazySingleton` — no stated reason | Pick one default, comment the exception if one is genuinely needed |
| S4 | 🟡 | `EnvironmentModule`/`SettingsModule`/`CoreModule` keep `requiresReconfiguration = false` (default, `app_module.dart:10`) and are skipped by `reconfigure` (`app_configurator.dart:62-68`); all other modules override to true. Likely intentional (env/settings must survive an env switch — inference) but nothing says so | One doc comment on `requiresReconfiguration` explaining the contract |
| S5 | 🟢 | Data-source naming: `auth`/`task`/`profile` use `remote_*`; `notifications`/`remote_config` use `firebase_*`/`api_*`. Note: `FirebaseMessagingDataSource` etc. actually *satisfy* NAME-6 (source-prefix-first) — the inconsistency is with siblings, not the rule | Acceptable as-is; a sentence in `docs/ai-context/rules.md` ("prefix = actual source: Remote/Api/Firebase/Local") would neutralize it |
| S6 | 🟡 | No build-time flavor/env mechanism (no `.env`, no `--dart-define`); backend URLs live as committed Dart consts fed to a runtime-switchable `AppEnvironment` (`app_environment.dart:13-35`) | Document the choice and its trade-off (URLs in binary, no per-build secrets) in `docs/`; safe only after B1 makes the values distinct |
| S7 | 🟢 | Magic consts `apiTimeoutSeconds=30`, `heightPerMinute=1.25` in `core_consts.dart` rather than env config | Fine for v1; move timeout to `AppEnvironment` if it should ever differ per env |

**(4)** Copying developers will cargo-cult whichever feature they open first. If the
split *is* principled (retrying a login/OTP POST is unsafe; retrying profile/config GETs
is safe), that is exactly the kind of judgment a template should teach explicitly — its
absence converts good design into apparent noise.

---

## (d) Test/CI gaps

| # | Severity | Finding | Fix direction |
|---|---|---|---|
| T1 | 🔴 | CI excludes existing tests (`test/core/`, `test/uikit/`) — see B4 (the fix); listed here for the coverage ledger | Same as B4 |
| T2 | 🟡 | `starter_lints`: 0/19 rules tested AND 4 confirmed logic gaps (5) — untested lints that silently miss cases create false confidence in `[lint]`-tagged rules that manual review then skips per `code_review.md` | Add rule tests for at least the 4 rules with known gaps, fixing the gaps as you go |
| T3 | 🟡 | `starter_toolkit`: no `test/` at all despite `flutter_test` dev-dependency — date/converter/form/version utils are pure functions, cheapest possible tests | Start with converters + date utils; a dozen table-driven tests covers most surface |
| T4 | 🟡 | `starter_uikit`: no `test/` directory despite `flutter_test` dev-dependency; only widget coverage anywhere is the app-side smoke test that CI doesn't run (B4) | Move/duplicate the smoke test into the package, add golden or pump tests for the button/text-field families |
| T5 | 🟡 | Strict lint job (`flutter-quality-strict`, fatal warnings) only runs on manual `workflow_dispatch` (`ci.yml:42`) — never on PRs, so warning-level lint debt accumulates unnoticed | Run it on PRs as non-required at first; ratchet to required |
| T6 | 🟡 | No screen/widget-layer tests for any feature; `profile` lacks a dedicated repository test (only indirect via integration) | Add one exemplar screen test in one feature (template teaches by example) + `profile` repo test |
| T7 | 🟢 | `utils/coverage.sh` computes per-layer coverage but always exits 0 and is not wired into CI — informational only | Fine as-is; if a threshold is ever wanted, wire it into CI with a modest floor rather than leaving it decorative |

**(5)** `no_hardcoded_colors.dart:33-60` misses raw `0xFF...` literals and non-prefixed
`Color` identifiers; `prefer_arrow_except_build.dart:36-52` requires `@override` to
recognize `build()`; `avoid_mutable_bloc_fields.dart:38-49` misses intermediate base
classes; `bloc_listener_builder_usage.dart:88-135` misses patterns nested in
`if`/`switch`/local declarations.

---

## Clean bill of health (worth stating — no manufactured findings)

- No secrets in the repo (only storage key names, `storage_keys.dart:9-10`).
- No TODO/FIXME/HACK/UnimplementedError in `lib/` or `starter_uikit`.
- Routing mirrors `lib/features/*` cleanly; no dead routes.
- spider codegen current: 27 icon constants ↔ 27 asset files, independently confirmed.
- Light/dark themes structurally symmetric (13/13 fields); en/ru ARB full key parity.
- No hardcoded colors outside theme except B8; no hardcoded English UI text.
- Exception-mapper generator output current; docs match both generators.
- SDK constraints consistent across all 4 pubspecs; `.fvmrc` and CI agree on `3.44.5`.
- Button family and adaptive spinner internally consistent in uikit.

---

## Suggested fix order

1. B1 (distinct URLs + guard) — minutes.
2. B4/T1 (CI shard for `test/core` + `test/uikit`) — minutes, restores the DI-graph guard.
3. B3 (auth_bloc catch) — under an hour.
4. F1 (3 icons → `UiSvgIcons`) — under an hour incl. spider run.
5. B2/S1 (unify bloc wiring across 5 features on the remote_config pattern) — the largest
   blocker, still bounded: 5 modules + ~8 call sites.
6. F2 (CHANGELOG + version bump) — minutes.
7. Then 🟡 items in the order B5, S2/S3 (comments or unification), B6/B7, T2–T6, S4/S6.
