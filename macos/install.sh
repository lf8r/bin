#!/bin/bash
set -e
cat .profile >> ~/.profile
cp .gitconfig ~/.
mkdir -p ~/go/src
mkdir -p ~/go/pkg/mod
mkdir -p ~/go/bin

