#!/bin/bash
set -e

echo "Restarting Docker..."
sudo systemctl restart docker.socket docker.service
echo "Docker restarted successfully."