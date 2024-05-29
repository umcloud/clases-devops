output "ssh_cmd" {
  value = "ssh ubuntu@${openstack_compute_instance_v2.docker_vm.0.network.0.fixed_ip_v4}"
}
