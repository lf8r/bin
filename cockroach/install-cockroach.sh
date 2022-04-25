#!/bin/bash
sudo apt install curl
curl https://binaries.cockroachdb.com/cockroach-v21.2.9.linux-amd64.tgz | tar -xz && sudo cp -i cockroach-v21.2.9.linux-amd64/cockroach /usr/local/bin/
