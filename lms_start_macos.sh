#!/bin/bash

# Define the path to the lms binary inside the macOS application wrapper
LMS="/Users/sdasgupta/.lmstudio/bin/lms"

# Graceful cleanup function triggered on Ctrl-C or kill signals
cleanup() {
    echo -e "\n\nStopping LM Studio services..."
    "$LMS" server stop >/dev/null 2>&1
    "$LMS" daemon down >/dev/null 2>&1
    echo "Services stopped cleanly."
    exit 0
}

# Trap SIGINT (Ctrl-C) and SIGTERM (used by pkill/kill)
trap cleanup INT TERM

echo "Starting LM Studio Headless Daemon and Server..."
# 1. Bring up the underlying llmster inference engine
"$LMS" daemon up

# 2. Start the OpenAI-compatible HTTP local API server
# Added --cors and bound to localhost (add --host 0.0.0.0 if you need network access)
"$LMS" server start --port 1234 --bind 0.0.0.0

echo "------------------------------------------------------"
echo "LM Studio is running in the FOREGROUND."
echo "Streaming logs below. Press Ctrl-C to exit & stop server."
echo "Alternatively, run from another terminal: pkill -f lms-foreground.sh"
echo "------------------------------------------------------"

# 3. Stream the live logs directly to the terminal screen.
# Running this via a background loop allows our trap to catch the Ctrl-C seamlessly.
"$LMS" log stream &
LOG_PID=$!

# Wait for the log stream process to exit or be interrupted
wait $LOG_PID

# Run cleanup if the log stream terminates on its own
cleanup
