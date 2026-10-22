#!/bin/bash
set -e

# Detect OS and run appropriate uninstallation
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS uninstallation
    echo "Uninstalling Codex on macOS..."
    
    # Remove the codex-local.sh script
    rm -f ~/codex-local.sh
    
    # Remove Codex skills folder
    rm -rf ~/.codex/skills
    
    # Remove AGENTS.md if it was copied from codex
    rm -f ~/.codex/AGENTS.md
    
    # Uninstall Codex via Homebrew
    echo "Uninstalling Codex via Homebrew..."
    brew uninstall --cask codex
    
    echo "Codex uninstalled successfully on macOS!"
else
    # Linux uninstallation (original)
    echo "Uninstalling Codex on Linux..."
    sudo npm uninstall -g @openai/codex
    rm -rf ~/.codex
    sudo apt -y autoremove
    sudo apt -y autoclean
    echo "Codex uninstalled successfully on Linux!"
fi
