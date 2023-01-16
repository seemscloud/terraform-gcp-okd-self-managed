resource "google_dns_record_set" "dns_a_records" {
  name = "${var.name}.${var.dns_zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.dns_zone.name

  rrdatas = [
    google_compute_instance.bastion.network_interface[0].network_ip
  ]
}