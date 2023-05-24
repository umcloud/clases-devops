resource "openstack_compute_secgroup_v2" "sg_bastion" {
  name        = "sg_bastion"
  description = "sg_bastion"

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

resource "openstack_compute_secgroup_v2" "sg_fe" {
  name        = "sg_fe"
  description = "sg_fe"

  rule {
    from_group_id = openstack_compute_secgroup_v2.sg_bastion.id
    from_port     = -1
    to_port       = -1
    ip_protocol   = "icmp"
  }
  rule {
    from_group_id = openstack_compute_secgroup_v2.sg_bastion.id
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

resource "openstack_compute_secgroup_v2" "sg_app" {
  name        = "sg_app"
  description = "sg_app"

  rule {
    from_group_id = openstack_compute_secgroup_v2.sg_bastion.id
    from_port     = -1
    to_port       = -1
    ip_protocol   = "icmp"
  }
  rule {
    from_group_id = openstack_compute_secgroup_v2.sg_bastion.id
    from_port     = 22
    to_port       = 22
    ip_protocol   = "tcp"
  }
  rule {
    from_group_id = openstack_compute_secgroup_v2.sg_fe.id
    from_port     = 80
    to_port       = 80
    ip_protocol   = "tcp"
  }
}

resource "openstack_compute_secgroup_v2" "sg_db" {
  name        = "sg_db"
  description = "sg_db"

  rule {
    from_group_id = openstack_compute_secgroup_v2.sg_bastion.id
    from_port     = -1
    to_port       = -1
    ip_protocol   = "icmp"
  }
  rule {
    from_group_id = openstack_compute_secgroup_v2.sg_bastion.id
    from_port     = 22
    to_port       = 22
    ip_protocol   = "tcp"
  }
  rule {
    from_group_id = openstack_compute_secgroup_v2.sg_app.id
    from_port     = 3306
    to_port       = 3306
    ip_protocol   = "tcp"
  }
}

