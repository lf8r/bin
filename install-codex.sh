#!/bin/bash
set -e
sudo apt update
sudo apt install -y npm
sudo npm install -g @openai/codex@0.142.5

mkdir -p ~/.codex
touch ~/.codex/config.toml
cp ~/bin/config.toml ~/.codex/config.toml
cd ~
npx skills@latest add mattpocock/skills
rm -f ~/.codex/config.toml
rsync -Partv ~/bin/codex ~/.agents/skills
