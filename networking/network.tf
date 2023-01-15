resource "google_compute_network" "aaa_network_aaa" {
  name                    = var.aaa_network_aaa-name
  auto_create_subnetworks = false
}