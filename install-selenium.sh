#!/bin/bash
set -e
rm -rf /tmp/selenium && mkdir -p /tmp/selenium && cd /tmp/selenium
export VERSION=v0.35.0
wget https://github.com/mozilla/geckodriver/releases/download/$VERSION/geckodriver-$VERSION-linux-aarch64.tar.gz
tar -zxvf geckodriver-$VERSION-linux-aarch64.tar.gz
sudo mv geckodriver /usr/bin/
sudo rm /usr/local/bin/geckodriver
sudo ln -s /usr/bin/geckodriver /usr/local/bin/geckodriver
sudo apt install -y binfmt-support qemu-user-static