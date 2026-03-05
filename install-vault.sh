#!/bin/bash
set -e
sudo wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault

mkdir -p /var/tmp/vault
mkdir -p /var/tmp/vault/data

openssl req -x509 -newkey rsa:4096 -sha256 -days 365 \
    -nodes -keyout /var/tmp/vault/vault-key.pem -out /var/tmp/vault/vault-cert.pem \
    -subj "/CN=localhost" \
    -addext "subjectAltName=DNS:localhost,IP:127.0.0.1"

cat > /var/tmp/vault/vault-server.hcl << EOF
api_addr                = "https://127.0.0.1:8200"
cluster_addr            = "https://127.0.0.1:8201"
cluster_name            = "learn-vault-cluster"
disable_mlock           = true
ui                      = true

listener "tcp" {
address       = "127.0.0.1:8200"
tls_cert_file = "/var/tmp/vault/vault-cert.pem"
tls_key_file  = "/var/tmp/vault/vault-key.pem"
}

backend "raft" {
path    = "/var/tmp/vault/data"
node_id = "my-vault-server"
}
EOF

echo "Run start-vault.sh in a separate terminal to start the Vault server, then run init-vault.sh to initialize it."