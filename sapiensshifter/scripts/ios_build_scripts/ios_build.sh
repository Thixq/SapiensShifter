#!/bin/bash

set -e

SCHEME="Runner"
WORKSPACE="ios/Runner.xcworkspace"
CONFIGURATION="Release"
ARCHIVE_PATH="build/ios/archive/${SCHEME}.xcarchive"
EXPORT_PATH="build/ios/ipa"
EXPORT_OPTIONS_PLIST="ios/exportOptions.plist" 


echo "🚀 Starting Flutter build ios..."
flutter build ios --release --obfuscate --split-debug-info=build/symbols/


echo "📦Initializing Xcode archive..."
xcodebuild archive \
  -workspace "$WORKSPACE" \
  -scheme "$SCHEME" \
  -configuration "$CONFIGURATION" \
  -archivePath "$ARCHIVE_PATH" \
  -sdk iphoneos \
  CODE_SIGN_STYLE=Automatic \
  clean \
  archive


echo "📤 Starting IPA export..."
xcodebuild -exportArchive \
  -archivePath "$ARCHIVE_PATH" \
  -exportOptionsPlist "$EXPORT_OPTIONS_PLIST" \
  -exportPath "$EXPORT_PATH"

echo "✅ The process is complete!"
echo "📁 IPA path: $EXPORT_PATH"
