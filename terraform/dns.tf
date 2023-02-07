################################################
#
#   OKD API, API INT
#

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

################################################
#
#   OKD Routes (Wildcard)
#

resource "google_dns_record_set" "load_balancer-dns_a_records-wildcard_apps" {
  name = "*.apps.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 1

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}

################################################
#
#   OKD Routes (FQDNs)
#

resource "google_dns_record_set" "load_balancer-dns_a_records-oauth_openshift" {
  name = "oauth-openshift.apps.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 1

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}

resource "google_dns_record_set" "load_balancer-dns_a_records-console_openshift_console" {
  name = "console-openshift-console.apps.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 1

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}

resource "google_dns_record_set" "load_balancer-dns_a_records-downloads_openshift_console" {
  name = "downloads-openshift-console.apps.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 1

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}

resource "google_dns_record_set" "load_balancer-dns_a_records-canary_openshift_ingress_canary" {
  name = "canary-openshift-ingress-canary.apps.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 1

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}

resource "google_dns_record_set" "load_balancer-dns_a_records-alertmanager_main_openshift_monitoring" {
  name = "alertmanager-main-openshift-monitoring.apps.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 1

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}

resource "google_dns_record_set" "load_balancer-dns_a_records-prometheus_k8s_openshift_monitoring" {
  name = "prometheus-k8s-openshift-monitoring.apps.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 1

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}

resource "google_dns_record_set" "load_balancer-dns_a_records-prometheus_k8s_federate_openshift_monitoring" {
  name = "prometheus-k8s-federate-openshift-monitoring.apps.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 1

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}

resource "google_dns_record_set" "load_balancer-dns_a_records-thanos_querier_openshift_monitoring" {
  name = "thanos-querier-openshift-monitoring.apps.okd.${var.aaa_networking_aaa-dns_zone_dns_name}"
  type = "A"
  ttl  = 1

  managed_zone = local.aaa_networking_aaa-dns_zone_name

  rrdatas = [
    module.load_balancing-bastion.load_balancer-ip_address
  ]
}