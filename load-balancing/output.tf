output "load_balancer-ip_address" {
  value = google_compute_forwarding_rule.bastion.ip_address
}