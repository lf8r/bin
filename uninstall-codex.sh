#!/bin/bash
set -e

# Detect OS and run appropriate uninstallation
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS uninstallation
    # Uninstall Codex via npm
    echo "Uninstalling Codex on MacOS..."
    sudo npm uninstall -g @openai/codex

    # Remove the codex-local.sh script
    rm -f ~/codex-local.sh

    # Remove Codex skills folder
    rm -rf ~/.codex/skills

    # Remove AGENTS.md if it was copied from codex
    rm -f ~/.codex/AGENTS.md


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
