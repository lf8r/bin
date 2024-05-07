#!/bin/bash
set -e
sudo snap remove -y firefox
sudo apt remove -y firefox
sudo add-apt-repository -y ppa:mozillateam/ppa

FILE="/etc/apt/preferences.d/mozillateamppa"

sudo /bin/cat <<EOM >$FILE
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOM

sudo apt update
sudo apt -y install firefox


