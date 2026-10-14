#!/bin/bash
set -e
ollama list | cut -d ' ' -f 1 | grep -v NAME | xargs -L 1 ollama pull