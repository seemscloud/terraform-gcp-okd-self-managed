resource "google_compute_subnetwork" "node_group" {
  name          = var.loadbalancing_name
  ip_cidr_range = var.loadbalancing_cidr
  region        = var.region
  network       = var.network.id
}
