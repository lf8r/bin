#!/bin/bash
set -e
rm -f ~/bin/ovftool
ln -s "/Applications/VMware Fusion.app/Contents/Library/VMware OVF Tool/ovftool" ~/bin/.
ovftool --help