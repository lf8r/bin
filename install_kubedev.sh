#!/bin/bash
set -e

# Install k3s
mkdir -p /tmp/k3s
cd /tmp/k3s
curl -sfL https://get.k3s.io | sudo bash -
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config && sudo chown ${USER}:${USER} ~/.kube/config && chmod 600 ~/.kube/config && export KUBECONFIG=~/.kube/config


# Install helm
cd /tmp && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod +x get_helm.sh && ./get_helm.sh

# Setup bash completion.
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
