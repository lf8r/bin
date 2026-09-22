#!/bin/bash
set -e
# You can run this command on this host or another one with which you'd like to update this ollama instance with.
ollama list | cut -d ' ' -f 1 > ollama_list_models
xargs -I {} ollama pull {} < ollama_list_models