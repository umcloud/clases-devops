help:
	@echo "GCLOUD"
	@echo "make install"
	@echo "make init"
	@echo ""
	@echo "CLUSTER"
	@echo "make list"
	@echo "make connect [CLUSTER=name]"
	@echo "make create  [CLUSTER=name] [NODES=number] [MACHINE_TYPE=machine_type]"
	@echo "make delete  [CLUSTER=name]"
	@echo ""
	@echo "SQL"
	@echo "make list-sql"
	@echo ""
	@echo "VOLUMES"
	@echo "make list-vol"
	@echo ""
	@echo "KUBERNETES"
	@echo "make list-svc"
	@echo "make list-deployments"
	@echo "make list-events"

init:
	gcloud init --console-only

install:
	echo "deb http://packages.cloud.google.com/apt cloud-sdk-$$(lsb_release -c -s) main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	sudo apt-get update 
	sudo apt-get install google-cloud-sdk
list: 
	gcloud container clusters list

create:
	@test -n "$(CLUSTER)" || { echo 'ERROR: Falta nombre de cluster'; exit 1;}
	gcloud container clusters create $(CLUSTER) --num-nodes $(NODES) --machine-type $(MACHINE_TYPE)
	gcloud container clusters get-credentials $(CLUSTER)

delete:
	@test -n "$(CLUSTER)" || { echo 'ERROR: Falta nombre de cluster'; exit 1;}
	gcloud container clusters delete $(CLUSTER)

connect:
	@test -n "$(CLUSTER)" || { echo 'ERROR: Falta nombre de cluster'; exit 1;}
	gcloud container clusters get-credentials $(CLUSTER) 

list-sql:
	gcloud  sql  instances list

list-vol:
	gcloud compute disks list

list-svc: connect
	kubectl get svc

list-deployments: connect
	kubectl get deployments

list-events: connect
	kubectl get events

ifndef CLUSTER
CLUSTER=${USER}
endif

ifndef NODES
NODES=3
endif
ifndef MACHINE_TYPE
#MACHINE_TYPE=f1-micro
MACHINE_TYPE=n1-standard-1
endif
