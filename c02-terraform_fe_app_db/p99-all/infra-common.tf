data "openstack_networking_network_v2" "ext_net" {
  name = "ext_net"
}

data "openstack_compute_flavor_v2" "small" {
  vcpus = 1
  ram   = 2048
}

data "openstack_images_image_v2" "ubuntu_2204" {
  name        = "ubuntu_2204"
  most_recent = true
}

data "openstack_images_image_v2" "srv_mysql_ubuntu1804" {
  name        = "srv-mysql-ubuntu1804"
  most_recent = true
}

data "openstack_images_image_v2" "srv_nginx_ubuntu1804" {
  name        = "srv-nginx-ubuntu1804"
  most_recent = true
}

data "openstack_images_image_v2" "srv_wordpress_ubuntu1804" {
  name        = "srv-wordpress-ubuntu1804"
  most_recent = true
}
