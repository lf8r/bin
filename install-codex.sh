#!/bin/bash
set -e

# Detect OS and run appropriate installation
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS installation
    echo "Installing Codex via Homebrew on macOS..."
    brew install --cask codex
    
    # Copy codex-local.sh to home directory
    cp ~/bin/codex-local.sh ~/codex-local.sh
    
    # Copy skills to Codex skills folder
    mkdir -p ~/.codex/skills
    if [ -d ~/bin/codex ]; then
        rsync -Partv ~/bin/codex/* ~/.codex/skills/
    fi
    
    # Copy AGENTS.md if it exists
    if [ -f ~/bin/codex/AGENTS.md ]; then
        cp ~/bin/codex/AGENTS.md ~/.codex/.
    fi
    
    echo "Codex installed successfully on macOS!"
else
    # Linux installation (original)
    echo "Installing Codex via npm on Linux..."
    sudo apt update
    sudo apt install -y npm
    sudo npm install -g @openai/codex@0.154.0
    
    mkdir -p ~/.codex
    touch ~/.codex/config.toml
    cp ~/bin/config.toml ~/.codex/config.toml
    cd ~

    # npx skills@latest add mattpocock/skills
    mkdir -p ~/.agents/skills
    rsync -Partv ~/bin/codex/* ~/.agents/skills

    cp ~/bin/codex/AGENTS.md ~/.codex/.
    
    echo "Codex installed successfully on Linux!"
fi
