#!/bin/bash
set -e
sudo -u postgres dropuser --if-exists ${USER}
sudo -u postgres dropuser --if-exists root
sudo -u postgres createuser -s ${USER}
sudo -u postgres createuser -s root
echo "Restart the VM, then run ./test.sh"
