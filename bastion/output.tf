output "external_address" {
  value = google_compute_address.bastion.address
}

output "internal_address" {
  value = flatten(google_compute_instance.bastion.network_interface.*.network_ip)
}

output "dns_a_records" {
  value = google_dns_record_set.dns_a_records.name
}

output "subnetwork_id" {
  value = google_compute_subnetwork.bastion.id
}

output "instance_group_id" {
  value = google_compute_instance_group.bastion.id
}