#!/bin/bash
set -e
docker system prune --all --force
docker system prune --volumes --force
