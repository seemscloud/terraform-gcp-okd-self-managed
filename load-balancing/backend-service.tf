resource "google_compute_region_backend_service" "bastion" {
  name   = var.name
  region = var.region

  protocol                        = "TCP"
  load_balancing_scheme           = "INTERNAL"
  session_affinity                = "CLIENT_IP"
  connection_draining_timeout_sec = 5

  backend {
    group           = var.instance_group_id
    balancing_mode  = "CONNECTION"
    capacity_scaler = 0
  }

  health_checks = [
    google_compute_region_health_check.load_balancing.id
  ]

  depends_on = [
    google_compute_region_health_check.load_balancing
  ]
}