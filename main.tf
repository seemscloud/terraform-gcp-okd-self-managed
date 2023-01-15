###################################
#
#     Networking
#
module "networking" {
  source = "./networking"

  aaa_network_aaa-name      = local.aaa_network_aaa-name
  aaa_dns_zone_aaa-name     = local.aaa_dns_zone_aaa-name
  aaa_dns_zone_aaa-dns_name = var.aaa_dns_zone_aaa-dns_name
}

###################################
#
#     Bastion
#
module "bastion" {
  source = "./bastion"

  region = var.region

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
#     Node Group (Master)
#
module "node_group-master" {
  source = "./node-group"

  region = var.region

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
#     Node Group (Infra)
#
module "node_group-infra" {
  source = "./node-group"

  region = var.region

  network  = module.networking.aaa_network_aaa
  dns_zone = module.networking.aaa_dns_zone_aaa

  name              = local.aaa_instance_ccc-name
  counter           = var.aaa_instance_ccc-counter
  image             = var.aaa_instance_ccc-image
  root_disk_size    = var.aaa_instance_ccc-root_disk_size
  root_disk_type    = var.aaa_instance_ccc-root_disk_type
  desired_status    = var.aaa_instance_ccc-desired_status
  type              = var.aaa_instance_ccc-type
  zones             = var.aaa_instance_ccc-zones
  tags              = var.aaa_instance_ccc-tags
  preemptible       = var.aaa_instance_ccc-preemptible
  automatic_restart = var.aaa_instance_ccc-automatic_restart
  cidr              = var.aaa_instance_ccc-cidr

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

  network  = module.networking.aaa_network_aaa
  dns_zone = module.networking.aaa_dns_zone_aaa

  name              = local.aaa_instance_ddd-name
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