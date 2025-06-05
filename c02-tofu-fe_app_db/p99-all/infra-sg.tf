resource "openstack_compute_secgroup_v2" "tf_sg_bastion" {
  name        = "tf_sg_bastion"
  description = "tf_sg_bastion"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
  rule {
    ip_protocol = "icmp"
    from_port   = -1
    to_port     = -1
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "tf_sg_fe" {
  name        = "tf_sg_fe"
  description = "tf_sg_fe"

  rule {
    from_group_id = openstack_compute_secgroup_v2.tf_sg_bastion.id
    from_port     = -1
    to_port       = -1
    ip_protocol   = "icmp"
  }
  rule {
    from_group_id = openstack_compute_secgroup_v2.tf_sg_bastion.id
    from_port     = 22
    to_port       = 22
    ip_protocol   = "tcp"
  }
  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "tf_sg_app" {
  name        = "tf_sg_app"
  description = "tf_sg_app"

  rule {
    from_group_id = openstack_compute_secgroup_v2.tf_sg_bastion.id
    from_port     = -1
    to_port       = -1
    ip_protocol   = "icmp"
  }
  rule {
    from_group_id = openstack_compute_secgroup_v2.tf_sg_bastion.id
    from_port     = 22
    to_port       = 22
    ip_protocol   = "tcp"
  }
  rule {
    from_group_id = openstack_compute_secgroup_v2.tf_sg_fe.id
    from_port     = 5678
    to_port       = 5678
    ip_protocol   = "tcp"
  }
}

resource "openstack_compute_secgroup_v2" "tf_sg_db" {
  name        = "tf_sg_db"
  description = "tf_sg_db"

  rule {
    from_group_id = openstack_compute_secgroup_v2.tf_sg_bastion.id
    from_port     = -1
    to_port       = -1
    ip_protocol   = "icmp"
  }
  rule {
    from_group_id = openstack_compute_secgroup_v2.tf_sg_bastion.id
    from_port     = 22
    to_port       = 22
    ip_protocol   = "tcp"
  }
  rule {
    from_group_id = openstack_compute_secgroup_v2.tf_sg_app.id
    from_port     = 5432
    to_port       = 5432
    ip_protocol   = "tcp"
  }
}

