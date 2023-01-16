resource "google_compute_health_check" "tcp_8080" {
  name = var.aaa_healthcheck_aaa-name

  timeout_sec         = 2
  check_interval_sec  = 2
  healthy_threshold   = 1
  unhealthy_threshold = 2

  tcp_health_check {
    port = var.aaa_healthcheck_aaa-port
  }
}