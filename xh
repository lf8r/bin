#!/bin/bash
set -e

# Parse command line arguments
MODEL_NAME=""
PROVIDER_URL=""

while [[ $# -gt 0 ]]; do
    case $1 in
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
    PROVIDER_URL="http://localhost:11434/v1"
fi

# Handle @ prefixed model names
case "$MODEL_NAME" in
    "@std")
        MODEL_NAME="qwen3-coder-next:latest"
        ;;
    "@medium")
        MODEL_NAME="qwen3-coder-next:q8_0"
        ;;
    "@large")
        MODEL_NAME="qwen3-coder-next:q8_0"
        ;;
    "@extra")
        MODEL_NAME="qwen3.8-flash-next:125b-mlx"
        ;;
esac

if [[ "$OSTYPE" == "darwin"* ]]; then
    OPENAI_BASE_URL="$PROVIDER_URL" OPENAI_API_KEY="ollama" codex --oss -m "$MODEL_NAME" --yolo
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OPENAI_BASE_URL="$PROVIDER_URL" OPENAI_API_KEY="ollama" codex --oss -m "$MODEL_NAME" --yolo
else
    echo "Unsupported OS: $OSTYPE" >&2
    exit 1
fi
