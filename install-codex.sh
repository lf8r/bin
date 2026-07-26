#!/bin/bash
set -e
sudo apt update
sudo apt install -y npm
sudo npm install -g @openai/codex@0.142.5

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
source ~/.bashrc
nvm install 22
source ~/.bashrc

mkdir -p ~/.codex
touch ~/.codex/config.toml
cp ~/bin/config.toml ~/.codex/config.toml
cd ~

# npx skills@latest add mattpocock/skills
rm -f ~/.codex/config.toml
mkdir -p ~/.agents/skills
rsync -Partv ~/bin/codex/* ~/.agents/skills
