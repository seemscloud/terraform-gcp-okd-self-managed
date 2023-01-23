output "bastion" {
  value = module.bastion.external_address
}

output "domains" {
  value = concat(
    module.node_group-master.dns_a_records,
    module.node_group-worker.dns_a_records,
    module.node_group-bootstrap.dns_a_records,
    [google_dns_record_set.load_balancer-dns_a_records-api.name],
    [google_dns_record_set.load_balancer-dns_a_records-api_int.name],
    [google_dns_record_set.load_balancer-dns_a_records-wildcard_apps.name],
    [module.bastion.dns_a_records]
  )
}
