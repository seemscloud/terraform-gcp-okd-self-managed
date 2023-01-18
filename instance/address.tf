resource "google_compute_address" "instance" {
  name = "${var.name}-external"

  address_type = "EXTERNAL"
}