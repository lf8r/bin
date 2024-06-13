#!/bin/bash
set -e
sudo apt -y install python3-venv
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.11
sudo apt install python3.11-venv
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11

