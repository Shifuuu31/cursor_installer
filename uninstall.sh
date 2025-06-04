#!/bin/bash

# Cursor AI Uninstaller Script
# Website: https://cursor.so
# Author: shifuuu31
# Purpose: Cleanly uninstall Cursor AI and remove all related user files

set -e  # Exit on any error

# === Confirmation ===
echo "🧹 This will completely uninstall Cursor AI from your system."
read -p "Are you sure you want to continue? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "❌ Uninstall cancelled."
    exit 0
fi

echo "🔍 Checking for installed files..."

# === Remove Cursor app files ===
if [ -d "$HOME/.local/share/cursor" ]; then
    rm -rf "$HOME/.local/share/cursor"
    echo "✅ Removed Cursor app directory."
else
    echo "ℹ️ Cursor directory not found."
fi

# === Remove application shortcut ===
if [ -f "$HOME/.local/share/applications/cursor-ai.desktop" ]; then
    rm "$HOME/.local/share/applications/cursor-ai.desktop"
    echo "✅ Removed desktop shortcut."
else
    echo "ℹ️ Desktop shortcut not found."
fi

# === Remove alias from shell configs ===
sed -i '/alias cursor=/d' "$HOME/.bashrc" "$HOME/.zshrc" 2>/dev/null || true
echo "✅ Removed terminal alias (if it existed)."

# === Refresh application database ===
update-desktop-database "$HOME/.local/share/applications" &>/dev/null || true
echo "🔄 Application database updated."

echo -e "\n🎉 Cursor AI has been fully uninstalled from your system."
