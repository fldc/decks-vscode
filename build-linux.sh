#!/bin/bash

# Linux deployment script for Stream Deck VS Code Extension (.NET 9)
# This script builds and packages the extension for Linux

set -e

echo "Building Stream Deck VS Code extension for Linux (.NET 9)..."

# Navigate to the project directory
cd StreamDeckVSC

# Clean previous builds
rm -rf bin/Release/net9.0/linux-x64

# Build for Linux (framework-dependent - requires .NET 9 runtime installed)
dotnet publish StreamDeckVSC.csproj -c Release -r linux-x64 --self-contained false

echo "Build completed successfully!"
echo "Output directory: StreamDeckVSC/bin/Release/net9.0/linux-x64/"

# Navigate back to root
cd ..

# Create distribution package
DIST_DIR="dist/linux-x64"
mkdir -p "$DIST_DIR"

# Copy necessary files
cp -r StreamDeckVSC/bin/Release/net9.0/linux-x64/* "$DIST_DIR/"

echo "Distribution package created in: $DIST_DIR"
echo ""
echo "To install:"
echo "1. Copy the entire '$DIST_DIR' folder to Stream Deck plugins directory"
echo "2. Linux Stream Deck plugin directory is typically:"
echo "   ~/.local/share/com.elgato.StreamDeck/Plugins/"
echo "3. Make the executable runnable: chmod +x com.nicollasr.streamdeckvsc"
