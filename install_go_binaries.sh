#!/bin/bash
sudo apt install -y graphviz
GOFLAGS=-mod=mod go install golang.org/x/perf/cmd/benchstat@latest
GOFLAGS=-mod=mod go install github.com/google/pprof@latest