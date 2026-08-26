#!/usr/bin/env bash
# Builds the release IPA, uploads dSYMs to Firebase Crashlytics (best-effort — a failed upload
# only degrades native-frame symbolication, so it never blocks the release), and uploads the IPA
# to TestFlight via fastlane. Mirrors jetjat_mobile's utils/deploy.sh iOS half, but single-app: no
# package argument, and the build number always bumps (no --bump flag to opt in/out of).
#
# Usage: utils/deploy_ios.sh   (from repo root)
#
# Requires (see docs/guides/deployment.md's secrets table for how to obtain each one):
#   - APPSTORE_API_KEY_ID, APPSTORE_ISSUER_ID, APPSTORE_API_KEY_BASE64   env vars
#   - A signing identity + provisioning profile already installed in the active keychain
#     (CI does this in a prior workflow step; locally, install them via Xcode/Keychain Access).
#
# NOTE: this bumps the build number in the working tree's pubspec.yaml for the build, but — unlike
# jetjat's workflow, which commits the bump back to main as a coordinated multi-app step — it does
# NOT commit the change back to git. See docs/guides/deployment.md's "Choosing a runner" /
# troubleshooting notes for why, and for how to add a commit-back step if you need one.
set -euo pipefail

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

: "${APPSTORE_API_KEY_ID:?APPSTORE_API_KEY_ID must be set}"
: "${APPSTORE_ISSUER_ID:?APPSTORE_ISSUER_ID must be set}"
: "${APPSTORE_API_KEY_BASE64:?APPSTORE_API_KEY_BASE64 must be set}"

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

current=$(grep '^version:' pubspec.yaml | sed -E 's/.*\+([0-9]+)$/\1/')
next=$((current + 1))
sed -i '' -E "s/^(version: .*\+)[0-9]+$/\1$next/" pubspec.yaml
echo "▶ Bumped build number to $next" >&2

BUILD_NUMBER=$(grep '^version:' pubspec.yaml | sed -E 's/.*\+([0-9]+)$/\1/')

echo "▶ Building release IPA (build $BUILD_NUMBER)…" >&2
fvm flutter build ipa --release --export-options-plist=ios/ExportOptions.plist >&2

IPA_PATH="$REPO_ROOT/$(ls build/ios/ipa/*.ipa | head -1)"

# `upload-symbols` ships inside the FirebaseCrashlytics pod, already resolved by the build above
# (CocoaPods runs as part of `flutter build ipa`) — no extra dependency needed. This is only
# relevant once Workstream A's Crashlytics is actually enabled (FirebaseConfig.enabled = true);
# until then these paths simply won't exist and the upload is skipped below. Dart-level Crashlytics
# reports work regardless; this only symbolicates native crash frames.
ARCHIVE_DSYMS="$REPO_ROOT/build/ios/archive/Runner.xcarchive/dSYMs"
UPLOAD_SYMBOLS="$REPO_ROOT/ios/Pods/FirebaseCrashlytics/upload-symbols"

if [[ -x "$UPLOAD_SYMBOLS" && -d "$ARCHIVE_DSYMS" ]]; then
  echo "▶ Uploading dSYMs to Crashlytics…" >&2
  "$UPLOAD_SYMBOLS" -gsp "ios/Runner/GoogleService-Info.plist" -p ios "$ARCHIVE_DSYMS" >&2 \
    || echo "⚠ Crashlytics dSYM upload failed, continuing" >&2
else
  echo "⚠ Skipping Crashlytics dSYM upload ($UPLOAD_SYMBOLS or $ARCHIVE_DSYMS not found)" >&2
fi

echo "▶ Writing App Store Connect API key…" >&2
APPSTORE_API_KEY_PATH="$(mktemp -t AuthKey_XXXXXX).p8"
trap 'rm -f "$APPSTORE_API_KEY_PATH"' EXIT
echo "$APPSTORE_API_KEY_BASE64" | base64 --decode > "$APPSTORE_API_KEY_PATH"

echo "▶ Uploading to TestFlight via fastlane…" >&2
cd ios
bundle check >/dev/null 2>&1 || bundle install >&2

APPSTORE_API_KEY_PATH="$APPSTORE_API_KEY_PATH" \
  IPA_PATH="$IPA_PATH" \
  bundle exec fastlane beta >&2

echo "✓ Build $BUILD_NUMBER uploaded to TestFlight" >&2
echo "$BUILD_NUMBER"
