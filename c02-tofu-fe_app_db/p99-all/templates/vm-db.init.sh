#!/bin/bash

# Configure PostgreSQL to listen on all interfaces
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" \
  /etc/postgresql/16/main/postgresql.conf

# Update authentication settings
sudo sed -i '/^host/s/ident/md5/' /etc/postgresql/16/main/pg_hba.conf
sudo sed -i '/^local/s/peer/trust/' /etc/postgresql/16/main/pg_hba.conf

# Add rule to allow all external connections (with password authentication)
echo "host all all 0.0.0.0/0 md5" | sudo tee -a /etc/postgresql/16/main/pg_hba.conf

# Restart PostgreSQL to apply changes
sudo systemctl restart postgresql

# Create database and user for n8n
sudo -u postgres psql << EOF
ALTER USER postgres PASSWORD '${pg_postgres_password}';
CREATE USER n8n WITH ENCRYPTED PASSWORD '${pg_n8n_password}';
CREATE DATABASE n8n;
GRANT ALL ON SCHEMA public TO n8n;
ALTER USER n8n WITH SUPERUSER;
EOF
