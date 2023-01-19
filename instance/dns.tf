resource "google_dns_record_set" "instance" {
  name = trimprefix("${var.name}.${var.dns_zone.dns_name}", "${var.prefix}-")
  type = "A"
  ttl  = 1

  managed_zone = var.dns_zone.name

  rrdatas = [
    google_compute_instance.instance.network_interface[0].network_ip
  ]
}