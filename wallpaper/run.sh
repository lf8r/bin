#!/bin/bash
set -e
. ./activate.sh
pip install pillow
HOSTIP=$(./get_ip.sh) python make_hostname_wallpaper.py

WALLPAPER="/home/${USER}/Pictures/hostname_wallpaper.png"
URI="file://$WALLPAPER"

gsettings set org.gnome.desktop.background picture-uri "$URI"
gsettings set org.gnome.desktop.background picture-uri-dark "$URI"
gsettings set org.gnome.desktop.background picture-options 'zoom'
