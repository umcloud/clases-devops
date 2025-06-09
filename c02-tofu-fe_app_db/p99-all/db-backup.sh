#!/bin/bash
# Helper script to connect via bastion to the database server and dump all databases to a file.
BACKUP_CMD="env LC_ALL=C pg_dumpall -c"
APP_STOP_CMD="sudo systemctl stop n8n"
APP_START_CMD="sudo systemctl start n8n"

BASTION_IP=${1:?missing bastion_ip}
DB_IP=${2:?missing db_ip}
APP_IP=${3:?missing app_ip}
BACKUP_FILE=${4:?missing backup_file}

set -xeu
echo "Backing up database to ${BACKUP_FILE}..."
ssh -o StrictHostKeyChecking=no -C -J "ubuntu@${BASTION_IP}" "ubuntu@${APP_IP}" sudo sh -xc "'${APP_STOP_CMD}'"
ssh -o StrictHostKeyChecking=no -C -J "ubuntu@${BASTION_IP}" "ubuntu@${DB_IP}"  sudo -upostgres sh -xc "'${BACKUP_CMD}'" > "${BACKUP_FILE}"
ssh -o StrictHostKeyChecking=no -C -J "ubuntu@${BASTION_IP}" "ubuntu@${APP_IP}" sudo sh -xc "'${APP_START_CMD}'"
echo "Backup completed successfully and saved to ${BACKUP_FILE}"
