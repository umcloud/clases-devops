resource "openstack_compute_instance_v2" "my_bastion" {
  name              = "my-bastion"
  image_id          = data.openstack_images_image_v2.ubuntu_2204.id
  flavor_id         = data.openstack_compute_flavor_v2.small.id
  key_pair          = var.key_name // EDIT: variables.tf
  security_groups   = [openstack_compute_secgroup_v2.sg_bastion.name]
  availability_zone = "nodos-amd-2022"

  network {
    name = openstack_networking_network_v2.my_net.name
  }

  depends_on = [
    openstack_networking_subnet_v2.my_subnet,
  ]
}

resource "openstack_compute_floatingip_associate_v2" "my_bastion_fip" {
  floating_ip = openstack_networking_floatingip_v2.my_bastion_fip.address
  instance_id = openstack_compute_instance_v2.my_bastion.id
}
