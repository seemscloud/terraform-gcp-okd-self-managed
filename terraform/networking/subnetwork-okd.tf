resource "google_compute_subnetwork" "okd" {
  region        = var.region
  name          = var.okd_subnetwork_name
  ip_cidr_range = var.okd_subnetwork_cidr
  network       = google_compute_network.network.id
}

resource "google_compute_address" "okd" {
  name = "${var.okd_subnetwork_name}-external"

  address_type = "EXTERNAL"
}

resource "google_compute_router" "okd" {
  name    = var.okd_subnetwork_name
  region  = var.region
  network = google_compute_network.network.id
}

resource "google_compute_router_nat" "okd" {
  name = var.okd_subnetwork_name

  router = google_compute_router.okd.name
  region = var.region

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.okd.*.self_link

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.okd.name
    source_ip_ranges_to_nat = [
      "ALL_IP_RANGES"
    ]
  }

  depends_on = [
    google_compute_router.okd,
    google_compute_address.okd,
    google_compute_subnetwork.okd

  ]
}