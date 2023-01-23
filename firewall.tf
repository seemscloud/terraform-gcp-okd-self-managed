###############################################
#
#     Internet to Bastion
#
resource "google_compute_firewall" "allow-internet_to_bastion" {
  name    = "${local.random}-allow-internet-to-bastion"
  network = module.networking.aaa_network_aaa.name

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22", "9000", "80", "443", "6443"]
  }

  target_tags = ["bastion"]
}

resource "google_compute_firewall" "allow-all_to_all" {
  name    = "${local.random}-allow-all-to-all"
  network = module.networking.aaa_network_aaa.name

  source_tags = ["all"]

  allow {
    protocol = "tcp"
    ports    = []
  }

  allow {
    protocol = "icmp"
    ports    = []
  }

  target_tags = ["all"]
}

################################################
##
##     Bastion to All
##
#resource "google_compute_firewall" "allow-bastion_to_all" {
#  name    = "${local.random}-allow-bastion-to-all"
#  network = module.networking.aaa_network_aaa.name
#
#  source_tags = ["bastion"]
#
#  allow {
#    protocol = "tcp"
#    ports    = ["22", "80", "8080", "443", "8443"]
#  }
#
#  target_tags = ["all"]
#}
#
################################################
##
##     Google Health Check IPs to All
##
#resource "google_compute_firewall" "allow-healthcheck_to_all" {
#  name    = "${local.random}-allow-healthcheck-to-all"
#  network = module.networking.aaa_network_aaa.name
#
#  priority = 0
#
#  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
#
#  allow {
#    protocol = "tcp"
#    ports    = ["80"]
#  }
#
#  target_tags = ["worker", "infra", "master", "bastion"]
#}
#
################################################
##
##     OKD Ports
##
#resource "google_compute_firewall" "allow-cluster_to_cluster" {
#  name    = "${local.random}-allow-cluster-firewall"
#  network = module.networking.aaa_network_aaa.name
#
#  source_tags = ["cluster"]
#
#  allow {
#    protocol = "tcp"
#    ports    = ["1936", "9000-9999", "10250-10259", "10256", "30000-32767"]
#  }
#
#  allow {
#    protocol = "udp"
#    ports    = ["4789", "6081", "9000-9999", "500", "4500", "30000-32767"]
#  }
#
#  allow {
#    protocol = "icmp"
#  }
#
#  target_tags = ["cluster"]
#}
#
#resource "google_compute_firewall" "allow-worker_to_master" {
#  name    = "${local.random}-allow-worker-to-master"
#  network = module.networking.aaa_network_aaa.name
#
#  source_tags = ["worker"]
#
#  allow {
#    protocol = "tcp"
#    ports    = ["6443"]
#  }
#
#  target_tags = ["master"]
#}
#
#resource "google_compute_firewall" "allow-master_to_master" {
#  name    = "${local.random}-allow-master-to-master"
#  network = module.networking.aaa_network_aaa.name
#
#  source_tags = ["master"]
#
#  allow {
#    protocol = "tcp"
#    ports    = ["2379-2380"]
#  }
#
#  target_tags = ["master"]
#}
#
#resource "google_compute_firewall" "allow-cluster_to_bastion" {
#  name    = "${local.random}-allow-cluster-to-bastion"
#  network = module.networking.aaa_network_aaa.name
#
#  source_tags = ["cluster", "bootstrap"]
#
#  allow {
#    protocol = "tcp"
#    ports    = ["80"]
#  }
#
#  allow {
#    protocol = "icmp"
#  }
#
#  target_tags = ["bastion"]
#}