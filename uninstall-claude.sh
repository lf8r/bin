#!/bin/bash
set -e

# Detect OS and run appropriate uninstallation
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS uninstallation
    echo "Uninstalling Claude on macOS..."

    # Remove the sclaude script
    rm -f ~/sclaude

    # Remove Claude skills folder
    rm -rf ~/.claude/skills

    # Remove AGENTS.md if it was copied from claude
    rm -f ~/.claude/AGENTS.md

    echo "Claude uninstalled successfully on macOS!"
else
    # Linux uninstallation
    echo "Uninstalling Claude on Linux..."
    
    # Remove Claude skills folder
    rm -rf ~/.claude/skills
    
    # Remove agents skills folder
    rm -rf ~/.agents/skills

    # Remove config files
    rm -rf ~/.claude

    echo "Claude uninstalled successfully on Linux!"
fi
