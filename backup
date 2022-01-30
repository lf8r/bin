#!/bin/bash
set -e
rsync -PartvL ~/backup2/. ~/backup3/. --exclude .Spot* --exclude /Users/*/Desktop/Relocated\ Items.nosync --exclude .TemporaryItems --exclude /**/.Trashes --exclude .Trashes
rsync -PartvL ~/backup1/. ~/backup2/. --exclude .Spot* --exclude /Users/*/Desktop/Relocated\ Items.nosync --exclude .TemporaryItems --exclude /**/.Trashes --exclude .Trashes
htoq
