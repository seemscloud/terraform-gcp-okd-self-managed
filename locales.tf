locals {
  ###################################
  #
  #     Configuration
  #
  random = "${var.prefix}${random_string.random.result}"

  ###################################
  #
  #     Networking
  #
  aaa_network_aaa-name  = "${local.random}-${var.aaa_network_aaa-name}"
  aaa_dns_zone_aaa-name = "${local.random}-${var.aaa_dns_zone_aaa-name}"

  ###################################
  #
  #     Load Balancing
  #
  aaa_healthcheck_aaa-name   = "${local.random}-${var.aaa_healthcheck_aaa-name}"
  aaa_loadbalancing_aaa-name = "${local.random}-${var.aaa_loadbalancing_aaa-name}"

  ###################################
  #
  #     Bastion
  #
  aaa_instance_aaa-name = "${local.random}-${var.aaa_instance_aaa-name}"

  ###################################
  #
  #     Node Group (Master)
  #
  aaa_instance_bbb-name = "${local.random}-${var.aaa_instance_bbb-name}"

  ###################################
  #
  #     Node Group (Infra)
  #
  aaa_instance_ccc-name = "${local.random}-${var.aaa_instance_ccc-name}"

  ###################################
  #
  #     Node Group (Workers)
  #
  aaa_instance_ddd-name = "${local.random}-${var.aaa_instance_ddd-name}"
}