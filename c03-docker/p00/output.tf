output "ssh_cmd" {
  value = "ssh ubuntu@${openstack_compute_instance_v2.docker_vm.network.0.fixed_ip_v4}"
}
