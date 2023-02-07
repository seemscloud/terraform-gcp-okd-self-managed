resource "google_compute_network" "network" {
  name                    = var.network_name
  auto_create_subnetworks = false
}