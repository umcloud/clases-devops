#!/bin/bash
set -e

echo "Setting up n8n systemd service..."

# Create n8n user and group if they don't exist
if ! id "n8n" &>/dev/null; then
    echo "Creating n8n user..."
    useradd --system --shell /bin/false --home /opt/n8n --create-home n8n
else
    echo "n8n user already exists"
fi

# Create necessary directories
echo "Creating directories..."
mkdir -p /opt/n8n
mkdir -p /etc/n8n
mkdir -p /var/log/n8n

# Set ownership
echo "Setting permissions..."
chown -R n8n:n8n /opt/n8n
chown -R n8n:n8n /var/log/n8n
chown root:root /etc/n8n
chmod 755 /etc/n8n

# Copy environment file
echo "Setting up environment file..."
cat > /etc/n8n/n8n.env << EOF
# n8n Settings
N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
N8N_SECURE_COOKIE=false
N8N_HOST="$(ip r g 1.1.1.1 | grep -oP 'src \K[\d.]+')"
# Transform 192.168.x.y -> https://192-168-x-y.int.cloud.um.edu.ar/
WEBHOOK_URL="https://$(echo ${fe_fip} | sed 's/\./-/g').int.cloud.um.edu.ar/"

# Database Configuration
DB_TYPE=postgresdb
DB_POSTGRESDB_USER=n8n
DB_POSTGRESDB_DATABASE=n8n
DB_POSTGRESDB_HOST=${db_ip}
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_PASSWORD=nochon
EOF
chown root:n8n /etc/n8n/n8n.env
chmod 640 /etc/n8n/n8n.env

# Copy service file
echo "Installing systemd service..."
cat >  /etc/systemd/system/n8n.service << EOF
[Unit]
Description=n8n Workflow Automation Tool
Documentation=https://docs.n8n.io
After=network.target postgresql.service
Wants=postgresql.service

[Service]
Type=simple
User=n8n
Group=n8n
WorkingDirectory=/opt/n8n
EnvironmentFile=/etc/n8n/n8n.env
ExecStart=/usr/local/bin/n8n start
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal
SyslogIdentifier=n8n

# Security settings
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=true
ReadWritePaths=/opt/n8n

# Resource limits
LimitNOFILE=65536
MemoryLimit=2G

[Install]
WantedBy=multi-user.target
EOF
chown root:root /etc/systemd/system/n8n.service
chmod 644 /etc/systemd/system/n8n.service

# Reload systemd
echo "Reloading systemd..."
systemctl daemon-reload
echo "Enabling n8n service"
systemctl enable n8n
systemctl start n8n
