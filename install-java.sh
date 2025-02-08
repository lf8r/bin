#!/bin/bash
set -e
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 17.0.11-jbr
sdk use java 17.0.11-jbr
exec "$BASH"
which java
sdk install groovy