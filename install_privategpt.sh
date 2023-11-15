#!/bin/bash
set -e
cd $HOME
git clone git@github.com:imartinez/privateGPT.git

pyenv install 3.11
pyenv local 3.11

curl -sSL https://install.python-poetry.org | python3 -

echo "export PATH=/home/sdasgupta/.local/bin:$PATH" >> ~/.bashrc
exec $SHELL

poetry install
poetry install --with ui
