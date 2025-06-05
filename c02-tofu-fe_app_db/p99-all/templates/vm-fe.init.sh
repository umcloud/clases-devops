#!/bin/bash

sudo rm -f /etc/nginx/sites-enabled/default

sudo tee /etc/nginx/conf.d/lb.conf << EOF
server {
  listen 80;
  location / {
    proxy_pass http://${app_ip}:5678; # my backend WP
    proxy_http_version 1.1;
    proxy_set_header Connection 'Upgrade';
    proxy_set_header Upgrade \$http_upgrade;
  }
}
EOF
sudo service nginx restart
