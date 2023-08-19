#!/bin/bash
export GOFLAGS=-mod=mod
go install github.com/jstemmer/go-junit-report/v2@latest
go install github.com/wadey/gocovmerge@latest
go install github.com/axw/gocov/gocov@latest
go install github.com/AlekSi/gocov-xml@latest

helm completion bash | sudo tee /etc/bash_completion.d/helm