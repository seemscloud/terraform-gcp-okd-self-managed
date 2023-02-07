###################################
#
#     Configuration
#
variable "region" {
  type = string
}

variable "prefix" {
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

variable "dns_zone" {
  type = object({
    name     = string
    dns_name = string
  })
}

variable "okd_subnetwork" {
  type = object({
    name = string
    id   = string
  })
}

###################################
#
#     Node Group
#
variable "name" {
  type = string
}

variable "counter" {
  type = number
}

variable "image" {
  type = string
}

variable "root_disk_size" {
  type = number
}

variable "root_disk_type" {
  type = string
}

variable "desired_status" {
  type = string
}

variable "tags" {
  type = list(string)
}

variable "zones" {
  type = string
}

variable "type" {
  type = string
}

variable "preemptible" {
  type = bool
}

variable "automatic_restart" {
  type = bool
}

variable "metadata-user_data" {
  type = string
}