# Sync from jetjat_mobile — Crashlytics, CI/CD, docs split, example screens, Claude tooling

Source of truth for "what to copy" was already gathered by prior research in this session (not
re-derivable from `work/docs-jetjat-architecture-deltas.md` alone, which only covers the earlier
3.1.0 docs sync and explicitly does NOT cover this scope). Read `/Users/admin/Documents/GitHub/jetjat_mobile`
files directly for exact reference content — this plan gives file paths and the adaptation rules,
not full verbatim dumps.

**Hard constraint carried over from `work/docs-jetjat-architecture-deltas.md`**: flutter_starter uses
Freezed 3 exhaustive `switch`/`if-case` pattern matching — NOT `maybeMap`/`whenOrNull`/`mapOrNull`.
jetjat_mobile's docs teach the opposite convention. Any rule text ported from jetjat that mentions
`maybeMap`/`whenOrNull`/`mapOrNull` (e.g. `code_standards.md` Widget Rules items 3-4,
`bloc_listener_builder_usage` lint description) must be dropped or rewritten to flutter_starter's
actual `switch`/`if-case` convention — never copied verbatim. When in doubt, grep flutter_starter's
actual `lib/` code for the real pattern before writing a rule about it.

Flutter is already pinned to 3.44.5 in `.fvmrc` — no version bump needed. Verify no stale version
reference slipped into new docs/workflows (should all say 3.44.5).

---

## Workstream A — Crashlytics

**Files to add:**
- `packages/starter_toolkit/lib/utils/crash/crash_reporter.dart` — port
  `jetjat_mobile/packages/jetjat_toolkit/lib/utils/crash/crash_reporter.dart` verbatim in structure
  (abstract `CrashReporter`, `NoopCrashReporter`, `FirebaseCrashReporter`, top-level mutable
  `crashReporter` defaulting to `NoopCrashReporter`). Rename nothing else — the abstraction is
  already generic.

**Files to edit:**
- `pubspec.yaml` (root) — add `firebase_crashlytics: ^5.3.0` to `dependencies`, alphabetically
  sorted after `firebase_core`, before `firebase_messaging` — wait, alphabetically `crashlytics` <
  `messaging` < `remote_config`, so order is `firebase_core`, `firebase_crashlytics`,
  `firebase_messaging`, `firebase_remote_config`. Matches jetjat's resolved version exactly
  (`5.3.0`) since this project already mirrors jetjat's other firebase_* versions
  (`firebase_core: ^4.9.0`, `firebase_messaging: ^16.2.2`, `firebase_remote_config: ^6.5.1` all
  already match).
- `packages/starter_toolkit/pubspec.yaml` — add `firebase_crashlytics:` (no version constraint,
  per this workspace's rule — see other deps in that file, none are pinned) to `dependencies`,
  alphabetically placed.
- `lib/main.dart` — this is the critical adaptation point. Unlike jetjat (which always initializes
  Firebase), flutter_starter's Firebase is an opt-in template toggle
  (`lib/core/global/firebase_config.dart`, `FirebaseConfig.enabled`, currently `false`) that no code
  path currently reads to call `Firebase.initializeApp()` — verified via repo-wide grep, zero hits.
  Do NOT introduce a hard dependency on a generated `firebase_options.dart` (doesn't exist; running
  `flutterfire configure` is out of scope / requires real credentials this session doesn't have).
  Instead:
  ```dart
  import 'dart:async';
  import 'dart:developer';

  import 'package:firebase_core/firebase_core.dart';
  import 'package:firebase_crashlytics/firebase_crashlytics.dart';
  import 'package:flutter/foundation.dart';
  import 'package:flutter/material.dart';
  import 'package:starter/core/di/app_configurator.dart';
  import 'package:starter/core/global/firebase_config.dart';
  import 'package:starter/features/application/application.dart';
  import 'package:starter_toolkit/utils/crash/crash_reporter.dart' as crash;

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (FirebaseConfig.enabled) {
      await _configureFirebaseCrashReporting();
    }

    await AppConfigurator.configure();

    runApp(const Application());
  }

  Future<void> _configureFirebaseCrashReporting() async {
    try {
      await Firebase.initializeApp();

      // Debug builds report to the console instead, so local crashes don't
      // pollute the dashboard.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);

      crash.crashReporter = const crash.FirebaseCrashReporter();
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stackTrace) {
        unawaited(FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true));
        return true;
      };
    } on Object catch (error, stackTrace) {
      log('Firebase crash reporting setup failed', error: error, stackTrace: stackTrace);
    }
  }
  ```
  (`Firebase.initializeApp()` with no explicit `options:` relies on native
  `GoogleService-Info.plist`/`google-services.json`, which are the files `flutterfire configure`
  would generate/place — this keeps the code path compiling today with zero generated files, and
  correct once a real app enables Firebase per the existing `firebase_config.dart` doc-comment
  instructions.) `dart:developer`'s `log` matches this repo's "no `print()` in production" rule
  already stated in `docs/ai-context/rules.md`.
- `lib/core/global/firebase_config.dart` — update the doc comment to also mention Crashlytics is
  wired automatically once `enabled` flips true (currently only mentions messaging/remote config).

**Do not**: gate Crashlytics separately by `useMock` — jetjat doesn't either; the single
`FirebaseConfig.enabled` toggle is this project's existing equivalent gate.

---

## Workstream B — CI/CD (TestFlight + Firebase App Distribution for Android)

jetjat's CI (`/Users/admin/Documents/GitHub/jetjat_mobile/.github/workflows/ci.yml`,
`testflight.yml`, `utils/deploy.sh`, `packages/app_client/ios/fastlane/{Appfile,Fastfile}`,
`packages/app_client/ios/Gemfile`, `.ruby-version`) is multi-app and assumes a pre-provisioned
**self-hosted macOS runner** with a keychain already loaded with certs. flutter_starter is a
single-app template with no such runner — default to **GitHub-hosted runners** so the workflow
works for anyone who forks this starter, and document self-hosted as a documented opt-in upgrade
(this is a judgment call favoring portability over jetjat's org-specific speed optimization — note
it as such in the new CD guide's "Choosing a runner" section rather than silently deviating).

**Files to add:**

1. `.github/workflows/ci.yml` — adapt jetjat's `ci.yml` job structure but single-app package
   matrix. Jobs:
   - `flutter-quality`: checkout, `subosito/flutter-action@v2` pinned `flutter-version: '3.44.5'`
     (comment: "Keep in sync with .fvmrc"), `cache: true`, `flutter pub get`,
     `dart run custom_lint --no-fatal-infos --no-fatal-warnings`,
     `flutter analyze --no-pub --no-fatal-warnings --no-fatal-infos`.
   - `flutter-quality-strict`: `workflow_dispatch` input `strict_lint` (default false) gated,
     `dart run custom_lint --no-fatal-infos` (warnings fatal).
   - `flutter-tests`: matrix `package: [., packages/starter_toolkit, packages/starter_uikit]`
     (root app is `.` — check whichever `working-directory` syntax handles the root cleanly, e.g.
     `if: matrix.package == '.'` vs cd'ing), `flutter test --no-pub --reporter compact
     --concurrency 4`. Skip `packages/starter_lints` in the test matrix unless it has its own
     `test/` directory — check before including.
   Triggers: `pull_request`, `push: branches: [main]`, `workflow_dispatch`.

2. `.github/workflows/release.yml` — replaces jetjat's `testflight.yml` name (now covers both
   platforms). Trigger: `workflow_run` on `CI` completion, `branches: [main]`, plus
   `workflow_dispatch` for manual re-runs. Two independent jobs (no self-hosted requirement):
   - `ios-testflight`: `runs-on: macos-14`. Steps: checkout at
     `github.event.workflow_run.head_sha`, Flutter setup (3.44.5), Ruby setup via
     `ruby/setup-ruby@v1` (`bundler-cache: true`, `working-directory: ios`), decode signing
     secrets (`IOS_DIST_CERTIFICATE_BASE64` + `IOS_DIST_CERTIFICATE_PASSWORD` +
     `IOS_PROVISIONING_PROFILE_BASE64` into a temp keychain via `security` commands — this
     replaces jetjat's pre-loaded keychain since there's no persistent runner), `flutter pub get`,
     `utils/deploy_ios.sh` (env: `APPSTORE_API_KEY_ID`, `APPSTORE_ISSUER_ID`,
     `APPSTORE_API_KEY_BASE64`).
   - `android-distribution`: `runs-on: ubuntu-latest`. Steps: checkout, Flutter setup, Java setup
     (`actions/setup-java@v4`, `distribution: temurin`, `java-version: 17`), decode
     `ANDROID_KEYSTORE_BASE64` to a file, `flutter pub get`, Ruby setup (bundler-cache,
     `working-directory: android`), `utils/deploy_android.sh` (env: `ANDROID_KEYSTORE_PASSWORD`,
     `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`, `FIREBASE_APP_ID`,
     `FIREBASE_SERVICE_ACCOUNT_JSON_BASE64`).
   Both jobs read `CHANGELOG` from the same `release_notes.txt` convention as jetjat (single-app,
   so no per-app split needed — one `summary:` block).

3. `ios/fastlane/Appfile`:
   ```ruby
   app_identifier(ENV.fetch("IOS_APP_IDENTIFIER", "com.example.starter"))
   team_id(ENV.fetch("IOS_TEAM_ID", "REPLACE_WITH_TEAM_ID"))
   ```
   `ios/fastlane/Fastfile` — port jetjat's `beta` lane structure (App Store Connect API key auth,
   `upload_to_testflight` with `skip_waiting_for_build_processing: true`, `skip_submission: true`,
   `distribute_external: false`, `changelog:` from `ENV["CHANGELOG"]`), consuming a pre-built IPA
   via `ENV.fetch("IPA_PATH")` exactly like jetjat.
   `ios/Gemfile`: `source "https://rubygems.org"` + `gem "fastlane"`.
   `ios/ExportOptions.plist`: `method: app-store`, `teamID` placeholder, `signingStyle: automatic`,
   `uploadSymbols: true`, `compileBitcode: false` (mirrors jetjat's).

4. `android/fastlane/Appfile`:
   ```ruby
   json_key_file(ENV["FIREBASE_SERVICE_ACCOUNT_JSON_PATH"])
   package_name(ENV.fetch("ANDROID_PACKAGE_NAME", "com.example.starter"))
   ```
   `android/fastlane/Fastfile` — NEW, no jetjat precedent (confirmed via grep: jetjat has zero
   Android CD). Use the `fastlane-plugin-firebase_app_distribution` plugin:
   ```ruby
   default_platform(:android)
   opt_out_usage

   platform :android do
     desc "Upload an already-built AAB/APK (ARTIFACT_PATH) to Firebase App Distribution"
     lane :beta do
       changelog = ENV["CHANGELOG"].to_s.strip

       firebase_app_distribution(
         app: ENV.fetch("FIREBASE_APP_ID"),
         android_artifact_type: "APK",
         android_artifact_path: ENV.fetch("ARTIFACT_PATH"),
         service_credentials_file: ENV.fetch("FIREBASE_SERVICE_ACCOUNT_JSON_PATH"),
         release_notes: changelog.empty? ? nil : changelog,
         groups: ENV["FIREBASE_DISTRIBUTION_GROUPS"],
       )
     end
   end
   ```
   `android/Gemfile`:
   ```ruby
   source "https://rubygems.org"

   gem "fastlane"
   gem "fastlane-plugin-firebase_app_distribution"
   ```
   (jetjat's Gemfile only has `gem "fastlane"` since it doesn't need this plugin — Android is new
   territory here, cite the plugin explicitly.)

5. `utils/deploy_ios.sh` — bash, mirrors jetjat's `utils/deploy.sh` iOS half but single-app (no
   `$1` package arg): validate required env vars, read/bump build number from root `pubspec.yaml`
   `version:` line, `fvm flutter build ipa --release --export-options-plist=ios/ExportOptions.plist`,
   locate the `.ipa`, best-effort dSYM upload to Crashlytics (`ios/Pods/FirebaseCrashlytics/upload-symbols`
   if present — only relevant once Crashlytics from Workstream A is actually enabled), write the
   API key from `APPSTORE_API_KEY_BASE64` to a temp `.p8` file, `cd ios && bundle exec fastlane beta`
   with `IPA_PATH`/`APPSTORE_API_KEY_PATH` set.

6. `utils/deploy_android.sh` — bash, NEW: validate env vars, read the same build number,
   `fvm flutter build apk --release` (APK is simpler than AAB for App Distribution — Play Store
   submission, if ever added, would use a separate `appbundle` lane), locate the `.apk` under
   `build/app/outputs/flutter-apk/`, `cd android && bundle exec fastlane beta` with
   `ARTIFACT_PATH`/`CHANGELOG` set.

**Files to edit:**
- `.ruby-version` (new, root) — pin e.g. `3.3.6` (a stable, current Ruby — jetjat's `4.0.6` is very
  new/unusual; use a broadly available LTS-ish version unless there's a reason to match jetjat
  exactly — call this out as a judgment call in the CD guide, not jetjat's exact pin, since
  `ruby/setup-ruby@v1` needs a real published Ruby version).

**New doc — `docs/guides/deployment.md`** (full prose guide, mirrors the depth of jetjat's absent
equivalent — write from scratch): sections — Overview (release.yml trigger chain), Prerequisites
(Apple Developer account + App Store Connect API key, Firebase project + service account, Android
keystore), **Secrets table** (name, where it's used, how to generate — all of
`APPSTORE_API_KEY_ID`, `APPSTORE_ISSUER_ID`, `APPSTORE_API_KEY_BASE64`,
`IOS_DIST_CERTIFICATE_BASE64`, `IOS_DIST_CERTIFICATE_PASSWORD`,
`IOS_PROVISIONING_PROFILE_BASE64`, `IOS_TEAM_ID`, `ANDROID_KEYSTORE_BASE64`,
`ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`, `FIREBASE_APP_ID`,
`FIREBASE_SERVICE_ACCOUNT_JSON_BASE64`, `FIREBASE_DISTRIBUTION_GROUPS`), step-by-step "How a
TestFlight release happens" (CI green on main → release.yml → ios-testflight job → build number
bump → fastlane beta → testers see it in TestFlight app after Apple processing), step-by-step "How
an Android Firebase App Distribution release happens" (same trigger → android-distribution job →
APK build → fastlane firebase_app_distribution → testers get an email/link), **local manual
deploy** commands (`utils/deploy_ios.sh`, `utils/deploy_android.sh` run locally with env vars
exported), a "Choosing a runner" note explaining the GitHub-hosted-by-default vs jetjat's
self-hosted-macOS choice and how to switch, and a Troubleshooting table (codesign errors, keychain
issues, Firebase CLI auth failures).
Add a compact pointer in `docs/ai-context/README.md` and cross-link from `AGENTS.md`'s
Documentation Map table and `README.md`'s doc list (matching the existing `docs/guides/*.md`
entries' bullet format).

---

## Workstream C — Docs: split code rules and preferences

Current state: `docs/rules/coding_rules.md` (consolidated, 19 sections) + `docs/rules/code_formatting.md`
(overlapping subset: file org, class size, whitespace, member ordering, widget rules, comments) +
`docs/rules/naming.md` (already good, keep) + `docs/rules/git_workflow.md` (already good, augment
only) + `docs/rules/bloc.md` (keep, out of scope). `docs/ai-context/rules.md` is the compact
pointer referencing `code_formatting.md` + `naming.md` today.

Target state (mirrors jetjat's split, adapted):

1. **`docs/rules/code_standards.md`** (rename+merge target — replaces both `coding_rules.md` and
   `code_formatting.md`): objective / tool-enforced / architecture rules only. Take
   `coding_rules.md`'s existing 19 sections as the base (it's already this category), fold in
   anything from `code_formatting.md` not already covered (check for duplication before merging —
   don't double-print the same rule under two headings), then delete `code_formatting.md`. Keep
   every `[lint: ...]` tag exactly as-is (they must keep matching the actual lint rule names in
   `packages/starter_lints/lib/src/lints/`). **Do not** import jetjat's `maybeMap`/`whenOrNull`
   BlocBuilder/BlocListener rule (see the hard constraint at the top of this plan) — flutter_starter
   has no such split; its actual and only convention is exhaustive `switch`/`if-case`, already
   stated correctly elsewhere in this repo's docs — do not contradict it.

2. **`docs/rules/code_preferences.md`** (NEW): personal/AI-session stylistic conventions, "more
   specific than `code_standards.md`; when the two disagree, flag rather than silently pick" header
   note (same framing as jetjat's). Port from
   `jetjat_mobile/docs/rules/code_preferences.md`'s 16 rules, adapted:
   - Keep as-is (pure Dart/Flutter/BLoC discipline, no jetjat dependency): flat widget folders
     (cross-check against `code_standards.md`/`code_formatting.md`'s existing "Flat widget folders"
     section — don't duplicate, move it here instead and remove from `code_standards.md` since this
     is a preference not a tool-enforced rule), class member ordering (same
     dedup-and-move-if-already-present check), required-named for 5+ params, FormBuilder
     initialValue single-source, comment ≤2-lines/≤240-chars, container padding
     horizontal-only + explicit `SizedBox`/`SafeVerticalBox` (starter_uikit already has
     `widgets/size/safe_vertical_box.dart` — verified present, so this rule is directly portable
     with the real widget name), top-level private consts placement, feature-word-leads-widget-name,
     private classes keep full descriptive names, `@JsonKey(fromJson:, toJson:)` over hand-written
     `fromJson`, polymorphism-over-repeated-switch (Open/Closed).
   - Adapt: "Terminal status screens use `AppStatusScreen`" — this widget does not exist yet in
     `starter_uikit` (verified: `packages/starter_uikit/lib/widgets/status/` has
     `failure_widget.dart`, `app_shimmer.dart`, `custom_circular_progress_indicator.dart`,
     `notification_snack_bar.dart`, `empty_information_body.dart`, no full-screen outcome widget).
     Build it — see Workstream D, which adds `packages/starter_uikit/lib/widgets/status/app_status_screen.dart`
     — then write this preference rule pointing at the real new widget (fixed 120px icon circle →
     title/subtitle → full-width primary button → optional secondary action, `ThemeProvider`-only,
     no `Localizer`/`getIt`/`AppRouter`/BLoC lookups inside it). Sequence this file's Step after
     Workstream D's widget exists so the doc references something real, not aspirational.
   - Adapt: enum-methods-in-body and nested-status-for-persistent-data — both already generically
     stated in `docs/rules/bloc.md`/`coding_rules.md`'s BLoC section per the earlier deltas doc; add
     only the enum-methods-in-body rule here (genuinely new), and for nested-status just add a
     one-line cross-reference to `bloc.md`, not a restatement, avoiding the duplication jetjat's own
     file explicitly warns against.
   - Drop entirely: nothing else needs dropping — the remaining jetjat items are already generic.

3. **`docs/rules/lint_reference.md`** (NEW): table of the 19 real lint rules found in
   `packages/starter_lints/lib/src/lints/*.dart` (file list already gathered — do not invent names;
   read each file's lint code/severity if not obvious from the filename), columns: lint name |
   severity (ERROR/WARNING/INFO — check each rule's actual declared severity in its `.dart` file,
   don't guess) | doc section link (into `code_standards.md`/`code_preferences.md` section anchors).
   Mirror jetjat's table format exactly (`docs/rules/lint_reference.md`).

4. **`docs/rules/naming.md`** — keep, augment only if jetjat has sections genuinely missing here.
   Already has Anti-Patterns table and Quick Reference table (verified) — jetjat's equivalents are
   near-identical, skip re-adding. Check for jetjat's "Abstraction Naming" (bare-name-abstract +
   Api/Local/Mock-prefixed-concrete) and "Repository & DataSource Naming" sections specifically —
   flutter_starter's naming.md may already state this differently (has an "Example 4: User Data
   Source" section with `ApiUserDataSource`/`LocalUserDataSource`/`MockUserDataSource` already, so
   likely already covered — verify before adding anything to avoid duplication).

5. **`docs/rules/git_workflow.md`** — augment, don't replace (already close to jetjat's per prior
   research). Add: (a) jetjat's "Long-lived branches" table (`main`/`release/<version>` roles) —
   flutter_starter's actual current branch is `release/3.1.0` off `main`, confirming this model
   already applies in practice even though the doc doesn't say so yet; write the table to match
   flutter_starter's real branches (check `git branch -a` / `git log --all --oneline --graph
   --decorate -20` for the real merge pattern before writing this table — don't assume jetjat's
   `dev` branch exists here, it likely doesn't). (b) the explicit multi-scope comma-separated
   commit convention (`fix(toolkit,uikit): ...`) if not already stated.

6. **`docs/ai-context/rules.md`** — update the "Full sources" links at the top to point at the new
   file set (`code_standards.md`, `code_preferences.md`, `naming.md`, `lint_reference.md`) instead
   of `code_formatting.md`.

7. **Cross-reference updates** — grep the whole repo for `coding_rules.md` and `code_formatting.md`
   references and update every hit: `README.md` (doc list, line ~362-364), `AGENTS.md`
   (Documentation Map / anywhere else it's named), `docs/guides/code_review.md`,
   `.claude/agents/reviewer.md` if it names these files, any other `docs/*.md` cross-links. Missing
   even one creates a dead link — grep after editing to confirm zero remaining hits on the old
   filenames.

---

## Workstream D — Example screens

Two things already exist and already cover a lot of ground — don't rebuild them, extend/surface
them:
- `lib/features/task/` — full reference feature (list/details/calendar/search/create subfeatures,
  each demonstrating BLoC/exception/form-model/repository-executor patterns end-to-end).
- `packages/starter_uikit/lib/example/` — a uikit widget gallery (`uikit_menu_screen.dart` +
  8 category screens: buttons, text, form fields, status widgets, dialogs, app bars, misc,
  pagination) with its own `example_router.dart`/`ExampleRouter` and `ThemeCubit`, marked
  `@visibleForTesting`/"INTERNAL USE ONLY" on each screen. **Confirmed via grep: this gallery is
  currently unreachable from the running app** — `lib/core/router/app_router.dart` has zero
  references to `ExampleRouter`/any example screen, so nobody who runs the template actually sees
  it today.

Steps:

1. **Wire the gallery into the running app, dev-only.** Add an entry point reachable from
   `lib/features/application/environment/ui/switcher/widget/dev_mode_activator.dart`'s environment
   bottom sheet (or a sibling widget in that same `switcher/` folder) — e.g. a second option in the
   `DropdownBottomSheet`-driven flow, or a dedicated button below it, that pushes
   `ExampleRouter`'s root (`UikitMenuScreen`) via whatever navigation mechanism
   `starter_uikit`'s `example_router.dart` exposes (check it — it may need its own
   `MaterialApp.router`/nested navigator since it's a self-contained router, not a route inside
   `app_router.dart`; if so, push it as a full-screen route via `Navigator.of(context,
   rootNavigator: true).push(MaterialPageRoute(builder: (_) => /* the example app widget */))`
   using whatever root widget `packages/starter_uikit/lib/example/screens/application.dart`
   exports). Keep this reachable only via the existing hidden dev-mode tap gesture — not a
   permanently visible nav item — matching how `DevModeActivator` already gates the environment
   switcher.

2. **Build `AppStatusScreen`** in `packages/starter_uikit/lib/widgets/status/app_status_screen.dart`:
   `StatelessWidget`, constructor takes `icon` (an `SvgIcon`/widget), `title`/`subtitle` (already-
   localized strings passed in, never a `Localizer` lookup inside), `primaryButtonLabel` +
   `onPrimaryPressed`, optional `secondaryButtonLabel` + `onSecondaryPressed`. Layout: centered
   120px icon circle → `SizedBox` gap → title/subtitle (`ThemeProvider.of(context)` for text
   styles/colors only) → `Spacer`/flexible gap → full-width `AppElevatedButton` (primary) →
   optional `AppOutlinedButton`/text button (secondary), wrapped bottom-safe via the existing
   `SafeVerticalBox` per the (now-ported) code_preferences rule. No `getIt`/`AppRouter`/BLoC
   lookups inside — everything injected via constructor, so it can render standalone during a DI
   failure (this is also directly useful for main.dart's existing/future startup-failure fallback
   path, if one exists — check `AppConfigurator`/`main.dart` for an existing
   `AppStartupFailureApp`-equivalent; if there is one, note whether it's a good candidate to swap
   onto `AppStatusScreen`, but only make that swap if it doesn't risk breaking the DI-failure
   contract — read that code first).

3. **Demo it**: add a new `AppStatusScreen`-focused example screen (or extend
   `status_widgets_example_screen.dart`) under `packages/starter_uikit/lib/example/screens/`,
   wired into `uikit_menu_screen.dart`'s existing list of categories, showing at least 2 states
   (e.g. "success" and "error" variants with different icon/copy) so both the primary-only and
   primary+secondary button layouts are visible.

4. **Document the connection**: add a short paragraph to `AGENTS.md` (near the Architecture or
   Reusing Toolkit & UIKit section) explicitly naming `lib/features/task/` and
   `packages/starter_uikit/lib/example/` as "the reference implementation for these rules — read
   before writing a new feature" — this connection isn't stated anywhere today, which is presumably
   why the user asking for this couldn't find it.

Keep this workstream scoped to wiring + one new widget + its demo — do not refactor `task/create`'s
existing snackbar-based success flow onto `AppStatusScreen` (it's a different, already-idiomatic
UX for a quick create-and-pop flow; forcing a fit would contradict the "modals = static show()"
preference rule's spirit of using the right pattern per situation, not one pattern everywhere).

---

## Workstream E — Claude Code subagents/skills/commands

**Files to add:**
1. `.claude/agents/planner.md` — port `jetjat_mobile/.claude/agents/planner.md`, adapted:
   - Keep `model: fable`, but flutter_starter's `reviewer.md` currently uses `effort: xhigh` where
     jetjat's `planner.md` uses `effort: high` (jetjat's actual `reviewer.md`, post-split, likely
     also differs from `effort: high` — not fetched, doesn't matter for this port). Use
     `effort: high` for the new narrower `planner` (matches jetjat), keep `reviewer.md`'s existing
     `effort: xhigh` unchanged for its own (now narrower) job.
   - Keep the Test Cases / Review Criteria plan-template addition (references
     `docs/guides/testing.md`'s test types) — check flutter_starter's actual
     `docs/guides/testing.md`/`docs/ai-context/testing.md` for its real test-type taxonomy (T1-T8
     rule IDs already known from `AGENTS.md`: mock-first feature-flow tests, repository executor
     tests, etc. — use flutter_starter's actual T-rule vocabulary, not jetjat's six-type list,
     when writing the Test Cases section's instructions).
   - Trim the "When to use" example list to flutter_starter's own domain (task/settings/auth/etc.,
     not jetjat's courier/restaurant examples) — write new illustrative examples grounded in this
     repo's actual features (`lib/features/task/`, `lib/features/auth/`, `lib/features/settings/`).
   - Root-cause analysis deliverable section: keep as jetjat has it (generic).
2. **Narrow `.claude/agents/reviewer.md`**: remove the "Implementation plan" and "Root-cause
   analysis" deliverable sections (now `planner`'s job) — keep only "Code review report" and
   "Architecture/reference docs". Trim the "When to use" examples list to match (drop the plan/
   root-cause examples, keep the review/docs ones). Keep `tools`/`model`/`effort`/`color`
   frontmatter as today unless the narrower scope changes the reasonable effort level (reviewing a
   finished diff is arguably still xhigh-worthy — leave `effort: xhigh` as-is unless there's a
   clear reason to drop it).
3. `.claude/skills/split-large-widget/SKILL.md` — port
   `jetjat_mobile/.claude/skills/split-large-widget/SKILL.md` near-verbatim: swap `jepjat_mobile`→
   this repo (no name needed, or "this repo"), `docs/rules/code_standards.md` reference stays
   correct post-Workstream-C rename (the 200-line ceiling section moves there), `jetjat_uikit`→
   `starter_uikit`, `jetjat_toolkit`→`starter_toolkit` in the "Known gotchas" section, and the
   `lib/features/{feature}/ui/{subfeature}/screen|widget/` path pattern is already identical
   structurally in flutter_starter — no change needed there.

**Files to edit:**
4. `CLAUDE.md` — add a `planner` row to the subagent table (before or after `reviewer`'s row,
   matching jetjat's phrasing: "Plan before implementing, root-cause an unknown failure, judge a
   naming/design choice"), narrow `reviewer`'s row description to drop "Plan before implementing,
   root-cause an unknown failure" (now planner's job) and keep "write a code review report, judge
   a naming/design choice" only if that judgment-call framing still fits reviewer's narrowed scope
   — reconsider: jetjat's split gives *naming/design judgment calls* to `planner`, not `reviewer` —
   match that split exactly, don't leave it ambiguous which agent owns judgment calls. Update the
   "Typical chain" sentence: `explorer gathers facts → planner turns them into a plan
   (work/plans/<slug>.md, with a Test Cases section written before Steps and a Review Criteria
   acceptance checklist) → implementer executes it, writing those tests first → reviewer (or
   /com_review) checks the result`. Add `split-large-widget` to the Skills list with its one-line
   description.
5. `.claude/settings.json` — add an `allow` array (currently absent) with the generically-safe
   entries jetjat has that also apply here: `Bash(sed *)`, `Bash(git mv *)`, `Bash(git grep *)`,
   `Bash(grep *)`, `Bash(fvm flutter analyze*)`, `Bash(fvm flutter pub run build_runner build*)`,
   `Bash(spider build*)` — all seven apply directly (flutter_starter uses build_runner and spider
   per `AGENTS.md`'s Essential Commands). Keep the existing `deny: ["Agent(Explore)"]` unchanged.

**Explicitly not porting**: `com_integrate.md` as jetjat wrote it — it's tied to jetjat's multi-app
pub-workspace release topology (per-app build-number bumps, per-app Russian changelogs,
`dev`→`main` fast-forward). Once Workstream B's `release.yml`/`utils/deploy_*.sh` land, a
single-app adapted version becomes plausible (test-gate → merge → single build-number bump →
single `release_notes.txt` → confirm → push to trigger `release.yml`) — call this out as a
**follow-up candidate, not built in this pass** (same "flag, don't silently build" spirit as
`work/docs-jetjat-architecture-deltas.md`). If there's implementation budget left after A-D, a
minimal `/com_release` command doing exactly that single-app flow is reasonable to add — otherwise
leave a one-paragraph note in `work/jetjat-sync-plan.md`'s completion summary saying it was
deferred and why.

---

## Verification (per workstream, run from repo root unless noted)

- A: `fvm flutter pub get && fvm flutter analyze` — must stay clean. No test coverage requirement
  for the crash reporter itself (it's a thin Firebase wrapper, matches jetjat's own untested
  status), but confirm `NoopCrashReporter` is trivially usable in existing tests without a Firebase
  dependency (it must not import `package:firebase_crashlytics` in a way that breaks
  `flutter test` — verify by running the full suite once after adding the file).
- B: workflow YAML must be valid (no execution possible without real secrets/runners — sanity-check
  with `actionlint` if available, otherwise careful manual review); `bundle exec fastlane lanes` run
  locally inside `ios/` and `android/` if `bundle install` succeeds without real credentials (lane
  listing doesn't require secrets).
- C: `grep -rn "coding_rules.md\|code_formatting.md" /Users/admin/Documents/GitHub/flutter_starter
  --include="*.md"` returns zero hits outside this plan file itself and
  `work/docs-jetjat-architecture-deltas.md` (historical, leave it). Every new/edited `docs/rules/*.md`
  file's internal cross-links resolve to real files.
- D: `fvm flutter analyze` clean; manually reach the example gallery via the dev-mode tap gesture
  in a debug run (or via `fvm flutter test` widget smoke if one exists) to confirm it's actually
  wired, not just present in a router nobody calls.
- E: no executable verification (Markdown/JSON only) — proofread cross-references (`CLAUDE.md`
  table ↔ actual `.claude/agents/*.md` files present, matching the drift jetjat's own CLAUDE.md was
  found to have — don't repeat that mistake here).

## Out of scope

- Running `flutterfire configure` or creating real Firebase/Apple Developer/Play Console projects —
  no credentials available this session; everything ships as a working-but-placeholder template.
- Actually triggering a TestFlight/Firebase App Distribution release.
- `com_integrate`-equivalent release command (flagged as follow-up in Workstream E).
- Refactoring `AppException` or adopting jetjat's pagination primitives — both explicitly rejected
  in `work/docs-jetjat-architecture-deltas.md` and out of this task's stated scope.
