data "openstack_images_image_v2" "docker" {
  name        = "srv-docker-ubuntu2404"
  most_recent = true
}

data "openstack_compute_flavor_v2" "small" {
  vcpus = 1
  ram   = 2048
}

resource "openstack_compute_instance_v2" "docker_vm" {
  name              = "docker_vm"
  image_id          = data.openstack_images_image_v2.docker.id
  flavor_id         = data.openstack_compute_flavor_v2.small.id
  key_pair          = var.key_name
  security_groups   = ["default"]
  availability_zone = "nodos-amd-2022"

  user_data = file("init.sh")
  network {
    name = "net_umstack"
  }
}
