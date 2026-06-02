export ANTHROPIC_AUTH_TOKEN=ollama
export ANTHROPIC_API_KEY=""
export ANTHROPIC_BASE_URL=http://localhost:11434

# Use this when Ollama is running on Linux. Don't foget to comment the version of this command for MacOS.
# claude --model qwen3.5:35b-a3b-q8_0 --dangerously-skip-permissions

# Use this when Ollama is running on MacOS. Don't foget to comment the version of this command for Linux.
claude --model qwen3.5:35b-a3b-coding-nvfp4 --dangerously-skip-permissions
