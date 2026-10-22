#!/bin/bash
# Self-contained Codex launcher for Ollama
# No external config files needed

# Set environment variables
export OPENAI_BASE_URL="http://127.0.0.1:11434/v1"
export OPENAI_API_KEY="ollama"

# Launch Codex with explicit working directory
# -C tells Codex to use the current directory as the working root
# Since lxh does 'cd "$PWD"' before running this script, $PWD will be correct
/opt/homebrew/bin/codex -C "$PWD" --local-provider ollama -m qwen3-coder-next:latest --oss --no-daemon
