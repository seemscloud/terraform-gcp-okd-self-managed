resource "google_compute_instance_group" "instance" {
  name = var.name

  zone = var.zones

  instances = [
    google_compute_instance.instance.self_link
  ]

  depends_on = [
    google_compute_address.instance
  ]
}