#!/bin/bash
set -e
lms server start --port 2345 --bind 0.0.0.0
lms log stream