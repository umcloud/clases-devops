
resource "openstack_networking_floatingip_v2" "my_bastion_fip" {
  description = "my-bastion-ip"
  pool        = "ext_net"
}

resource "openstack_networking_floatingip_v2" "my_fe_fip" {
  description = "my-fe-ip"
  pool        = "ext_net"
}
