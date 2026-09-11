#!/bin/bash

# Check if running on Mac
if [[ "$(uname)" != "Darwin" ]]; then
    echo "Error: This script only runs on macOS"
    exit 1
fi

# Check arguments
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <fully_qualified_file_path.gguf> <custom-model-name>"
    exit 1
fi

file_path="$1"
custom_model_name="$2"

# Check if file exists and ends with .gguf
if [[ ! -f "$file_path" ]]; then
    echo "Error: File '$file_path' does not exist"
    exit 1
fi

if [[ ! "$file_path" =~ \.gguf$ ]]; then
    echo "Error: File must end with .gguf"
    exit 1
fi

# Get just the filename for the Modelfile
file_name=$(basename "$file_path")

# Create Modelfile on a single line
echo "FROM $file_name" > Modelfile

# Run ollama create command
ollama create "$custom_model_name" -f ./Modelfile
