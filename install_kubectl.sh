#!/bin/bash
set -e

export URL=""
ARCH=`uname -m`

if [[ "$ARCH" == "aarch64" ]]
then
export URL="https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
fi

if [[ "$ARCH" == "x86_64" ]] 
then
export URL="https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
fi

echo ${URL}

if [[ "$ARCH" == "" ]]
then
    echo "Unsupported platform, only AMD64 and ARM64 are supported."
    exit 1
fi

# Download kubectl
cd /tmp
curl -LO ${URL}

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
