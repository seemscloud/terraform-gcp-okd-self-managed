###################################
#
#     Configuration
#
variable "region" {
  type = string
}

###################################
#
#     Networking
#
variable "network_name" {
  type = string
}

variable "dns_zone_name" {
  type = string
}

###################################
#
#     Load Balancing
#
variable "dns_zone_dns_name" {
  type = string
}

variable "lb_subnetwork_name" {
  type = string
}

variable "lb_subnetwork_cidr" {
  type = string
}