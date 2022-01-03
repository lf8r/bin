#!/bin/bash
set -e
apt-get purge docker-ce docker-ce-cli containerd.io
apt -y autoremove
rm -rf /var/lib/docker
rm -rf /var/lib/containerd
