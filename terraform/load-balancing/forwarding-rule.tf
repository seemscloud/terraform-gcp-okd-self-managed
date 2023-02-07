resource "google_compute_forwarding_rule" "bastion" {
  name   = var.name
  region = var.region

  all_ports              = true
  allow_global_access    = false
  is_mirroring_collector = false

  subnetwork            = var.subnetwork_id
  ip_protocol           = "TCP"
  network_tier          = "PREMIUM"
  load_balancing_scheme = "INTERNAL"

  backend_service = google_compute_region_backend_service.bastion.id

  ports = []
}