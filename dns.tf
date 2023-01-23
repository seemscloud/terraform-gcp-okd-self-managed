resource "google_dns_record_set" "load_balancer-dns_a_records-api" {
  name = "api.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 1

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}

resource "google_dns_record_set" "load_balancer-dns_a_records-api_int" {
  name = "api-int.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 1

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}

resource "google_dns_record_set" "load_balancer-dns_a_records-wildcard_apps" {
  name = "*.apps.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 1

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}