locals {
  tf_bastion_fip = openstack_networking_floatingip_v2.tf_bastion_fip.address
  tf_fe_fip      = openstack_networking_floatingip_v2.tf_fe_fip.address
  tf_site_url    = "https://${replace(openstack_networking_floatingip_v2.tf_fe_fip.address, ".", "-")}.int.cloud.um.edu.ar/"
  tf_fe_ip       = openstack_compute_instance_v2.tf_fe.network.0.fixed_ip_v4
  tf_app_ip      = openstack_compute_instance_v2.tf_app.network.0.fixed_ip_v4
  tf_db_ip       = openstack_compute_instance_v2.tf_db.network.0.fixed_ip_v4
}

output "tf_fIPs" {
  value = {
    bastion_fip = local.tf_bastion_fip
    fe_fip      = local.tf_fe_fip
  }
}

output "tf_IPs" {
  value = {
    app_ip = local.tf_app_ip
    db_ip  = local.tf_db_ip
    fe_ip  = local.tf_fe_ip
  }
}

output "db_data" {
  value = {
    backup_cmd  = "./db-backup.sh ${local.tf_bastion_fip} ${local.tf_db_ip} ${local.tf_app_ip} /tmp/db.dump"
    restore_cmd = "./db-restore.sh ${local.tf_bastion_fip} ${local.tf_db_ip} ${local.tf_app_ip} /tmp/db.dump"
  }
}

output "urls" {
  value = {
    site_url = local.tf_site_url
  }
}
