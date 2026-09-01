#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Error: model name required as first argument"
    echo "Usage: $0 <model-name> [claude-args...]"
    exit 1
fi

export MODEL="$1"
shift

export ANTHROPIC_AUTH_TOKEN="ollama"
export ANTHROPIC_API_KEY="ollama"
export ANTHROPIC_BASE_URL="http://localhost:11434"
claude --model "$MODEL" --dangerously-skip-permissions
