terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
  backend "local" {
    path = "../tf-state/terraform.tfstate"
  }
  required_version = ">= 1.5"
}
