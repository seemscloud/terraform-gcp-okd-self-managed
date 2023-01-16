output "internal_addresses" {
  value = flatten(google_compute_instance.node_group[*].network_interface.*.network_ip)
}

output "internal_a_records" {
  value = google_dns_record_set.node_group-a_records[*].name
}