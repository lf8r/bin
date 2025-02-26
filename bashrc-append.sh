#!/bin/bash
set -e
cat >> ~/.bashrc <<EOF
PATH=~/bin:$PATH
alias sa="source ./activate.sh"
alias da="deactivate"
alias sac="rm -rf dev3.11 && source ./activate.sh"
alias dac="deactivate && rm -rf dev3.11"
EOF
