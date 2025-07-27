#!/bin/bash

set -e

# Developer email registered in Xcode and application specific password 
# via "https://account.apple.com/account/manage"
APPLE_ID="blabla@icloud.com"
APP_SPECIFIC_PASSWORD="xxxx-xxxx-xxxx-xxxx"

BUNDLE_ID="com.coffeesapiens.sapiensshifter"
IPA_PATH="build/ios/ipa/sapiensshifter.ipa"

if [ ! -f "$IPA_PATH" ]; then
  echo "❌ ERROR: IPA file not found: $IPA_PATH"
  exit 1
fi

echo "🔍 Verifying IPA file..."
xcrun altool \
  --validate-app \
  --type ios \
  --file "$IPA_PATH" \
  --username "$APPLE_ID" \
  --password "$APP_SPECIFIC_PASSWORD"

echo "✅ Verification successful!"
