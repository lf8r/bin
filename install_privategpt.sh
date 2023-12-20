#!/bin/bash
set -e
# conda must be installed using the Anaconda installer for macOS -- 
# Download the 64-bit Graphical Installer available at https://repo.anaconda.com/archive/Anaconda3-2023.09-0-MacOSX-arm64.pkg
# Double-click the download ".pkg" file - choosing "Install for all users" (which prompts you for a folder location).
# Finally, close and re-open your terminal, and re-run this script.
cd $HOME
rm -rf privateGPT
git clone git@github.com:imartinez/privateGPT.git
cd privateGPT
start_privategpt.sh