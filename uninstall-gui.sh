#!/bin/bash

# Uninstall GUI packages installed by install-gui.sh

# Remove xrdp
sudo apt-get purge -y xrdp

# Remove xubuntu-core and related packages (but keep essential dependencies)
sudo apt-get purge -y --purge xubuntu-core

# Clean up configuration
rm -f ~/.xsession

# Autoremove and autoclean
sudo apt-get autoremove -y
sudo apt-get autoclean -y
