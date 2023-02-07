output "external_address" {
  value = google_compute_address.instance.address
}

output "internal_address" {
  value = flatten(google_compute_instance.instance.network_interface.*.network_ip)
}

output "dns_a_records" {
  value = google_dns_record_set.instance.name
}

output "subnetwork_id" {
  value = google_compute_subnetwork.instance.id
}

output "instance_group_id" {
  value = google_compute_instance_group.instance.id
}