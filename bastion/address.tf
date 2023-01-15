resource "google_compute_address" "bastion" {
  name = "${var.name}-external"

  address_type = "EXTERNAL"
}