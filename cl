export ANTHROPIC_AUTH_TOKEN=ollama
export ANTHROPIC_API_KEY=""
export ANTHROPIC_BASE_URL=http://localhost:11434

# Use this when Ollama is running on Linux. Don't foget to comment the version of this command for MacOS.
# claude --model qwen3.5:35b-a3b-q8_0 --dangerously-skip-permissions

# MODEL=gemma4:26b-mlx
# MODEL=qwen2.5-coder:32b
MODEL=qwen3.5:35b-a3b-coding-nvfp4

# Use this when Ollama is running on MacOS. Don't foget to comment the version of this command for Linux.
claude --model $MODEL --dangerously-skip-permissions
# Another model to consider for reviews is gemma4:31b-coding-mtp-bf16
# claude --model gemma4:31b-coding-mtp-bf16 --dangerously-skip-permissions