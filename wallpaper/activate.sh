#!/bin/bash
set -e
OS=$(uname)
PLATFORM=$(uname -m)

if [ -d dev3.11 ]; then
  . dev3.11/bin/activate
else
  python3.11 -m venv dev3.11
  . dev3.11/bin/activate
fi

pip install --upgrade pip
set +e