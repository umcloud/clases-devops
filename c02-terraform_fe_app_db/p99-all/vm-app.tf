data "template_file" "my_app_init" {
  template = file("${path.module}/templates/vm-app.init.sh")
  vars = {
    db_ip  = openstack_compute_instance_v2.my_db.network.0.fixed_ip_v4
    fe_fip = openstack_networking_floatingip_v2.my_fe_fip.address
  }
}

resource "openstack_compute_instance_v2" "my_app" {
  name              = "my-app"
  image_id          = data.openstack_images_image_v2.srv_wordpress_ubuntu1804.id
  flavor_id         = data.openstack_compute_flavor_v2.small.id
  key_pair          = var.key_name // EDIT: variables.tf
  security_groups   = [openstack_compute_secgroup_v2.tf_sg_app.name]
  availability_zone = "nodos-amd-2022"

  user_data = data.template_file.my_app_init.rendered

  network {
    name = openstack_networking_network_v2.my_net.name
  }

  depends_on = [
    openstack_networking_subnet_v2.my_subnet,
  ]
}
