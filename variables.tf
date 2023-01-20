###################################
#
#     Configuration
#
variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "prefix" {
  type = string
}

###################################
#
#     Keys
#
variable "terraform_ssh_key_pub" {
  type = string
}

###################################
#
#     Networking
#
variable "aaa_networking_aaa-name" {
  type = string
}

variable "aaa_networking_aaa-dns_zone_name" {
  type = string
}

variable "aaa_networking_aaa-dns_zone_dns_name" {
  type = string
}

variable "aaa_networking_aaa-lb_subnetwork_name" {
  type = string
}

variable "aaa_networking_aaa-lb_subnetwork_cidr" {
  type = string
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

###################################
#
#     Bastion
#
variable "aaa_instance_aaa-name" {
  type = string
}

variable "aaa_instance_aaa-image" {
  type = string
}

variable "aaa_instance_aaa-root_disk_size" {
  type = number
}

variable "aaa_instance_aaa-root_disk_type" {
  type = string
}

variable "aaa_instance_aaa-desired_status" {
  type = string
}

variable "aaa_instance_aaa-tags" {
  type = list(string)
}

variable "aaa_instance_aaa-zones" {
  type = string
}

variable "aaa_instance_aaa-cidr" {
  type = string
}

variable "aaa_instance_aaa-type" {
  type = string
}

variable "aaa_instance_aaa-preemptible" {
  type = bool
}

variable "aaa_instance_aaa-automatic_restart" {
  type = bool
}

###################################
#
#     Node Group (Master)
#
variable "aaa_instance_bbb-name" {
  type = string
}

variable "aaa_instance_bbb-counter" {
  type = number
}

variable "aaa_instance_bbb-image" {
  type = string
}

variable "aaa_instance_bbb-root_disk_size" {
  type = number
}

variable "aaa_instance_bbb-root_disk_type" {
  type = string
}

variable "aaa_instance_bbb-desired_status" {
  type = string
}

variable "aaa_instance_bbb-tags" {
  type = list(string)
}

variable "aaa_instance_bbb-zones" {
  type = string
}

variable "aaa_instance_bbb-cidr" {
  type = string
}

variable "aaa_instance_bbb-type" {
  type = string
}

variable "aaa_instance_bbb-preemptible" {
  type = bool
}

variable "aaa_instance_bbb-automatic_restart" {
  type = bool
}

variable "aaa_instance_bbb-metadata_user_data" {
  type = string
}

###################################
#
#     Node Group (Worker)
#
variable "aaa_instance_ddd-name" {
  type = string
}

variable "aaa_instance_ddd-counter" {
  type = number
}

variable "aaa_instance_ddd-image" {
  type = string
}

variable "aaa_instance_ddd-root_disk_size" {
  type = number
}

variable "aaa_instance_ddd-root_disk_type" {
  type = string
}

variable "aaa_instance_ddd-desired_status" {
  type = string
}

variable "aaa_instance_ddd-tags" {
  type = list(string)
}

variable "aaa_instance_ddd-zones" {
  type = string
}

variable "aaa_instance_ddd-cidr" {
  type = string
}

variable "aaa_instance_ddd-type" {
  type = string
}

variable "aaa_instance_ddd-preemptible" {
  type = bool
}

variable "aaa_instance_ddd-automatic_restart" {
  type = bool
}

variable "aaa_instance_ddd-metadata_user_data" {
  type = string
}

###################################
#
#     Bootstrap
#
variable "aaa_instance_eee-name" {
  type = string
}


variable "aaa_instance_eee-counter" {
  type = number
}

variable "aaa_instance_eee-image" {
  type = string
}

variable "aaa_instance_eee-root_disk_size" {
  type = number
}

variable "aaa_instance_eee-root_disk_type" {
  type = string
}

variable "aaa_instance_eee-desired_status" {
  type = string
}

variable "aaa_instance_eee-tags" {
  type = list(string)
}

variable "aaa_instance_eee-zones" {
  type = string
}

variable "aaa_instance_eee-cidr" {
  type = string
}

variable "aaa_instance_eee-type" {
  type = string
}

variable "aaa_instance_eee-preemptible" {
  type = bool
}

variable "aaa_instance_eee-automatic_restart" {
  type = bool
}

variable "aaa_instance_eee-metadata_user_data" {
  type = string
}