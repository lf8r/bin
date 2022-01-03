#!/bin/bash
sudo groupadd docker
sudo usermod -aG docker $USER
echo "Please logout and log back in"
