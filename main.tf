###################################
#
#     Networking
#
module "networking" {
  source = "./networking"

  region = var.region

  network_name       = local.aaa_networking_aaa-name
  dns_zone_name      = local.aaa_networking_aaa-dns_zone_name
  dns_zone_dns_name  = var.aaa_networking_aaa-dns_zone_dns_name
  lb_subnetwork_name = local.aaa_networking_aaa-lb_subnetwork_name
  lb_subnetwork_cidr = var.aaa_networking_aaa-lb_subnetwork_cidr
}

###################################
#
#     Instance (Bastion)
#
module "bastion" {
  source = "./instance"

  region = var.region
  prefix = local.random

  network  = module.networking.aaa_network_aaa
  dns_zone = module.networking.aaa_dns_zone_aaa

  name              = local.aaa_instance_aaa-name
  image             = var.aaa_instance_aaa-image
  root_disk_size    = var.aaa_instance_aaa-root_disk_size
  root_disk_type    = var.aaa_instance_aaa-root_disk_type
  desired_status    = var.aaa_instance_aaa-desired_status
  type              = var.aaa_instance_aaa-type
  zones             = var.aaa_instance_aaa-zones
  tags              = var.aaa_instance_aaa-tags
  preemptible       = var.aaa_instance_aaa-preemptible
  automatic_restart = var.aaa_instance_aaa-automatic_restart
  cidr              = var.aaa_instance_aaa-cidr

  depends_on = [
    module.networking
  ]
}

###################################
#
#     Load Balancing
#
module "load_balancing-bastion" {
  source = "./load-balancing"

  region = var.region

  name              = local.aaa_instance_aaa-name
  subnetwork_id     = module.bastion.subnetwork_id
  instance_group_id = module.bastion.instance_group_id
  healthcheck_name  = local.aaa_healthcheck_aaa-name
  healthcheck_port  = var.aaa_healthcheck_aaa-port
}

###################################
#
#     Node Group (Bootstrap)
#
module "node_group-bootstrap" {
  source = "./node-group"

  region = var.region
  prefix = local.random

  network  = module.networking.aaa_network_aaa
  dns_zone = module.networking.aaa_dns_zone_aaa
  name     = local.aaa_instance_eee-name

  counter           = var.aaa_instance_eee-counter
  image             = var.aaa_instance_eee-image
  root_disk_size    = var.aaa_instance_eee-root_disk_size
  root_disk_type    = var.aaa_instance_eee-root_disk_type
  desired_status    = var.aaa_instance_eee-desired_status
  type              = var.aaa_instance_eee-type
  zones             = var.aaa_instance_eee-zones
  tags              = var.aaa_instance_eee-tags
  preemptible       = var.aaa_instance_eee-preemptible
  automatic_restart = var.aaa_instance_eee-automatic_restart
  cidr              = var.aaa_instance_eee-cidr

  depends_on = [
    module.networking
  ]
}

###################################
#
#     Node Group (Master)
#
module "node_group-master" {
  source = "./node-group"

  region = var.region
  prefix = local.random

  network  = module.networking.aaa_network_aaa
  dns_zone = module.networking.aaa_dns_zone_aaa

  name              = local.aaa_instance_bbb-name
  counter           = var.aaa_instance_bbb-counter
  image             = var.aaa_instance_bbb-image
  root_disk_size    = var.aaa_instance_bbb-root_disk_size
  root_disk_type    = var.aaa_instance_bbb-root_disk_type
  desired_status    = var.aaa_instance_bbb-desired_status
  type              = var.aaa_instance_bbb-type
  zones             = var.aaa_instance_bbb-zones
  tags              = var.aaa_instance_bbb-tags
  preemptible       = var.aaa_instance_bbb-preemptible
  automatic_restart = var.aaa_instance_bbb-automatic_restart
  cidr              = var.aaa_instance_bbb-cidr

  depends_on = [
    module.networking
  ]
}

###################################
#
#     Node Group (Worker)
#
module "node_group-worker" {
  source = "./node-group"

  region = var.region
  prefix = local.random

  network  = module.networking.aaa_network_aaa
  dns_zone = module.networking.aaa_dns_zone_aaa
  name     = local.aaa_instance_ddd-name

  counter           = var.aaa_instance_ddd-counter
  image             = var.aaa_instance_ddd-image
  root_disk_size    = var.aaa_instance_ddd-root_disk_size
  root_disk_type    = var.aaa_instance_ddd-root_disk_type
  desired_status    = var.aaa_instance_ddd-desired_status
  type              = var.aaa_instance_ddd-type
  zones             = var.aaa_instance_ddd-zones
  tags              = var.aaa_instance_ddd-tags
  preemptible       = var.aaa_instance_ddd-preemptible
  automatic_restart = var.aaa_instance_ddd-automatic_restart
  cidr              = var.aaa_instance_ddd-cidr

  depends_on = [
    module.networking
  ]
}