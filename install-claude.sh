#!/bin/bash
set -e
curl -fsSL https://claude.ai/install.sh | bash

cd ~/bin
mkdir -p ~/.claude/skills
rsync -Partv ~/bin/codex ~/.claude/skills