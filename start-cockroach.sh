#!/bin/bash
cockroach start --insecure --listen-addr=localhost:26257  --join=vm1:26257,vm2:26257 --http-addr=localhost:8080
