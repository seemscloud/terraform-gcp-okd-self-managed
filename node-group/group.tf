resource "google_compute_instance_group" "node_group" {
  name = var.name

  zone = var.zones

  instances = flatten(google_compute_instance.node_group[*].id)

  depends_on = [
    google_compute_address.node_group
  ]
}