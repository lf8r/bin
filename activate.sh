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

if test -f requirements.txt; then
  echo "File exists."
  set +e
  pip3 install -r requirements.txt
fi

