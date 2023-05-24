help:
	@echo make init
	@echo make plan
	@echo make apply
	@echo make destroy

init plan apply destroy fmt: check-env
	terraform $@

check-env:
	@grep REEMPLAZAR variables.tf >/dev/null || exit 0; echo "ERROR: editar variables.tf para REEMPLAZAR por el nombre de tu keypair"; exit 1
	@which terraform > /dev/null && exit 0; echo "ERROR: Please install terraform binary"; exit 1
	@echo $${OS_AUTH_URL:?"ERROR: Need to load openstack environment with: source USERNAME_project-openrc.sh"} > /dev/null

