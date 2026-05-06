#!/bin/bash
set -e
wget https://ollama.com/download/ollama-linux-arm64.tar.zst | tar -xvf ollama-linux-arm64.tar.zst bin/ollama
chmod a+x bin/ollama
sudo mv bin/ollama /usr/local/bin/ollama