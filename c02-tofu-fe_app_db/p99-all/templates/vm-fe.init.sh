#!/bin/bash

sudo rm -f /etc/nginx/sites-enabled/default

sudo tee /etc/nginx/conf.d/lb.conf << EOF
server {
  listen 80;
  location / {
    proxy_pass http://${app_ip}; # my backend WP
  }
}
EOF
sudo service nginx restart
