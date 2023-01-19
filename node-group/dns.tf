resource "google_dns_record_set" "node_group-dns_a_records" {
  count = var.counter
  name  = trimprefix("${var.name}-${count.index}.${var.dns_zone.dns_name}", "${var.prefix}-")
  type  = "A"
  ttl   = 1

  managed_zone = var.dns_zone.name

  rrdatas = [
    google_compute_instance.node_group[count.index].network_interface[0].network_ip
  ]
}

#resource "google_dns_record_set" "node_group-dns_ptr_records" {
#  count = var.counter
#  # name  = "${var.name}-${count.index}.${var.dns_zone.dns_name}"
#  name = "${google_compute_instance.node_group[count.index].network_interface[0].network_ip}.${var.dns_zone.dns_name}"
#  type  = "PTR"
#  ttl   = 300
#
#  managed_zone = var.dns_zone.name
#
#  rrdatas = [
#    "${var.name}-${count.index}.${var.dns_zone.dns_name}"
#  ]
#}