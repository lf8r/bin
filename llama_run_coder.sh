#!/bin/bash
set -e
llama-server \
  -m /Volumes/FAST1/llama-models/Qwen3-Coder-Next-UD-Q4_K_XL.gguf \
  --alias qwen3-coder-next-cdx \
  --verbose \
  --host 0.0.0.0 \
  --port 8080 \
  --ctx-size 131072 \
  --jinja \
  --temp 1.0 \
  --top-p 0.95 \
  --min-p 0.01 \
  --top-k 40