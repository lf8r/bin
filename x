#!/bin/bash
set -e

# Parse command line arguments
MODEL_NAME=""
PROVIDER_URL=""
DRYRUN=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --dryrun)
            DRYRUN=true
            shift
            ;;
        --help|-h)
            echo 'Usage: x [OPTIONS] [MODEL]'
            echo ''
            echo 'Options:'
            echo '  --provider=URL, -p=URL  Set provider URL'
            echo '  --provider URL, -p URL  Set provider URL'
            echo '  --model=NAME, -m NAME   Model alias or name'
            echo '  --dryrun                Show command without executing'
            echo '  --help, -h              Show this help message'
            echo ''
            echo 'Model aliases:'
            echo '  @std                    Use qwen3-coder-next:latest'
            echo '  @medium                 Use qwen3-coder-next:q8_0'
            echo '  @large                  Use qwen3-coder-next:q8_0'
            echo '  @extra                  Use qwen3.8-flash-next:125b-mlx'
            echo ''
            echo 'Default model: qwen3-coder-next:latest'
            echo 'Default provider: http://localhost:11434/v1'
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
        --model=*|-m=*)
            MODEL_NAME="${1#*=}"
            shift
            ;;
        --model|-m)
            if [[ -n $2 ]] && [[ $2 != -* ]]; then
                MODEL_NAME="$2"
                shift 2
            else
                echo 'Error: -m requires a value' >&2
                exit 1
            fi
            ;;
        *)
            echo "Unknown option: $1" >&2
            exit 1
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

CMD="OPENAI_BASE_URL=\"$PROVIDER_URL\" OPENAI_API_KEY=\"ollama\" codex --oss -m \"$MODEL_NAME\" --yolo"

if [[ "$DRYRUN" == "true" ]]; then
    echo "$CMD"
    exit 0
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$CMD"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    eval "$CMD"
else
    echo "Unsupported OS: $OSTYPE" >&2
    exit 1
fi
