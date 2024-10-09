#!/bin/bash
set -e
sudo apt -y purge nodejs nvm npm turbo
set -e
cd /tmp
wget https://get.pnpm.io/install.sh
chmod +x install.sh
PNPM_VERSION=8.6.3 ./install.sh
source ~/.bashrc
pnpm env use --global 18.18.2
pnpm add -g turbo@^1.10.0
echo "source ~/.bashrc" >> ~/.profile
echo "export TURBO_FORCE=true" >> ~/.profile
echo "Please reboot me" 

