output "tf_router_ip" {
  value = openstack_networking_router_v2.tf_router.external_fixed_ip.0.ip_address
}

output "tf_bastion_fip" {
  value = openstack_networking_floatingip_v2.tf_bastion_fip.address
}

output "tf_app_ip" {
  value = openstack_compute_instance_v2.tf_app.network.0.fixed_ip_v4
}

output "tf_db_ip" {
  value = openstack_compute_instance_v2.tf_db.network.0.fixed_ip_v4
}

output "tf_fe_ip" {
  value = openstack_compute_instance_v2.tf_fe.network.0.fixed_ip_v4
}

output "tf_fe_fip" {
  value = openstack_networking_floatingip_v2.tf_fe_fip.address
}

output "site_url" {
  value = "https://${replace(openstack_networking_floatingip_v2.tf_fe_fip.address, ".", "-")}.int.cloud.um.edu.ar/"
}

output "db_backup_cmd" {
  value = "./db-backup.sh ${openstack_networking_floatingip_v2.tf_bastion_fip.address} ${openstack_compute_instance_v2.tf_db.network.0.fixed_ip_v4} > /tmp/db.dump"
}

output "db_restore_cmd" {
  value = "./db-restore.sh ${openstack_networking_floatingip_v2.tf_bastion_fip.address} ${openstack_compute_instance_v2.tf_db.network.0.fixed_ip_v4} < /tmp/db.dump"
}
