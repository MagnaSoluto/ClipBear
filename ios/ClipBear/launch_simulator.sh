#!/bin/bash

# ClipBear iOS Simulator Launcher
# Solves the "No such process" error by manually installing and launching

set -e

echo "🚀 ClipBear iOS Simulator Launcher"
echo "=================================="

# Check if we're in the right directory
if [ ! -f "ClipBear.xcodeproj/project.pbxproj" ]; then
    echo "❌ Error: Run this script from the ios/ClipBear directory"
    exit 1
fi

# Build the app
echo "📦 Building ClipBear..."
xcodebuild -project ClipBear.xcodeproj -scheme ClipBear -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build -quiet

if [ $? -ne 0 ]; then
    echo "❌ Build failed!"
    exit 1
fi

echo "✅ Build successful!"

# Find the built app
APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData -name "ClipBear.app" -path "*/Debug-iphonesimulator/*" | grep -v Index.noindex | head -1)

if [ -z "$APP_PATH" ]; then
    echo "❌ Error: Could not find built app"
    exit 1
fi

echo "📱 Found app at: $APP_PATH"

# Get simulator device
DEVICE_ID=$(xcrun simctl list devices | grep "iPhone 17 Pro" | grep "Booted" | head -1 | sed 's/.*(\([^)]*\)).*/\1/')

if [ -z "$DEVICE_ID" ]; then
    echo "📱 Starting iPhone 17 Pro simulator..."
    xcrun simctl boot "iPhone 17 Pro"
    sleep 3
    DEVICE_ID=$(xcrun simctl list devices | grep "iPhone 17 Pro" | grep "Booted" | head -1 | sed 's/.*(\([^)]*\)).*/\1/')
fi

echo "📱 Using device: $DEVICE_ID"

# Install the app
echo "📲 Installing ClipBear..."
xcrun simctl install "$DEVICE_ID" "$APP_PATH"

if [ $? -ne 0 ]; then
    echo "❌ Installation failed!"
    exit 1
fi

echo "✅ Installation successful!"

# Launch the app
echo "🚀 Launching ClipBear..."
xcrun simctl launch "$DEVICE_ID" com.clipbear.mvp

if [ $? -eq 0 ]; then
    echo "✅ ClipBear launched successfully!"
    echo "📱 Check your simulator - the app should be running now"
else
    echo "❌ Launch failed!"
    exit 1
fi

echo ""
echo "🎉 Done! ClipBear is now running on the simulator"
echo "💡 If you see any issues, check the simulator logs"
