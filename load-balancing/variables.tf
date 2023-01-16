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
variable "network" {
  type = object({
    id = string
  })
}

###################################
#
#     Load Balancing
#
variable "aaa_healthcheck_aaa-name" {
  type = string
}

variable "aaa_healthcheck_aaa-port" {
  type = number
}

variable "loadbalancing_name" {
  type = string
}

variable "loadbalancing_cidr" {
  type = string
}