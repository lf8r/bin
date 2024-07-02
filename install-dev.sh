#!/bin/bash
set -e
sudo apt install build-essential libgeos-dev
install-postgres-client16.sh
install-python3.sh
install-firefox.sh
install-docker-ce.sh
