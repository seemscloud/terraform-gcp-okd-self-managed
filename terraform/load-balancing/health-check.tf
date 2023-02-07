resource "google_compute_region_health_check" "load_balancing" {
  name   = var.healthcheck_name
  region = var.region


  timeout_sec         = 2
  check_interval_sec  = 2
  healthy_threshold   = 1
  unhealthy_threshold = 2

  tcp_health_check {
    port = var.healthcheck_port
  }
}