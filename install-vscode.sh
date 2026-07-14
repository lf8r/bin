#!/bin/bash
set +e
sudo apt -y purge code code-insiders
sudo apt -y autoremove
set -e
# rm -rf ~/.vscode/extensions
sudo apt update
sudo apt install wget gpg software-properties-common apt-transport-https -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null
echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
#echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -y code code-insiders
cp ~/bin/Working2026.code-profile ~/.
echo "Choose ~/Working2026.code-profile as your profile in VS Code to get the recommended extensions and settings for working on the project."
