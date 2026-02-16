#!/bin/bash
set -e
sudo apt purge code
sudo apt update
sudo apt install wget gpg software-properties-common apt-transport-https -y

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null

echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

sudo apt update

sudo apt install code

