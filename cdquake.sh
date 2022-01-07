#!/bin/sh
. ~/.profile
cd $QUAKE
GO111MODULE=on
GOFLAGS=-mod=vendor
GOPATH=$HOME/go
