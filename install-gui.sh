#!/bin/bash

# Install xubuntu-core with US English keyboard layout
sudo apt-get update
sudo apt-get install --no-install-recommends xubuntu-core locales
sudo localectl set-keymap us

# Install xrdp
sudo apt-get install --no-install-recommends xrdp

# Configure user session
echo "xfce4-session" > ~/.xsession

# Restart xrdp service
sudo systemctl restart xrdp
