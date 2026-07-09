#!/bin/bash
set -euo pipefail

# Prompt the user for confirmation that they want to restore the state of the repository from a saved change.
read -p "Are you sure you want to restore the state of the repository from the diff saved at /var/tmp/changes.diff? This will overwrite any uncommitted changes. (y/n): " confirm

if [[ "$confirm" != "y" ]]; then
    echo "Operation cancelled."
    exit 1
fi

git reset --hard HEAD
# Change to the git repository base directory.
cd "$(git rev-parse --show-toplevel)"
git apply /var/tmp/changes.diff