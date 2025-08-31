#!/bin/bash
set -e

sudo apt install -y curl ssh net-tools build-essential libgeos-dev virt-manager ack htop time git-lfs
git lfs install
#install-postgres-client16.sh
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --yes --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
sudo apt update
sudo apt install -y postgresql-client-16

#install-python3.sh
sudo apt-get install -y python3-pip
sudo apt -y install python3-venv
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt install -y python3.11
sudo apt install -y python3.11-venv
sudo apt-get install -y python3.11-tk
# Required for web browser automation with playwright (see https://playwright.dev/python/docs/intro).
sudo apt-get install -y libavif16
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11


#install-firefox.sh
sudo snap remove firefox
sudo apt remove -y firefox
sudo add-apt-repository -y ppa:mozillateam/ppa

FILE="/etc/apt/preferences.d/mozillateamppa"
set -e
/bin/cat <<EOM >/tmp/mozillateamppa
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOM

sudo mv /tmp/mozillateamppa $FILE

sudo apt update
sudo apt install -y firefox

#install-docker-ce.sh
#!/bin/bash
set -e
# Add Docker's official GPG key:
sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

# Cleanly reinstall docker-ce.
set +e
sudo apt purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
set -e
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
set +e
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
set -e
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt install -y docker-ce
set +e
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
set -e
echo "====="
echo "Please logout and log back in again to inherit changes to user's groups.
echo "====="
