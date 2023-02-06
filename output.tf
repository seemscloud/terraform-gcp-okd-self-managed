output "bastion" {
  value = module.bastion.external_address
}

output "nodes" {
  value = concat(
    module.node_group-master.dns_a_records,
    module.node_group-worker.dns_a_records,
    module.node_group-bootstrap.dns_a_records,
    [module.bastion.dns_a_records]
  )
}

output "apis" {
  value = concat(
    [google_dns_record_set.load_balancer-dns_a_records-api.name],
    [google_dns_record_set.load_balancer-dns_a_records-api_int.name]
  )
}

output "routes" {
  value = concat(
    [google_dns_record_set.load_balancer-dns_a_records-wildcard_apps.name],
    [google_dns_record_set.load_balancer-dns_a_records-oauth_openshift.name],
    [google_dns_record_set.load_balancer-dns_a_records-console_openshift_console.name],
    [google_dns_record_set.load_balancer-dns_a_records-downloads_openshift_console.name],
    [google_dns_record_set.load_balancer-dns_a_records-canary_openshift_ingress_canary.name],
    [google_dns_record_set.load_balancer-dns_a_records-alertmanager_main_openshift_monitoring.name],
    [google_dns_record_set.load_balancer-dns_a_records-prometheus_k8s_openshift_monitoring.name],
    [google_dns_record_set.load_balancer-dns_a_records-prometheus_k8s_federate_openshift_monitoring.name],
    [google_dns_record_set.load_balancer-dns_a_records-thanos_querier_openshift_monitoring.name]
  )
}