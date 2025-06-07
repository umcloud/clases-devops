#!/bin/bash
# Helper script to connect via bastion to the database server and restore a database from stdin.
CMD="env LC_ALL=C psql -X -f-"
set -xeu
ssh -CA "ubuntu@${1:?missing bastion_ip}" "ssh -C ${2:?missing db_ip} sudo -upostgres sh -xc \'${CMD}\'"
