#!/bin/bash

#Software Needed [Ubuntu]
sudo apt-get install -y git python3-venv
git clone https://github.com/kubernetes-incubator/kubespray.git

#Kubespray customization
mkdir -p kubespray/inventory/cluster
cp -r kubespray/inventory/sample/* kubespray/inventory/cluster
pyvenv .venv && source .venv/bin/activate
pip3 install --upgrade pip && pip3 install -r kubespray/requirements.txt && pip3 install ruamel.yaml

cat > kubespray/inventory/cluster/local.yml << EOF
bootstrap_os: ubuntu
kubeadm_enabled: true
helm_enabled: true
ingress_nginx_enabled: true
#Fix for https://github.com/kubernetes-sigs/kubespray/issues/4357
ingress_nginx_host_network: true
#Fix for https://github.com/kubernetes/kubernetes/pull/76640
enable_nodelocaldns: false
upstream_dns_servers:
  - 8.8.8.8
  - 8.8.4.4
EOF

cd kubespray

#Declare IP for VMs
declare -a IPS=(172.16.254.28 172.16.254.235 172.16.254.202 172.16.254.135)
CONFIG_FILE=inventory/cluster/hosts.yml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
ansible-playbook -b -u linux -i inventory/cluster/hosts.yml cluster.yml --extra-vars @inventory/cluster/local.yml
