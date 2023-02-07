resource "google_compute_subnetwork" "instance" {
  name          = var.name
  ip_cidr_range = var.cidr
  region        = var.region
  network       = var.network.id
}
