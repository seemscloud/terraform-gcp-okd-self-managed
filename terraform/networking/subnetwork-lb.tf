resource "google_compute_subnetwork" "lb" {
  region        = var.region
  name          = var.lb_subnetwork_name
  ip_cidr_range = var.lb_subnetwork_cidr
  network       = google_compute_network.network.id

  depends_on = [
    google_compute_network.network
  ]
}