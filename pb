#!/bin/bash
git show-branch -a 2>/dev/null | grep '\*' | grep -v `cb` | head -n1 | sed 's/.*\[\(.*\)\].*/\1/' | sed 's/[\^~].*//'
