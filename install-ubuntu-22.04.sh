#!/bin/bash
set -e
sudo apt update 
sudo apt -y upgrade
sudo apt -y install git ssh net-tools
./install-postgres-client16.sh
./install-python3.sh
./install-docker-ce.sh