output "my_router_ip" {
  value = openstack_networking_router_v2.my_router.external_fixed_ip[0].ip_address
}

output "my_bastion_fip" {
  value = openstack_networking_floatingip_v2.my_bastion_fip.address
}

output "my_fe_ip" {
  value = openstack_networking_floatingip_v2.my_fe_fip.address
}
