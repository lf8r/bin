#!/bin/bash
#cd privateGPT
conda remove -n privategpt --all
set +e
conda create -n privategpt python=3.11
conda activate privategpt
poetry install --with ui,local
poetry run python scripts/setup
CMAKE_ARGS="-DLLAMA_METAL=on" pip install --force-reinstall --no-cache-dir llama-cpp-python
PGPT_PROFILES=local make run
