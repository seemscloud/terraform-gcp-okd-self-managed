resource "google_compute_address" "node_group" {
  name = "${var.name}-external"

  address_type = "EXTERNAL"
}

resource "google_compute_router" "node_group" {
  name    = var.name
  region  = var.region
  network = var.network.id
}

resource "google_compute_router_nat" "node_group" {
  name = var.name

  router = google_compute_router.node_group.name
  region = var.region

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.node_group.*.self_link

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.node_group.name
    source_ip_ranges_to_nat = [
      "ALL_IP_RANGES"
    ]
  }

  depends_on = [
    google_compute_subnetwork.node_group,
    google_compute_router.node_group,
    google_compute_address.node_group
  ]
}