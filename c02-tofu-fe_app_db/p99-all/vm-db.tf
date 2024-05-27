resource "openstack_compute_instance_v2" "tf_db" {
  name              = "tf-db"
  image_id          = data.openstack_images_image_v2.srv_mysql_ubuntu1804.id
  flavor_id         = data.openstack_compute_flavor_v2.small.id
  key_pair          = var.key_name // EDIT: variables.tf
  security_groups   = [openstack_compute_secgroup_v2.tf_sg_db.name]
  availability_zone = "nodos-amd-2022"

  user_data = templatefile("${path.module}/templates/vm-db.init.sh", {
  })

  network {
    name = openstack_networking_network_v2.tf_net.name
  }
  depends_on = [
    openstack_networking_subnet_v2.tf_subnet,
  ]
}
