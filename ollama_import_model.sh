#!/bin/bash

# Check if running on Mac
if [[ "$(uname)" != "Darwin" ]]; then
    echo "Error: This script only runs on macOS"
    exit 1
fi

# Check arguments
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <fully_qualified_file_path.gguf>ß"
    exit 1
fi

file_path="$1"

# Check if file exists and ends with .gguf
if [[ ! -f "$file_path" ]]; then
    echo "Error: File '$file_path' does not exist"
    exit 1
fi

if [[ ! "$file_path" =~ \.gguf$ ]]; then
    echo "Error: File must end with .gguf"
    exit 1
fi

# Get just the filename for the Modelfile and use this as the model name.
file_name=$(basename "$file_path")
custom_model_name="$file_name"

# Create Modelfile on a single line
echo "FROM $file_path" > Modelfile

# Run ollama create command
ollama create "$custom_model_name" -f ./Modelfile
