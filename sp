#!/bin/bash
set -e
cd ~/steeld
./build-portal.sh
./update-portal.sh
./start-portal.sh

