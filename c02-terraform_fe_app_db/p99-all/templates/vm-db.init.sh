#!/bin/bash

sudo sed -i '/bind-address/s/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
sudo mysql << EOF
CREATE DATABASE wordpress;
 GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER
    ON wordpress.*
    TO wordpress@'%'
    IDENTIFIED BY 'telewordpress';
EOF
