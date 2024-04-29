#!/bin/bash
set -e
# Cleanly reinstall docker-ce.
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt install -y docker-ce
sudo groupadd docker
sudo usermod -aG docker $USER
echo "====="
echo "Please logout and log back in again to inherit changes to user's groups.
echo "====="
