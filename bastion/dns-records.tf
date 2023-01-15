resource "google_dns_record_set" "bastion" {
  name = "bastion.${var.dns_zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.dns_zone.name

  rrdatas = [
    google_compute_instance.bastion.network_interface[0].network_ip
  ]
}