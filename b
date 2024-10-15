#!/bin/bash
set -e
make distclean && make generate && make test