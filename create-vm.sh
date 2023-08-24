#!/bin/bash
set -e
VMNAME=$1
if [ -z "$1" ]
then
    echo "Missing virtual-machine-name in arguments"
    exit 1
fi

./setup-ovftools.sh
ovftool --name=${VMNAME} ~/vms/template.ova ~/vms/.