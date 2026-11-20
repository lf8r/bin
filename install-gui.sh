#!/bin/bash

# Set locale and debconf environment variables
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NOWARNINGS=yes
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Pre-seed keyboard-configuration to skip interactive prompts
sudo debconf-set-selections <<EOF
keyboard-configuration keyboard-configuration/layoutcode string us
keyboard-configuration keyboard-configuration/layout select English (US)
keyboard-configuration keyboard-configuration/variant select English (US)
keyboard-configuration keyboard-configuration/model select Generic 105-key PC (intl.)
keyboard-configuration keyboard-configuration/modelcode string pc105
keyboard-configuration keyboard-configuration/xkb-keymap select us
EOF

# Install xubuntu-core and locales unattended (-E preserves DEBIAN_FRONTEND)
sudo -E apt-get update -y
sudo -E apt-get install -y --no-install-recommends xubuntu-core locales
sudo localectl set-keymap us

# Install xrdp
sudo -E apt-get install -y --no-install-recommends xrdp

# Configure user session
echo "xfce4-session" > ~/.xsession

# Restart xrdp service
sudo systemctl restart xrdp

