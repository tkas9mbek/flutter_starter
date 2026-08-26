# Deployment Guide

CI/CD for shipping test builds: TestFlight for iOS, Firebase App Distribution for Android. This
guide covers the workflow trigger chain, the secrets each job needs, what happens step by step on
each platform, how to run the same deploy locally, and how to switch runners.

Everything in this guide ships as a **working-but-placeholder template**: no real Apple Developer,
Firebase, or Android signing credentials exist for this starter. Bundle IDs, package names, team
IDs, and similar values are placeholders (e.g. `com.example.starter`) — replace them with your
app's real identifiers before this pipeline can actually deploy anything. `flutterfire configure`
has not been run and no cloud resources have been created; see each secret's row below for what you
still need to provision.

## Overview

Two workflows, both under `.github/workflows/`:

- **`ci.yml`** — analyzer, custom lints, and tests. Runs on every PR, every push to `main`, and on
  demand (`workflow_dispatch`, with an optional `strict_lint` input).
- **`release.yml`** — triggered by `workflow_run` once `ci.yml` completes on `main` (only proceeds
  if CI succeeded), plus `workflow_dispatch` for manual re-runs. Two independent jobs:
  - `ios-testflight` (`macos-14`) — builds the release IPA and uploads it to TestFlight.
  - `android-distribution` (`ubuntu-latest`) — builds the release APK and uploads it to Firebase
    App Distribution.

The two jobs don't depend on each other — either can succeed or fail independently, and either can
be re-run alone via `workflow_dispatch` (GitHub Actions re-runs every job in a `workflow_dispatch`
run; there's no dedicated "run this job only" trigger without also adding per-job `if:` toggles).

## Prerequisites

Before any of this can deploy for real, you need:

1. **An Apple Developer account** with access to App Store Connect, a distribution certificate, a
   provisioning profile for the app's bundle ID, and an App Store Connect API key (used for
   unattended `fastlane` authentication — no Apple ID/password/2FA in CI).
2. **A Firebase project** with Crashlytics and App Distribution enabled, plus a service account
   key JSON with the "Firebase App Distribution Admin" role.
3. **An Android signing keystore** (`.jks`/`.keystore`) generated with `keytool`, dedicated to
   release signing (never commit it — `android/.gitignore` already excludes `key.properties` and
   `**/*.keystore`/`**/*.jks`).

## Secrets table

All secrets are configured under the repo's **Settings → Secrets and variables → Actions**.

| Secret | Used by | How to generate / obtain |
|---|---|---|
| `APPSTORE_API_KEY_ID` | `ios-testflight` | App Store Connect → Users and Access → Integrations → App Store Connect API → key ID column. |
| `APPSTORE_ISSUER_ID` | `ios-testflight` | Same App Store Connect API page — Issuer ID shown above the key list. |
| `APPSTORE_API_KEY_BASE64` | `ios-testflight` | Download the `.p8` private key when you create the API key (only downloadable once), then `base64 -i AuthKey_XXXX.p8 \| pbcopy`. |
| `IOS_DIST_CERTIFICATE_BASE64` | `ios-testflight` | Export your Apple Distribution certificate + private key from Keychain Access as a `.p12`, then `base64 -i cert.p12 \| pbcopy`. |
| `IOS_DIST_CERTIFICATE_PASSWORD` | `ios-testflight` | The password you set when exporting the `.p12`. |
| `IOS_PROVISIONING_PROFILE_BASE64` | `ios-testflight` | Download the App Store provisioning profile from Apple Developer → Profiles, then `base64 -i profile.mobileprovision \| pbcopy`. |
| `IOS_TEAM_ID` | `ios-testflight` (fastlane `Appfile`) | Apple Developer → Membership → Team ID (10 characters). |
| `ANDROID_KEYSTORE_BASE64` | `android-distribution` | `base64 -i release.keystore \| pbcopy` on the keystore from Prerequisites #3. |
| `ANDROID_KEYSTORE_PASSWORD` | `android-distribution` | The store password you chose when running `keytool -genkey`. |
| `ANDROID_KEY_ALIAS` | `android-distribution` | The `-alias` value passed to `keytool -genkey`. |
| `ANDROID_KEY_PASSWORD` | `android-distribution` | The key password you chose when running `keytool -genkey` (can equal the store password). |
| `FIREBASE_APP_ID` | `android-distribution` (fastlane `Fastfile`) | Firebase Console → Project settings → General → your Android app's "App ID" (format `1:...:android:...`). |
| `FIREBASE_SERVICE_ACCOUNT_JSON_BASE64` | `android-distribution` | Firebase Console → Project settings → Service accounts → Generate new private key, then `base64 -i service-account.json \| pbcopy`. |
| `FIREBASE_DISTRIBUTION_GROUPS` | `android-distribution` (optional) | Comma-separated tester group names configured in Firebase App Distribution → Testers & Groups. Omit to distribute with no group restriction (fastlane's default). |

## How a TestFlight release happens

1. A push lands on `main` (directly, or a merged PR) and `ci.yml` runs.
2. `ci.yml` succeeds → GitHub fires the `workflow_run` event → `release.yml`'s `ios-testflight` job
   starts, checked out at the exact commit CI just validated (`workflow_run.head_sha`).
3. Flutter and Ruby (via `ruby/setup-ruby@v1`, `bundler-cache: true`, `working-directory: ios`) are
   set up; the distribution certificate and provisioning profile are decoded from their `_BASE64`
   secrets into a temporary keychain created just for this run (see "Choosing a runner" below for
   why this differs from a persistent-runner setup).
4. `utils/deploy_ios.sh` runs: bumps the build number in the root `pubspec.yaml`, builds the
   release IPA (`fvm flutter build ipa --release --export-options-plist=ios/ExportOptions.plist`),
   best-effort uploads dSYMs to Crashlytics if present, then hands the IPA to
   `bundle exec fastlane beta` (`ios/fastlane/Fastfile`), which authenticates with the App Store
   Connect API key and calls `upload_to_testflight` (`skip_waiting_for_build_processing: true`,
   `skip_submission: true`, `distribute_external: false` — internal testers only).
5. Apple processes the build (usually minutes, sometimes longer); once done, testers with access
   see it in the TestFlight app.

## How an Android Firebase App Distribution release happens

1. Same trigger as above — `ci.yml` succeeds on `main` → `release.yml`'s `android-distribution` job
   starts at the same commit.
2. Flutter, Java 17 (`actions/setup-java@v4`, `distribution: temurin`), and Ruby
   (`ruby/setup-ruby@v1`, `working-directory: android`) are set up; the keystore and Firebase
   service account JSON are decoded from their `_BASE64` secrets to temp files.
3. `utils/deploy_android.sh` runs: bumps the same `pubspec.yaml` build number, writes
   `android/key.properties` from the decoded keystore + secrets (picked up automatically by
   `android/app/build.gradle`'s release `signingConfig` — see that file's comment; without this
   file present, the release build type falls back to debug-signing, same as the template's
   original TODO), builds the release APK (`fvm flutter build apk --release` — APK rather than AAB,
   since App Distribution doesn't need Play Store's bundle format; a `appbundle` lane would need
   adding separately if Play Store submission is ever wired up), then hands the APK to
   `bundle exec fastlane beta` (`android/fastlane/Fastfile`), which calls the
   `fastlane-plugin-firebase_app_distribution` action.
4. Testers in the configured `FIREBASE_DISTRIBUTION_GROUPS` (or all testers if unset) get an
   email/link from Firebase App Distribution.

## Local manual deploy

Both deploy scripts can be run directly on a machine with Xcode/Android SDK, `fvm`, and `bundle`
already set up — useful for a one-off release without waiting on CI.

```bash
# iOS — run from the repo root
export APPSTORE_API_KEY_ID=...
export APPSTORE_ISSUER_ID=...
export APPSTORE_API_KEY_BASE64=...   # base64 of the .p8 key
# A valid signing identity + provisioning profile must already be installed locally
# (Xcode → Settings → Accounts, or Keychain Access) — this script doesn't install them for you.
utils/deploy_ios.sh
```

```bash
# Android — run from the repo root
export ANDROID_KEYSTORE_PATH=/path/to/release.keystore   # already decoded, not base64
export ANDROID_KEYSTORE_PASSWORD=...
export ANDROID_KEY_ALIAS=...
export ANDROID_KEY_PASSWORD=...
export FIREBASE_APP_ID=...
export FIREBASE_SERVICE_ACCOUNT_JSON_PATH=/path/to/service-account.json   # already decoded
utils/deploy_android.sh
```

Both scripts print the build number they shipped as the last line of stdout and bump the local
`pubspec.yaml`'s build number as part of the run — commit that bump yourself if you want it
persisted (see "Choosing a runner" for why the scripts don't auto-commit it).

## Choosing a runner

`release.yml` defaults to **GitHub-hosted runners** (`macos-14` for iOS, `ubuntu-latest` for
Android) so the workflow works out of the box for anyone who forks this starter, with no
infrastructure to provision. This is a deliberate deviation from `jetjat_mobile`'s CI/CD, which
assumes a **self-hosted macOS runner** with certificates already loaded into a persistent keychain
— faster (no per-run keychain setup, no GitHub-hosted macOS minute cost) but org-specific and not
portable to a fresh fork. Favoring portability over that speed optimization is a judgment call, not
an oversight.

To switch to a self-hosted runner:

1. Provision a persistent macOS machine, install Xcode + the Flutter SDK version pinned in
   `.fvmrc`, and load your distribution certificate into its login keychain once.
2. Change `ios-testflight`'s `runs-on:` to your runner's label(s) (e.g.
   `[self-hosted, macOS, ios-build]`).
3. Drop the "Import signing certificate & provisioning profile" step — the persistent keychain
   already has what's needed — and drop `IOS_DIST_CERTIFICATE_BASE64` /
   `IOS_DIST_CERTIFICATE_PASSWORD` / `IOS_PROVISIONING_PROFILE_BASE64` from the secrets you export
   to that job.
4. Consider unlocking/extending the keychain timeout at the start of the job instead (see
   `jetjat_mobile`'s `.github/workflows/testflight.yml` for the exact `security` commands), since a
   persistent keychain can still lock on sleep/screen-lock between runs.

Because each CI run's build-number bump isn't committed back to `main` (unlike `jetjat_mobile`,
whose workflow coordinates a multi-app bump-and-push step — out of scope here per
`work/jetjat-sync-plan.md`), two back-to-back releases from a clean checkout will reuse the same
base build number unless you commit the bump yourself or replace it with a monotonic source (e.g.
`${{ github.run_number }}`). Flag this as a known simplification rather than a hidden bug — a real
fork should decide how it wants build numbers to persist.

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| `errSecInternalComponent` / `User interaction is not allowed` during codesign | The signing keychain locked or wasn't unlocked before `xcodebuild` ran. | On GitHub-hosted runners this shouldn't happen (fresh keychain per run); on self-hosted, re-check the keychain unlock/timeout step — see `jetjat_mobile`'s `testflight.yml` for the exact `security set-keychain-settings` incantation. |
| `No signing certificate "iOS Distribution" found` | `IOS_DIST_CERTIFICATE_BASE64`/`_PASSWORD` decoded into the wrong keychain, or the cert doesn't match `IOS_TEAM_ID`/the app's bundle ID. | Re-export the `.p12` from Keychain Access on a machine where the cert is trusted; confirm `ios/fastlane/Appfile`'s `team_id` and `ios/ExportOptions.plist`'s `teamID` match the certificate's team. |
| `Firebase CLI` / `firebase_app_distribution` auth failure | `FIREBASE_SERVICE_ACCOUNT_JSON_BASE64` is stale, malformed, or the service account lacks the "Firebase App Distribution Admin" role. | Regenerate the key from Firebase Console → Service accounts, re-base64 it, and confirm the role in IAM. |
| `keystore was tampered with, or password was incorrect` | `ANDROID_KEYSTORE_PASSWORD`/`ANDROID_KEY_PASSWORD`/`ANDROID_KEY_ALIAS` don't match the keystore the `_BASE64` secret was generated from. | Re-run `keytool -list -v -keystore release.keystore` locally to confirm alias/password, then re-sync the secrets. |
| Release APK is still debug-signed | `android/key.properties` wasn't written (script failed before that step) or isn't being picked up. | Confirm `utils/deploy_android.sh` ran to completion; `android/app/build.gradle`'s release `signingConfig` only switches off `signingConfigs.debug` when `android/key.properties` exists at build time. |
| `bundle install` fails in CI | `working-directory: ios`/`android` for `ruby/setup-ruby@v1` doesn't match where the `Gemfile` actually lives, or a new gem needs a system dependency. | Confirm `ios/Gemfile` and `android/Gemfile` both exist and `bundler-cache: true` is set; re-run with cache cleared if a `Gemfile.lock` drifted. |
| `release.yml` never triggers after CI | `workflow_run` only fires for workflows on the default branch's latest definition, and only for the branches listed under `branches:` (here, `main`). | Confirm `ci.yml` itself completed **on `main`** (not just a PR branch), and that both workflow files are already merged to `main` (a `workflow_run` trigger can't see a workflow that only exists on a feature branch). |
