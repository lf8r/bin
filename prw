#!/bin/bash
set -e
cd $QUAKE/controllers/rackcontroller/main
echo "Building rack controller"
./build.sh
scp main sdasgupta@win:.
cd ../../serviceclient/main
echo "Building service client"
./build.sh
scp sc sdasgupta@win:.
