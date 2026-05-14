#!/bin/bash
set -e
sudo apt update
sudo apt install -y npm
sudo npm install -g @openai/codex

mkdir -p ~/.codex
cat >> ~/codex/config.toml << 'EOF'
[model_providers.ollama-custom]
name = "Ollama"
base_url = "http://localhost:11434/v1"
api_key = "ollama"

[profiles.dev]
model_provider = "ollama-custom"
model = "qwen3.6:27b-coding-mxfp8" # Or qwen2.5-coder:1.5b
EOF

