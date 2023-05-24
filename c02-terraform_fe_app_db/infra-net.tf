resource "openstack_networking_router_v2" "my_router" {
  name                = "my-router"
  admin_state_up      = "true"
  external_network_id = data.openstack_networking_network_v2.ext_net.id
}

resource "openstack_networking_network_v2" "my_net" {
  name           = "my-net"
  admin_state_up = "true"
  shared         = "false"
}

resource "openstack_networking_subnet_v2" "my_subnet" {
  name            = "my-subnet"
  network_id      = openstack_networking_network_v2.my_net.id
  cidr            = "172.19.0.0/24"
  ip_version      = 4
  enable_dhcp     = "true"
  dns_nameservers = ["8.8.8.8", "1.1.1.1"]
}

resource "openstack_networking_router_interface_v2" "my_router_iface_internal" {
  router_id = openstack_networking_router_v2.my_router.id
  subnet_id = openstack_networking_subnet_v2.my_subnet.id
}

resource "openstack_networking_floatingip_v2" "my_bastion_fip" {
  description = "my-bastion-ip"
  pool        = "ext_net"
}

resource "openstack_networking_floatingip_v2" "my_fe_fip" {
  description = "my-fe-ip"
  pool        = "ext_net"
}
