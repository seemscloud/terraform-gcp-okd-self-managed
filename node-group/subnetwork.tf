resource "google_compute_subnetwork" "node_group" {
  name          = var.name
  ip_cidr_range = var.cidr
  region        = var.region
  network       = var.network.id
}
