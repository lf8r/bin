#!/bin/bash
set -e
LLAMA_CACHE=/Volumes/FAST1/llama-models llama-server \
  -hf unsloth/Qwen3-Coder-Next-GGUF:UD-Q4_K_M \
  --port 8080 \
  --ctx-size 131072 \
  --jinja \
  --temp 1.0 \
  --top-p 0.95 \
  --min-p 0.01 \
  --top-k 40
