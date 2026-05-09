#!/bin/bash
set -e

# This command uses a 256K context length.
# OLLAMA_MLX=1 OLLAMA_HOST="0.0.0.0" OLLAMA_KEEP_ALIVE=5m OLLAMA_NUM_PARALLEL=4 OLLAMA_DEBUG=1 OLLAMA_FLASH_ATTENTION="1" OLLAMA_CONTEXT_LENGTH=262144 ollama serve 2>&1 | tee -a ~/.ollama/logs/server.log &

# This command uses a 128K context length.
# OLLAMA_MLX=1 OLLAMA_HOST="0.0.0.0" OLLAMA_KEEP_ALIVE=5m OLLAMA_NUM_PARALLEL=4 OLLAMA_DEBUG=1 OLLAMA_FLASH_ATTENTION="1" OLLAMA_CONTEXT_LENGTH=131072  /opt/homebrew/opt/ollama/bin/ollama serve 2>&1 | tee -a ~/.ollama/logs/server.log &
OLLAMA_MLX=1 OLLAMA_HOST="0.0.0.0" OLLAMA_KEEP_ALIVE=5m OLLAMA_NUM_PARALLEL=4 OLLAMA_DEBUG=1 OLLAMA_FLASH_ATTENTION="1" OLLAMA_CONTEXT_LENGTH=131072  /opt/homebrew/opt/ollama/bin/ollama serve

echo $! > ~/.ollama/pid