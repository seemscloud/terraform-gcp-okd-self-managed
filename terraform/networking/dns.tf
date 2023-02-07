resource "google_dns_managed_zone" "dns_zone" {
  name     = var.dns_zone_name
  dns_name = var.dns_zone_dns_name

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.network.id
    }
  }

  depends_on = [
    google_compute_network.network
  ]
}