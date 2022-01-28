#!/bin/bash
set -e
rsync -PartvL ~/backup2/. ~/backup3/.
rsync -PartvL ~/backup1/. ~/backup2/.
htoq