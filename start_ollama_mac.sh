#!/bin/bash
set -e
export OLLAMA_HOST="0.0.0.0"
export OLLAMA_MAX_LOADED_MODELS=6
export OLLAMA_NUM_PARALLEL=4
export OLLAMA_MAX_QUEUE=512
export OLLAMA_CONTEXT_LENGTH=16384
pkill ollama || true
nohup ollama serve &

