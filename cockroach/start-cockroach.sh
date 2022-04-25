#!/bin/bash
cockroach start --store=localhost --insecure --listen-addr=:26257  --join=vm1:26257,vm2:26257 --http-addr=localhost:8080 &
