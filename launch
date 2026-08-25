#!/bin/bash
# Launch a bash command in a new GNOME Terminal window

if [ $# -eq 0 ]; then
    echo "Usage: launch <bash_command>"
    echo "Example: launch 'echo hello && sleep 5'"
    exit 1
fi

gnome-terminal -- bash -c "$*"
