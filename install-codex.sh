#!/bin/bash
set -e
sudo apt update
sudo apt install -y npm
sudo npm install -g @openai/codex

mkdir -p ~/.codex
touch ~/.codex/config.toml
cp config.toml ~/.codex/config.toml
