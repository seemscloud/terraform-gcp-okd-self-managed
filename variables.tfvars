###################################
#
#     Configuration
#
project_id = "core-337701"
region     = "europe-central2"
prefix     = "a"

###################################
#
#     Keys
#
terraform_ssh_key_pub = <<EndOfMessage
terraform:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxMR6x6rHclUBQI3IQVPZN8xjkAVVAZmS1PV/hNg/XPc5sl5fI7/3FLmwu+A9PDuiPu5++60Ns4NtYJcd+hVQ9m/htl6DGPeUoflin1pmVFSfKMUctTRWsl+e2ldt3CVmTgFclLABdLDR+cSb3jSqNXgonzjNcWbTfhrsSnqNuD+2GxXpGZXc4rYDloSrlGVOx0mEiyJrMocJFuVlh1JB8Os0KNnx5qD56h5zIRLGkhHhgXIO5kJ+hNB+vF3FV2Fq9Ar47+DrQiD/o9/h17HFDvD0tzze1GLYAJs4QcFJJPKdWM1kHyXa/p9TIFLc3rVnCrVx1NihgaEhiY+d452otV0p1Bq1tvotfPJ92BDSNlF7A1YuJNYqRkNNpwSPMznPQtVkeRCHTNH5MmMqhPptGEPLiDlkMUZeFFjTKz0IDo6QCX05WBl+SXYLo1l2R9jCoKstmoKvlsFY6fcYpSYj78X9E4bIX++LSLiG9oGXwg2xoZTlwofhqjnI+xc9tMiU=
EndOfMessage

###################################
#
#     Networking
#
aaa_networking_aaa-name               = "network"
aaa_networking_aaa-dns_zone_name      = "seems-cloud"
aaa_networking_aaa-dns_zone_dns_name  = "seems.cloud."
aaa_networking_aaa-lb_subnetwork_name = "loadbalancing"
aaa_networking_aaa-lb_subnetwork_cidr = "10.255.255.0/24"

###################################
#
#     Instance (Bastion)
#
aaa_instance_aaa-name              = "bastion"
aaa_instance_aaa-image             = "ubuntu-os-cloud/ubuntu-minimal-2204-lts"
aaa_instance_aaa-root_disk_size    = 64
aaa_instance_aaa-root_disk_type    = "pd-ssd"
aaa_instance_aaa-desired_status    = "RUNNING"
aaa_instance_aaa-tags              = ["bastion", "all"]
aaa_instance_aaa-zones             = "europe-central2-a"
aaa_instance_aaa-cidr              = "10.100.100.0/24"
aaa_instance_aaa-type              = "e2-highcpu-2"
aaa_instance_aaa-preemptible       = true
aaa_instance_aaa-automatic_restart = false

###################################
#
#     Load Balancing
#
aaa_healthcheck_aaa-name = "tcp-80"
aaa_healthcheck_aaa-port = 80

###################################
#
#     Node Group (Bootstrap)
#
aaa_instance_eee-name              = "bootstrap"
aaa_instance_eee-counter           = 1
aaa_instance_eee-image             = "fedora-coreos-cloud/fedora-coreos-stable"
aaa_instance_eee-root_disk_size    = 64
aaa_instance_eee-root_disk_type    = "pd-ssd"
aaa_instance_eee-desired_status    = "RUNNING"
aaa_instance_eee-tags              = ["bootstrap", "all"]
aaa_instance_eee-zones             = "europe-central2-a"
aaa_instance_eee-cidr              = "10.100.101.0/24"
aaa_instance_eee-type              = "e2-standard-2"
aaa_instance_eee-preemptible       = true
aaa_instance_eee-automatic_restart = false

###################################
#
#     Node Group (Master)
#
aaa_instance_bbb-name              = "master"
aaa_instance_bbb-counter           = 3
aaa_instance_bbb-image             = "fedora-coreos-cloud/fedora-coreos-stable"
aaa_instance_bbb-root_disk_size    = 64
aaa_instance_bbb-root_disk_type    = "pd-ssd"
aaa_instance_bbb-desired_status    = "RUNNING"
aaa_instance_bbb-tags              = ["master", "all", "cluster"]
aaa_instance_bbb-zones             = "europe-central2-a"
aaa_instance_bbb-cidr              = "10.100.102.0/24"
aaa_instance_bbb-type              = "e2-standard-2"
aaa_instance_bbb-preemptible       = true
aaa_instance_bbb-automatic_restart = false

###################################
#
#     Node Group (Worker)
#
aaa_instance_ddd-name              = "worker"
aaa_instance_ddd-counter           = 3
aaa_instance_ddd-image             = "fedora-coreos-cloud/fedora-coreos-stable"
aaa_instance_ddd-root_disk_size    = 64
aaa_instance_ddd-root_disk_type    = "pd-ssd"
aaa_instance_ddd-desired_status    = "RUNNING"
aaa_instance_ddd-tags              = ["worker", "all", "cluster"]
aaa_instance_ddd-zones             = "europe-central2-a"
aaa_instance_ddd-cidr              = "10.100.103.0/24"
aaa_instance_ddd-type              = "e2-standard-2"
aaa_instance_ddd-preemptible       = true
aaa_instance_ddd-automatic_restart = false