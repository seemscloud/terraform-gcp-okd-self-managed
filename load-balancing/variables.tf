###################################
#
#     Configuration
#
variable "region" {
  type = string
}

###################################
#
#     Load Balancing
#
variable "name" {
  type = string
}

variable "subnetwork_id" {
  type = string
}

variable "instance_group_id" {
  type = string
}

variable "healthcheck_name" {
  type = string
}

variable "healthcheck_port" {
  type = number
}