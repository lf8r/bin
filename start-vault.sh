#!/bin/bash
set -e
export VAULT_ADDR=https://127.0.0.1:8200
export VAULT_SKIP_VERIFY=true
vault server -config=/var/tmp/vault/vault-server.hcl