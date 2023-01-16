resource "google_dns_record_set" "lb_api-dns_a_records" {
  name = "api.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}

resource "google_dns_record_set" "lb_api_int-dns_a_records" {
  name = "api-int.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}

resource "google_dns_record_set" "lb_wildcard-dns_a_records" {
  name = "*.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}

resource "google_dns_record_set" "lb_bootstrap-dns_a_records" {
  name = "bootstrap.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}