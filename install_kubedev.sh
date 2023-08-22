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

# Install it
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Setup bash completion.
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null

# Install k3s
curl -sfL https://get.k3s.io | sh -
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config && chown ${USER} ~/.kube/config && chmod 600 ~/.kube/config && export KUBECONFIG=~/.kube/config


# Install helm
cd /tmp && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod +x get_helm.sh && ./get_helm.sh

