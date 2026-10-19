#!/usr/bin/env bash
# Builds a release APK and uploads it to Firebase App Distribution via fastlane. No jetjat
# precedent (jetjat_mobile has zero Android CD) — this is new for flutter_starter.
#
# Usage: utils/deploy_android.sh   (from repo root)
#
# Requires (see docs/guides/deployment.md's secrets table for how to obtain each one):
#   - ANDROID_KEYSTORE_PATH, ANDROID_KEYSTORE_PASSWORD, ANDROID_KEY_ALIAS, ANDROID_KEY_PASSWORD
#   - FIREBASE_APP_ID, FIREBASE_SERVICE_ACCOUNT_JSON_PATH   env vars
#
# ANDROID_KEYSTORE_PATH must point at an already-decoded .jks/.keystore file (CI decodes
# ANDROID_KEYSTORE_BASE64 to a temp file in a prior workflow step before calling this script).
# This script writes android/key.properties from the above so android/app/build.gradle's release
# signingConfig picks it up — see that file's comment for the fallback-to-debug-keys behavior.
#
# NOTE: like deploy_ios.sh, this bumps the build number in the working tree's pubspec.yaml for the
# build but does NOT commit the change back to git. See docs/guides/deployment.md.
set -euo pipefail

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

: "${ANDROID_KEYSTORE_PATH:?ANDROID_KEYSTORE_PATH must be set}"
: "${ANDROID_KEYSTORE_PASSWORD:?ANDROID_KEYSTORE_PASSWORD must be set}"
: "${ANDROID_KEY_ALIAS:?ANDROID_KEY_ALIAS must be set}"
: "${ANDROID_KEY_PASSWORD:?ANDROID_KEY_PASSWORD must be set}"
: "${FIREBASE_APP_ID:?FIREBASE_APP_ID must be set}"
: "${FIREBASE_SERVICE_ACCOUNT_JSON_PATH:?FIREBASE_SERVICE_ACCOUNT_JSON_PATH must be set}"

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

current=$(grep '^version:' pubspec.yaml | sed -E 's/.*\+([0-9]+)$/\1/')
next=$((current + 1))
# GNU sed (CI, ubuntu-latest) takes `-i` with no argument; BSD sed (local macOS runs) requires
# an explicit empty one — `sed -i ''` on GNU sed would misread '' as the script and fail.
if sed --version >/dev/null 2>&1; then
  sed -i -E "s/^(version: .*\+)[0-9]+$/\1$next/" pubspec.yaml
else
  sed -i '' -E "s/^(version: .*\+)[0-9]+$/\1$next/" pubspec.yaml
fi
echo "▶ Bumped build number to $next" >&2

BUILD_NUMBER=$(grep '^version:' pubspec.yaml | sed -E 's/.*\+([0-9]+)$/\1/')

echo "▶ Writing android/key.properties…" >&2
cat > android/key.properties <<PROPS
storeFile=$ANDROID_KEYSTORE_PATH
storePassword=$ANDROID_KEYSTORE_PASSWORD
keyAlias=$ANDROID_KEY_ALIAS
keyPassword=$ANDROID_KEY_PASSWORD
PROPS
trap 'rm -f "$REPO_ROOT/android/key.properties"' EXIT

echo "▶ Building release APK (build $BUILD_NUMBER)…" >&2
fvm flutter build apk --release >&2

ARTIFACT_PATH="$REPO_ROOT/$(ls build/app/outputs/flutter-apk/*.apk | head -1)"

echo "▶ Uploading to Firebase App Distribution via fastlane…" >&2
cd android
bundle check >/dev/null 2>&1 || bundle install >&2

CHANGELOG="${CHANGELOG:-}" \
  FIREBASE_APP_ID="$FIREBASE_APP_ID" \
  FIREBASE_SERVICE_ACCOUNT_JSON_PATH="$FIREBASE_SERVICE_ACCOUNT_JSON_PATH" \
  ARTIFACT_PATH="$ARTIFACT_PATH" \
  bundle exec fastlane beta >&2

echo "✓ Build $BUILD_NUMBER uploaded to Firebase App Distribution" >&2
echo "$BUILD_NUMBER"
