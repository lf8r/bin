#!/bin/bash
set -e

# Install base development tools (idempotent via apt)
sudo apt-get update
sudo apt-get install -y curl ssh net-tools build-essential libgeos-dev virt-manager ack htop time git-lfs dbus-x11 compizconfig-settings-manager libsecret-tools npm

# Install Git LFS (idempotent - checks if already installed)
if ! command -v git-lfs &> /dev/null; then
    git lfs install
fi

if [ ! -f /etc/apt/sources.list.d/pgdg.list ]; then
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --yes --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
    sudo apt-get install -y postgresql-client-16
fi

# Install Python 3.11 (idempotent)
if ! command -v python3.11 &> /dev/null; then
    sudo apt-get install -y python3-pip
    sudo apt-get install -y python3-venv
    # Add deadsnakes PPA if not already added
    if ! grep -q "deadsnakes/ppa" /etc/apt/sources.list.d/*.list; then
        sudo add-apt-repository -y ppa:deadsnakes/ppa
    fi
    sudo apt-get install -y python3.11
    sudo apt-get install -y python3.11-venv
    sudo apt-get install -y python3.11-tk
    sudo apt-get install -y python3.11-dev
fi

# Ruff formatter (idempotent - snap checks if already installed)
if ! command -v ruff &> /dev/null; then
    sudo snap install ruff --classic
fi

# Required for web browser automation with playwright
if ! dpkg -l | grep -q libavif16; then
    sudo apt-get install -y libavif16
fi

# Install pip for python3.11 only if needed
if ! python3.11 -m pip --version >/dev/null 2>&1; then
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11
fi

# Install Firefox (idempotent - only remove if snap version)
if dpkg -l | grep -q "snapd.*firefox"; then
    sudo snap remove -y firefox
fi
if dpkg -l | grep -q "^ii.*firefox"; then
    sudo apt-get remove -y firefox
fi

# Add PPA if not already added
if ! grep -q "mozillateam/ppa" /etc/apt/sources.list.d/*.list; then
    sudo add-apt-repository -y ppa:mozillateam/ppa
fi

# Add Firefox preference file only if not already present
FILE="/etc/apt/preferences.d/mozillateamppa"
if [ ! -f "$FILE" ]; then
    /bin/cat <<EOM >/tmp/mozillateamppa
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOM
    sudo mv /tmp/mozillateamppa $FILE
fi

# Install Docker CE (idempotent - check if already installed)
if ! command -v docker &> /dev/null || ! docker --version | grep -q "Docker version"; then
    # Add Docker's official GPG key if not already added
    if [ ! -f /etc/apt/keyrings/docker.asc ]; then
        sudo apt-get install -y ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc
    fi

    # Add the repository if not already added
    if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
          $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
          sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    fi

    # Install docker-ce
    sudo apt-get install -y docker-ce

    # Add user to docker group if not already in it (idempotent)
    if ! groups 2>/dev/null | grep -q docker; then
        # Check if docker group exists, create if not
        getent group docker >/dev/null 2>&1 || sudo groupadd docker
        sudo usermod -aG docker "$USER"
    fi
    
    echo "====="
    echo "Please logout and log back in again to inherit changes to user's groups."
    echo "====="
fi

# Install Codex (idempotent - check if npm package is already installed)
# Install npm if not present (required for Codex)
if ! command -v npm &> /dev/null; then
    sudo apt-get install -y npm
fi

if ! npm list -g @openai/codex >/dev/null 2>&1; then
    sudo npm install -g @openai/codex@0.154.0
fi

mkdir -p ~/.codex
if [ ! -f ~/.codex/config.toml ]; then
    touch ~/.codex/config.toml
    cp ~/bin/config.toml ~/.codex/config.toml
fi
cd ~

mkdir -p ~/.agents/skills
rsync -Partv ~/bin/codex/* ~/.agents/skills

cp ~/bin/codex/AGENTS.md ~/.codex/.

# Install Claude (idempotent - check if already installed)
if ! command -v claude &> /dev/null; then
    curl -fsSL https://claude.ai/install.sh | bash
fi

cd ~/bin
mkdir -p ~/.claude/skills
rsync -Partv ~/bin/codex ~/.claude/skills

# Install GitHub CLI (idempotent)
if ! command -v gh &> /dev/null; then
    (type -p wget >/dev/null || sudo apt-get install -y wget) \
    && sudo mkdir -p -m 755 /etc/apt/keyrings \
    && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt-get install -y gh
fi
