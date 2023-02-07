resource "google_compute_address" "instance-internal" {
  name   = var.name
  region = var.region

  address_type = "INTERNAL"
  subnetwork   = google_compute_subnetwork.instance.id
}

resource "google_compute_address" "instance" {
  name = "${var.name}-external"

  address_type = "EXTERNAL"
}