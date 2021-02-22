#!/bin/bash
set -e
cd $QUAKE
make clean && make dev-portal
cp portal/cmd/steelctl/steelctl ~/bin
cd portal/cmd/steeld
~/portal/start-portal.sh

