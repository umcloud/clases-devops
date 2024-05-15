
resource "openstack_networking_floatingip_v2" "tf_bastion_fip" {
  description = "tf-bastion-ip"
  pool        = "ext_net"
}

resource "openstack_networking_floatingip_v2" "tf_fe_fip" {
  description = "tf-fe-ip"
  pool        = "ext_net"
}
