#!/bin/bash
set -e
sudo rm -rf /user/local/go
ARCH=$(dpkg --print-architecture)
wget https://go.dev/dl/go1.24.0.linux-${ARCH}.tar.gz
sudo tar -C /usr/local -zxvf go1.24.0.linux-${ARCH}.tar.gz
export PATH=$PATH:/usr/local/go/bin
mkdir -p ~/go/bin
#go install golang.org/dl/go1.22.7@latest
