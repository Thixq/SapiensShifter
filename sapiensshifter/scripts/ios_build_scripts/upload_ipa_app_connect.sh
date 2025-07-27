#!/bin/bash

# ---- User Settings ----
IPA_PATH="build/ios/ipa/sapiensshifter.ipa" 
# Developer email registered in Xcode and application specific password 
# via "https://account.apple.com/account/manage"
APPLE_ID="blabla@icloud.com"            
APP_SPECIFIC_PASSWORD="xxxx-xxxx-xxxx-xxxx"


if [ ! -f "$IPA_PATH" ]; then
  echo "ERROR: IPA file not found: $IPA_PATH"
  exit 1
fi

echo "Starting installation..."
xcrun altool --upload-app \
  --type ios \
  --file "$IPA_PATH" \
  --username "$APPLE_ID" \
  --password "$APP_SPECIFIC_PASSWORD"

    echo "✅ Installation successful!"

