#!/bin/sh
echo "Set environment for non-quake development"
# Set GOFLAGS to make sure our go.mod is up to date.
export GOFLAGS=-mod=readonly
export TMP=/var/tmp
export GOPATH=$TMP/.g2
mkdir -p $GOPATH
export GOBIN=$GOPATH/bin
export PATH=$GOPATH/bin:$PATH
mkdir -p $GOBIN
setgo go14
setpg pg12
