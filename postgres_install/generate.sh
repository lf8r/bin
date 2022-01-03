#!/bin/bash
set -e
sudo apt update
sudo apt install -yqqq postgresql postgresql-contrib
sudo sed -e '/127.0.0.1/ s/md5/trust/g' -i.bak /etc/postgresql/*/main/pg_hba.conf
