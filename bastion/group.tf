resource "google_compute_instance_group" "bastion" {
  name = var.name

  zone = var.zones

  instances = [
    google_compute_instance.bastion.id
  ]

  depends_on = [
    google_compute_address.bastion
  ]
}