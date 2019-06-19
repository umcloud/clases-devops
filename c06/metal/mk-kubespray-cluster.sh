#!/bin/bash

#Software Needed [Ubuntu]
sudo apt-get install -y git python3-venv
git clone https://github.com/kubernetes-incubator/kubespray.git
cd kubespray

#Kubespray customization
mkdir -p kubespray/inventory/cluster
cp -r kubespray/inventory/sample/* kubespray/inventory/cluster
pyvenv .venv && source .venv/bin/activate
pip3 install --upgrade pip && pip3 install -r kubespray/requirements.txt && pip3 install ruamel.yaml
sed -i "$ a\bootstrap_os: ubuntu" kubespray/inventory/cluster/group_vars/all/all.yml
sed -i "$ a\kubeadm_enabled: true" kubespray/inventory/cluster/group_vars/all/all.yml
sed -i "s/helm_enabled: false/helm_enabled: true/g" kubespray/inventory/cluster/group_vars/k8s-cluster/addons.yml
sed -i "s/ingress_nginx_enabled: false/ingress_nginx_enabled: true/g" kubespray/inventory/cluster/group_vars/k8s-cluster/addons.yml
#Fix for https://github.com/kubernetes-sigs/kubespray/issues/4357
sed -i "$ a\ingress_nginx_host_network: true" kubespray/inventory/cluster/group_vars/k8s-cluster/addons.yml

cd kubespray

#Declare IP for VMs
declare -a IPS=(172.16.254.28 172.16.254.235 172.16.254.202 172.16.254.135)
CONFIG_FILE=inventory/cluster/hosts.yml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
ansible-playbook -b -u linux -i inventory/cluster/hosts.yml cluster.yml
