output "internal_addresses" {
  value = flatten(google_compute_instance.node_group[*].network_interface.*.network_ip)
}