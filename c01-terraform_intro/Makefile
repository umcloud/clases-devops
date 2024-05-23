help:
	@echo make init
	@echo make plan
	@echo make apply
	@echo make destroy

init plan apply destroy fmt: check-env
	tofu $@

check-env:
	@which tofu > /dev/null && exit 0; echo "ERROR: Please install tofu binary"; exit 1
	@echo $${OS_AUTH_URL:?"ERROR: Need to load openstack environment with: source USERNAME_project-openrc.sh"} > /dev/null

