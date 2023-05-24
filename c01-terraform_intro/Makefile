help:
	@echo make init
	@echo make plan
	@echo make apply
	@echo make destroy

init plan apply destroy: check-env
	terraform $@

check-env:
	@which terraform > /dev/null && exit 0; echo "ERROR: Please install terraform binary"; exit 1
	@echo $${OS_AUTH_URL:?"ERROR: Need to load openstack environment with: source USERNAME_project-openrc.sh"} > /dev/null

