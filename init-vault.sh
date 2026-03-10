#!/bin/bash
set -e
export VAULT_ADDR=https://127.0.0.1:8200
export VAULT_SKIP_VERIFY=true
vault operator init -key-shares=1 -key-threshold=1

echo "Vault initialized. Please save the unseal key and root token displayed above. You can use the unseal key to unseal the Vault server and the root token to log in and manage Vault."
echo "Save these values in your setenv file for future use:"
echo "export VAULT_UNSEAL_KEY=\"<your-unseal-key>\""
echo "export VAULT_ROOT_TOKEN=\"<your-root-token>\""
echo "\n\n"
echo "Run vault operator unseal <your-unseal-key> to unseal the Vault server, and vault login <your-root-token> to log in with the root token."