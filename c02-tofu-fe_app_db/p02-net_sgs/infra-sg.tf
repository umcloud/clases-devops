resource "openstack_networking_secgroup_v2" "tf_sg_bastion" {
  name        = "tf_sg_bastion"
  description = "tf_sg_bastion"
}

resource "openstack_networking_secgroup_rule_v2" "tf_sg_bastion_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.tf_sg_bastion.id
}

resource "openstack_networking_secgroup_rule_v2" "tf_sg_bastion_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.tf_sg_bastion.id
}

resource "openstack_networking_secgroup_v2" "tf_sg_fe" {
  name        = "tf_sg_fe"
  description = "tf_sg_fe"
}

resource "openstack_networking_secgroup_rule_v2" "tf_sg_fe_icmp_from_bastion" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_group_id   = openstack_networking_secgroup_v2.tf_sg_bastion.id
  security_group_id = openstack_networking_secgroup_v2.tf_sg_fe.id
}

resource "openstack_networking_secgroup_rule_v2" "tf_sg_fe_ssh_from_bastion" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_group_id   = openstack_networking_secgroup_v2.tf_sg_bastion.id
  security_group_id = openstack_networking_secgroup_v2.tf_sg_fe.id
}

resource "openstack_networking_secgroup_rule_v2" "tf_sg_fe_http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.tf_sg_fe.id
}

resource "openstack_networking_secgroup_v2" "tf_sg_app" {
  name        = "tf_sg_app"
  description = "tf_sg_app"
}

resource "openstack_networking_secgroup_rule_v2" "tf_sg_app_icmp_from_bastion" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_group_id   = openstack_networking_secgroup_v2.tf_sg_bastion.id
  security_group_id = openstack_networking_secgroup_v2.tf_sg_app.id
}

resource "openstack_networking_secgroup_rule_v2" "tf_sg_app_ssh_from_bastion" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_group_id   = openstack_networking_secgroup_v2.tf_sg_bastion.id
  security_group_id = openstack_networking_secgroup_v2.tf_sg_app.id
}

resource "openstack_networking_secgroup_rule_v2" "tf_sg_app_api_from_fe" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 5678
  port_range_max    = 5678
  remote_group_id   = openstack_networking_secgroup_v2.tf_sg_fe.id
  security_group_id = openstack_networking_secgroup_v2.tf_sg_app.id
}

resource "openstack_networking_secgroup_v2" "tf_sg_db" {
  name        = "tf_sg_db"
  description = "tf_sg_db"
}

resource "openstack_networking_secgroup_rule_v2" "tf_sg_db_icmp_from_bastion" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_group_id   = openstack_networking_secgroup_v2.tf_sg_bastion.id
  security_group_id = openstack_networking_secgroup_v2.tf_sg_db.id
}

resource "openstack_networking_secgroup_rule_v2" "tf_sg_db_ssh_from_bastion" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_group_id   = openstack_networking_secgroup_v2.tf_sg_bastion.id
  security_group_id = openstack_networking_secgroup_v2.tf_sg_db.id
}

resource "openstack_networking_secgroup_rule_v2" "tf_sg_db_postgres_from_app" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 5432
  port_range_max    = 5432
  remote_group_id   = openstack_networking_secgroup_v2.tf_sg_app.id
  security_group_id = openstack_networking_secgroup_v2.tf_sg_db.id
}

