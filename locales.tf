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
  aaa_networking_aaa-name                = "${local.random}-${var.aaa_networking_aaa-name}"
  aaa_networking_aaa-dns_zone_name       = "${local.random}-${var.aaa_networking_aaa-dns_zone_name}"
  aaa_networking_aaa-lb_subnetwork_name  = "${local.random}-${var.aaa_networking_aaa-lb_subnetwork_name}"
  aaa_networking_aaa-okd_subnetwork_name = "${local.random}-${var.aaa_networking_aaa-okd_subnetwork_name}"

  ###################################
  #
  #     Bastion
  #
  aaa_instance_aaa-name = "${local.random}-${var.aaa_instance_aaa-name}"

  ###################################
  #
  #     Load Balancing
  #
  aaa_healthcheck_aaa-name = "${local.random}-${var.aaa_healthcheck_aaa-name}"

  ###################################
  #
  #     Node Group (Bootstrap)
  #
  aaa_instance_eee-name = "${local.random}-${var.aaa_instance_eee-name}"

  ###################################
  #
  #     Node Group (Master)
  #
  aaa_instance_bbb-name = "${local.random}-${var.aaa_instance_bbb-name}"

  ###################################
  #
  #     Node Group (Infra)
  #
  #aaa_instance_ccc-name = "${local.random}-${var.aaa_instance_ccc-name}"

  ###################################
  #
  #     Node Group (Workers)
  #
  aaa_instance_ddd-name = "${local.random}-${var.aaa_instance_ddd-name}"
}