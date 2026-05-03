#!/usr/bin/env bash

# For macOS (Apple Silicon / Intel, no NVIDIA)
LOG_FILE="$HOME/.ollama/logs/server.log"
LOG_TAIL="tail -n 100 "

LOG_SHOW_LINES=15
REFRESH=2

# Check if Ollama is in PATH
if ! command -v ollama >/dev/null 2>&1; then
    printf "ERROR: 'ollama' not in PATH.\n"
    printf "If you installed via the .dmg, try: /Applications/Ollama.app/Contents/Resources/ollama\n"
    exit 1
fi

# Check log file
if [ ! -f "$LOG_FILE" ]; then
    printf "WARNING: Log file not found at $LOG_FILE\n"
    printf "On macOS, Ollama logs are typically at ~/.ollama/logs/server.log\n"
    printf "Press Enter to continue anyway, or Ctrl+C to exit...\n"
    read -r _
fi

clear
trap 'printf "\n"; exit 0' INT TERM

if true; then
    clear

    printf "=== OLLAMA STATUS on macOS (%s) ===\n\n" "$(date)"

    # 1) Running models (ollama ps)
    printf "【 RUNNING MODELS 】\n"
    ollama ps 2>&1 | sed -e 's/^/  /' || echo "  (ollama not running or not in PATH)"

    # 2) Recent requests from server.log
    printf "\n【 RECENT REQUESTS (from %s) 】\n" "$LOG_FILE"
    tail -n 100 ~/.ollama/logs/server.log | grep -i -E "(POST /api/(generate|chat)|starting|loaded|session|model)" | tail -n 5

    # 3) GPU / Metal hints on Apple Silicon / Intel
    printf "\n【 GPU / METAL HINTS (macOS) 】\n"
    # Show if Metal is enabled (helps confirm GPU use)
    sys_prof=$(system_profiler SPDisplaysDataType 2>/dev/null | grep -i metal)
    if [ -n "$sys_prof" ]; then
        echo "  Metal GPU: $(echo "$sys_prof" | head -n1 | sed 's/^/  /')"
    else
        echo "  Metal: could not detect; check OLLAMA_METAL=1 if using Apple Silicon"
    fi

    # Show CPU load (a proxy for “how busy” inference is)
    top_line=$(top -l 1 -n 0 | grep -E "Load Avg" | head -n1)
    if [ -n "$top_line" ]; then
        echo "  System Load: $top_line"
    fi

    # Optional: uncomment to see all Ollama‑related processes
    echo "  Ollama processes:"
    ps aux | grep -i ollama | grep -v grep | sed 's/^/    /'

    printf "\nRefresh: every %ss | Press Ctrl+C to exit\n" "$REFRESH"
    sleep "$REFRESH"
fi
