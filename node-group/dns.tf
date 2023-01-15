resource "google_dns_record_set" "bastion" {
  count = var.counter
  name  = "${var.name}-${count.index}.${var.dns_zone.dns_name}"
  type  = "A"
  ttl   = 300

  managed_zone = var.dns_zone.name

  rrdatas = [
    google_compute_instance.node_group[count.index].network_interface[0].network_ip
  ]
}