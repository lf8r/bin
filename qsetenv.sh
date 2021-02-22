#!/bin/sh
# Set GOFLAGS to make sure our go.mod is up to date.
. setgo go12
export GOFLAGS=-mod=vendor
export TMP=/var/tmp
#export GOPATH=$TMP/.g2
#mkdir -p $GOPATH
#export GOBIN=$GOPATH/bin
#export PATH=$GOPATH/bin:$PATH
#mkdir -p $GOBIN
setpg pg10
cd ~/dev/github.com/quattronetworks/quake
