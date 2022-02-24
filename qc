#!/bin/bash
set -e
DIR=`pwd`
cd $QUAKE
git diff `pb` --name-only > .names
xargs goimports -local github.com/hpe-hcss/quake,github.com/lf8r -w < .names
rm .names
cd $DIR
