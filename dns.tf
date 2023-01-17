resource "google_dns_record_set" "load_balancer-dns_a_records" {
  name = "*.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}