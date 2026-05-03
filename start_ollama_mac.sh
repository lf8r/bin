#!/bin/bash
set -e
OLLAMA_MLX=1 OLLAMA_HOST="0.0.0.0" OLLAMA_KEEP_ALIVE=5m OLLAMA_NUM_PARALLEL=4 OLLAMA_DEBUG=BUG=1 OLLAMA_FLASH_ATTENTION="1"  ollama serve 2>&1 | tee -a ~/.ollama/logs/server.log