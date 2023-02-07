output "aaa_network_aaa" {
  value = google_compute_network.network
}

output "aaa_dns_zone_aaa" {
  value = google_dns_managed_zone.dns_zone
}

output "lb_subnetwork" {
  value = google_compute_subnetwork.lb
}

output "okd_subnetwork" {
  value = google_compute_subnetwork.okd
}