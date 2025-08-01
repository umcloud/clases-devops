resource "openstack_compute_instance_v2" "tf_db" {
  name              = "tf-db"
  image_id          = data.openstack_images_image_v2.srv_postgresql_ubuntu2404.id
  flavor_id         = data.openstack_compute_flavor_v2.small.id
  key_pair          = var.key_name // EDIT: variables.tf
  security_groups   = [openstack_networking_secgroup_v2.tf_sg_db.name]
  availability_zone = "nodos-amd-2022"

  user_data = templatefile("${path.module}/templates/vm-db.init.sh", {
    pg_postgres_password = var.pg_postgres_password
    pg_n8n_password      = var.pg_n8n_password
  })

  network {
    name = openstack_networking_network_v2.tf_net.name
  }
  depends_on = [
    openstack_networking_subnet_v2.tf_subnet,
  ]
}
