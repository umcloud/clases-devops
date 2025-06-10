data "openstack_images_image_v2" "ubuntu_2404" {
  name        = "ubuntu_2404"
  most_recent = true
}

data "openstack_compute_flavor_v2" "small" {
  vcpus = 1
  ram   = 2048
}

resource "openstack_compute_instance_v2" "terraform_vm" {
  name              = "terraform_vm"
  image_id          = data.openstack_images_image_v2.ubuntu_2404.id
  flavor_id         = data.openstack_compute_flavor_v2.small.id
  key_pair          = "REEMPLAZAR!" // <- reemplazar por el nombre de la keypair desde console.cloud.um.edu.ar
  security_groups   = ["default"]
  availability_zone = "nodos-amd-2022"

  user_data = file("init.sh")
  network {
    name = "net_umstack"
  }
}
