output "bastion-external_addresses" {
  value = module.bastion.external_address
}

output "node_group-dns_a_records" {
  value = concat(
    module.node_group-master.dns_a_records,
    module.node_group-worker.dns_a_records,
    module.node_group-bootstrap.dns_a_records,
    [google_dns_record_set.load_balancer-dns_a_records.name],
    [module.bastion.dns_a_records]
  )
}
