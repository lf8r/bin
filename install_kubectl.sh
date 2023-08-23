#!/bin/bash
set -e

# Install kubectl.
ARCH=`dpkg --print-architecture`
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$ARCH/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install k3d.
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

set +e
k3d cluster rm test
set -e
k3d cluster create test

# Install helm
cd /tmp && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod +x get_helm.sh && ./get_helm.sh

# Setup bash completion.
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
