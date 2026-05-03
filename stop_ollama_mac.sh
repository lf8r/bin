#!/bin/bash
set -e
PID_FILE=/Volumes/FAST3/.ollama/server.pid
if [ -f ${PID_FILE} ]; then
    pid=$(cat ${PID_FILE})
    echo "Killing existing Ollama server with PID: $pid"
    kill -9 "$pid" || true
fi
rm -rf ${PID_FILE} || true
#pkill ollama || true