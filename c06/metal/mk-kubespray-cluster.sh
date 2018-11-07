#!/bin/bash

#IPs for every VM
declare -a IPS=(172.16.254.128 172.16.254.129 172.16.254.130 172.16.254.131)

#Needed Software
sudo apt-get install git python-virtualenv
git clone https://github.com/kubernetes-incubator/kubespray.git
mkdir -p kubespray/inventory/umcloud
cd kubespray
virtualenv .venv
source .venv/bin/activate
pip install ansible
pip install -r requirements.txt
cat > inventory/umcloud/local.yml << EOF
bootstrap_os: ubuntu
kubeadm_enabled: true
helm_enabled: true
ingress_nginx_enabled: true
EOF
CONFIG_FILE=inventory/umcloud/hosts.ini python3 contrib/inventory_builder/inventory.py ${IPS[@]}
ansible-playbook -b -i inventory/umcloud/hosts.ini cluster.yml --extra-vars @inventory/umcloud/local.yml
