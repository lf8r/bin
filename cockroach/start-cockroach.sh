#!/bin/bash
cockroach start --store=localhost --insecure --advertise-addr=`hostname`:26257 --join=vm1:26257,vm2:26257 --http-addr=:8080 &
