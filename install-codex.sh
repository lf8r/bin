#!/bin/bash
set -e
sudo apt update
sudo apt install -y npm
sudo npm install -g @openai/codex

mkdir -p ~/.codex
touch ~/.codex/config.toml
cp ~/bin/config.toml ~/.codex/config.toml
cd ~
npx skills@latest add mattpocock/skills
# git clone https://github.com/hyhmrright/brooks-lint.git /tmp/brooks-lint
# mkdir -p ~/.codex/skills/brooks-lint
# cp -r /tmp/brooks-lint/skills/* ~/.codex/skills/brooks-lint/