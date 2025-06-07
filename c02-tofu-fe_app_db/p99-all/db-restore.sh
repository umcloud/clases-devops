#!/bin/bash
# Helper script to connect via bastion to the database server and restore a database from a file.
RESTORE_CMD="env LC_ALL=C psql -X -f-"
APP_STOP_CMD="sudo systemctl stop n8n"
APP_START_CMD="sudo systemctl start n8n"

BASTION_IP=${1:?missing bastion_ip}
DB_IP=${2:?missing db_ip}
APP_IP=${3:?missing app_ip}
BACKUP_FILE=${4:?missing }

set -xeu
echo "Restoring database from ${BACKUP_FILE}..."
ssh -o StrictHostKeyChecking=no -CA "ubuntu@${BASTION_IP}" "ssh -o StrictHostKeyChecking=no -C ${APP_IP} sudo sh -xc \'${APP_STOP_CMD}\'"
ssh -o StrictHostKeyChecking=no -CA "ubuntu@${BASTION_IP}" "ssh -o StrictHostKeyChecking=no -C ${DB_IP} sudo -upostgres sh -xc \'${RESTORE_CMD}\'" < "${BACKUP_FILE}"
ssh -o StrictHostKeyChecking=no -CA "ubuntu@${BASTION_IP}" "ssh -o StrictHostKeyChecking=no -C ${APP_IP} sudo sh -xc \'${APP_START_CMD}\'"
echo "Restore completed successfully from ${BACKUP_FILE}"
