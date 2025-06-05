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

data "openstack_images_image_v2" "srv_postgresql_ubuntu2404" {
  name        = "srv-postgresql-ubuntu2404"
  most_recent = true
}

data "openstack_images_image_v2" "srv_nginx_ubuntu1804" {
  name        = "srv-nginx-ubuntu1804"
  most_recent = true
}

# Replaced WordPress with n8n
data "openstack_images_image_v2" "srv_n8n_ubuntu2404" {
  name        = "srv-n8n-ubuntu2404"
  most_recent = true
}
