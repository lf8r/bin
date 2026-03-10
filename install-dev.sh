#!/bin/bash
set -e

sudo apt install -y curl ssh net-tools build-essential libgeos-dev virt-manager ack htop time git-lfs dbus-x11 compizconfig-settings-manager libsecret-tools
sudo apt install -y gnome-keyring libsecret-1-0 libsecret-tools
git lfs install
install-postgres-client16.sh
install-python3.sh
install-firefox.sh
install-docker-ce.sh
install-vault.sh

# Notes
# Run ccsm and set General options -> Focus and Raise Behavior -> Focus Prevention Level to "Off"