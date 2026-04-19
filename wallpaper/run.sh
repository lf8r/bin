#!/bin/bash
. ./activate.sh
HOSTIP=$(./get_ip.sh) python make_hostname_wallpaper.py

echo "Go to Settings|Appearance|Background, add the picture located at $HOME/Pictures/hostname_wallpaper.png and set it as the background."