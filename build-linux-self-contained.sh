#!/bin/bash

# Linux self-contained deployment script for Stream Deck VS Code Extension (.NET 9)
# This creates a larger package but doesn't require .NET runtime installation

set -e

echo "Building self-contained Stream Deck VS Code extension for Linux (.NET 9)..."

# Navigate to the project directory
cd StreamDeckVSC

# Clean previous builds
rm -rf bin/Release/net9.0/linux-x64-self-contained

# Build self-contained for Linux (larger but no runtime dependency)
dotnet publish StreamDeckVSC.csproj -c Release -r linux-x64 --self-contained true -o bin/Release/net9.0/linux-x64-self-contained

echo "Self-contained build completed successfully!"
echo "Output directory: StreamDeckVSC/bin/Release/net9.0/linux-x64-self-contained/"

# Navigate back to root
cd ..

# Create distribution package
DIST_DIR="dist/linux-x64-self-contained"
mkdir -p "$DIST_DIR"

# Copy necessary files
cp -r StreamDeckVSC/bin/Release/net9.0/linux-x64-self-contained/* "$DIST_DIR/"

echo "Self-contained distribution package created in: $DIST_DIR"
echo ""
echo "This version includes the .NET runtime and doesn't require separate installation."
echo "To install:"
echo "1. Copy the entire '$DIST_DIR' folder contents to:"
echo "   ~/.config/opendeck/plugins/com.nicollasr.streamdeckvsc/"
echo "2. Make the executable runnable: chmod +x ~/.config/opendeck/plugins/com.nicollasr.streamdeckvsc/com.nicollasr.streamdeckvsc"
