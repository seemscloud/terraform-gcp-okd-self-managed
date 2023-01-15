resource "google_dns_managed_zone" "aaa_dns_zone_aaa" {
  name     = var.aaa_dns_zone_aaa-name
  dns_name = var.aaa_dns_zone_aaa-dns_name

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.aaa_network_aaa.id
    }
  }

  depends_on = [
    google_compute_network.aaa_network_aaa
  ]
}