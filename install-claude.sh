#!/bin/bash
set -e

# Detect OS and run appropriate installation
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS installation
    echo "Installing Claude via official installer on macOS..."
    curl -fsSL https://claude.ai/install.sh | bash

    # Copy sclaude to home directory
    cp ~/bin/sclaude ~/sclaude

    # Copy skills to Claude skills folder
    mkdir -p ~/.claude/skills
    if [ -d ~/bin/claude ]; then
        rsync -Partv ~/bin/claude/* ~/.claude/skills/
    fi

    # Copy AGENTS.md if it exists
    if [ -f ~/bin/claude/AGENTS.md ]; then
        cp ~/bin/claude/AGENTS.md ~/.claude/.
    fi

    echo "Claude installed successfully on macOS!"
else
    # Linux installation
    echo "Installing Claude via official installer on Linux..."
    curl -fsSL https://claude.ai/install.sh | bash

    mkdir -p ~/.claude
    touch ~/.claude/config.toml
    cp ~/bin/config.toml ~/.claude/config.toml
    cd ~

    # Copy skills to agents skills folder
    mkdir -p ~/.agents/skills
    rsync -Partv ~/bin/claude/* ~/.agents/skills

    cp ~/bin/claude/AGENTS.md ~/.claude/.

    echo "Claude installed successfully on Linux!"
fi
