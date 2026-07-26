#!/bin/bash
set -e
sudo npm uninstall -g @openai/codex
rm -rf ~/.codex
sudo apt -y autoremove
sudo apt -y autoclean