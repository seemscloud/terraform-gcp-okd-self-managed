###################################
#
#     Instance (Bastion)
#
output "bastion-external_addresses" {
  value = module.bastion.external_address
}

output "bastion-internal_addresses" {
  value = module.bastion.internal_address
}

output "bastion-dns_a_records" {
  value = module.bastion.dns_a_records
}

###################################
#
#     Load Balancing
#
output "load_balancer-dns_a_records" {
  value = [
    google_dns_record_set.load_balancer-dns_a_records.name
  ]
}

###################################
#
#     Node Group (Bootstrap)
#
output "node_group_bootstrap-internal_addresses" {
  value = module.node_group-bootstrap.internal_addresses
}

output "node_group_bootstrap-dns_a_records" {
  value = module.node_group-bootstrap.dns_a_records
}

###################################
#
#     Node Group (Master)
#
output "node_group_master-internal_addresses" {
  value = module.node_group-master.internal_addresses
}

output "node_group_master-dns_a_records" {
  value = module.node_group-master.dns_a_records
}

###################################
#
#     Node Group (Worker)
#
output "node_group_worker-internal_addresses" {
  value = module.node_group-worker.internal_addresses
}

output "node_group_worker-dns_a_records" {
  value = module.node_group-worker.dns_a_records
}