#!/bin/bash
set -e

# Parse command line arguments
MODEL_NAME=""
PROVIDER_URL=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --help|-h)
            echo "Usage: cl [options] [model-name]"
            echo ""
            echo "Options:"
            echo "  --provider=URL, -p URL  Set the provider URL (default: http://localhost:11434)"
            echo "  --help, -h              Show this help message"
            exit 0
            ;;
        --provider=*|-p=*)
            PROVIDER_URL="${1#*=}"
            shift
            ;;
        --provider|-p)
            if [[ -n $2 ]] && [[ $2 != -* ]]; then
                PROVIDER_URL="$2"
                shift 2
            else
                echo 'Error: -p requires a value' >&2
                exit 1
            fi
            ;;
        *)
            if [[ -z "$MODEL_NAME" ]]; then
                MODEL_NAME="$1"
            else
                echo "Unknown option: $1" >&2
                exit 1
            fi
            shift
            ;;
    esac
done

# Use default model if none specified
if [[ -z "$MODEL_NAME" ]]; then
    MODEL_NAME="qwen3-coder-next:latest"
fi

# Use default URL if provider not specified
if [[ -z "$PROVIDER_URL" ]]; then
    PROVIDER_URL="http://localhost:11434"
fi

export MODEL="$MODEL_NAME"

# Use ollama as the auth token, empty API key for local Ollama
export ANTHROPIC_AUTH_TOKEN="ollama"
export ANTHROPIC_API_KEY=""
export ANTHROPIC_BASE_URL="$PROVIDER_URL"
claude --model "$MODEL" --dangerously-skip-permissions
