resource "openstack_compute_instance_v2" "my_db" {
  name              = "my-db"
  image_id          = data.openstack_images_image_v2.srv_mysql_ubuntu1804.id
  flavor_id         = data.openstack_compute_flavor_v2.small.id
  key_pair          = var.key_name // EDIT: variables.tf
  security_groups   = ["sg_db"]
  availability_zone = "nodos-amd-2022"

  network {
    name = openstack_networking_network_v2.my_net.name
  }
  depends_on = [
    openstack_networking_subnet_v2.my_subnet,
    openstack_compute_secgroup_v2.sg_db,
  ]
}
