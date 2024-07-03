#!/bin/bash
set -e
OS=$(uname)
PLATFORM=$(uname -m)

rm -rf dev3.11
python3.11 -m venv dev3.11

. dev3.11/bin/activate

# Perform the following step only on MacOS, to enable git completions.
if [ "${OS}" == "Darwin" ]; then
source ~/.bashrc
fi

pip install --upgrade pip

set +e
pip3 install -r requirements.txt
