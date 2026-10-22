#!/bin/bash
set -e
sudo apt -y install python3-pip
sudo apt -y install python3-venv
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt install -y python3.11
sudo apt install -y python3.11-venv
sudo apt install -y python3.11-tk
sudo apt install -y python3.11-dev

# Ruff formatter for Python code.
sudo snap install ruff --classic
# Required for web browser automation with playwright (see https://playwright.dev/python/docs/intro).
sudo apt install -y libavif16
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11

