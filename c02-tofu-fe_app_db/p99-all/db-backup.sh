#!/bin/bash
# Helper script to connect via bastion to the database server and dump all databases to stdout.
CMD="env LC_ALL=C pg_dumpall -c"
set -xeu
ssh -CA ubuntu@${1:?missing bastion_ip} "ssh -C ${2:?missing db_ip} sudo -upostgres sh -xc \'${CMD}\'"
