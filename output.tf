output "bastion-ip" {
  value = module.bastion.external_address
}

output "node_group-master_ips" {
  value = module.node_group-master.internal_addresses
}

output "node_group-master_a_records" {
  value = module.node_group-master.internal_a_records
}

output "node_group-infra_ips" {
  value = module.node_group-infra.internal_addresses
}

output "node_group-infra_a_records" {
  value = module.node_group-infra.internal_a_records
}

output "node_group-worker_ips" {
  value = module.node_group-worker.internal_addresses
}

output "node_group-worker_a_records" {
  value = module.node_group-worker.internal_a_records
}