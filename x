#!/bin/bash
set -e

# Auto-source .x-config from CWD up to HOME
source_x_config() {
    local dir="$PWD"
    local home="$HOME"
    while [[ "$dir" != "/" && "$dir" != "$home" ]]; do
        local config_file="$dir/.x-config"
        if [[ -f "$config_file" ]]; then
            source "$config_file"
            return 0
        fi
        dir=$(dirname "$dir")
    done
    # Also check HOME directory explicitly
    local config_file="$home/.x-config"
    if [[ -f "$config_file" ]]; then
        source "$config_file"
        return 0
    fi
    return 1
}

source_x_config || true

# Expand MODEL_NAME from config if it matches a variable name
# This allows: x -m $large to work even without manual sourcing
if [[ "$MODEL_NAME" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
    eval "config_value=\${$MODEL_NAME-}"
    if [[ -n "$config_value" ]]; then
        MODEL_NAME="$config_value"
    fi
fi

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
            echo 'Model aliases are defined in .x-config files (searched from CWD up to HOME).'
            echo 'Example .x-config contents:'
            echo '  m3=http://192.168.1.20:11434/v1'
            echo '  CODING=qwen3-coder-next:latest'
            echo '  LARGE=qwen3-coder-next:q8_0'
            echo ''
            echo 'Usage: x -p $m3 -m $CODING'
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

# If MODEL_NAME matches a config variable, expand it
# This handles cases like: x -m $large where $large is not defined in caller's shell
if [[ "$MODEL_NAME" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
    # Check if this is a variable name (not a literal model name with / or : or -)
    eval "expanded_value=\${$MODEL_NAME-}"
    if [[ -n "$expanded_value" ]]; then
        MODEL_NAME="$expanded_value"
    fi
fi

# Use default URL if provider not specified
if [[ -z "$PROVIDER_URL" ]]; then
    PROVIDER_URL="http://localhost:11434/v1"
fi

# Expand PROVIDER_URL from config if it matches a variable name
if [[ "$PROVIDER_URL" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
    eval "expanded_value=\${$PROVIDER_URL-}"
    if [[ -n "$expanded_value" ]]; then
        PROVIDER_URL="$expanded_value"
    fi
fi

# Strictly require full URL with http:// or https:// prefix
if [[ "$PROVIDER_URL" != http://* ]] && [[ "$PROVIDER_URL" != https://* ]]; then
    echo "Error: Provider URL must include the protocol prefix (http:// or https://)" >&2
    echo "Usage: x -p http://your-provider:11434/v1 [options]" >&2
    exit 1
fi

# Strictly require /v1 path
if [[ "$PROVIDER_URL" != */v1 ]]; then
    echo "Error: Provider URL must end with /v1 (OpenAI-compatible endpoint path)" >&2
    echo "Usage: x -p http://your-provider:11434/v1 [options]" >&2
    exit 1
fi

# Verify the provider endpoint is accessible before starting
if [[ "$DRYRUN" != "true" ]]; then
    echo "Verifying provider endpoint: $PROVIDER_URL"
    if ! curl --silent --show-error --fail -o /dev/null "$PROVIDER_URL/models" 2>/dev/null; then
        echo "Error: Unable to connect to OpenAI-compatible endpoint at $PROVIDER_URL" >&2
        echo "Please ensure the provider is running and accessible." >&2
        exit 1
    fi
    echo "Endpoint verified successfully."
fi

CMD="codex -c 'model_providers.codex-temp.base_url=${PROVIDER_URL}' -c 'model_providers.codex-temp.name=Codex Temp' --oss --local-provider codex-temp -m '$MODEL_NAME' --yolo"

if [[ "$DRYRUN" == "true" ]]; then
    echo "$CMD"
    exit 0
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    exec bash -c "$CMD"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    exec bash -c "$CMD"
else
    echo "Unsupported OS: $OSTYPE" >&2
    exit 1
fi
