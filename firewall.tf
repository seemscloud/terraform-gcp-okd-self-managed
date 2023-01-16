resource "google_compute_firewall" "all_to_bastion" {
  name    = "${local.random}-all-to-bastion"
  network = module.networking.aaa_network_aaa.name

  source_tags = ["all"]

  deny {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["bastion"]
}

resource "google_compute_firewall" "internet_to_bastion" {
  name    = "${local.random}-internet-to-bastion"
  network = module.networking.aaa_network_aaa.name

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["bastion"]
}

resource "google_compute_firewall" "bastion_to_all" {
  name    = "${local.random}-bastion-to-all"
  network = module.networking.aaa_network_aaa.name

  source_tags = ["bastion"]

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080", "443", "8443"]
  }

  target_tags = ["all"]
}

resource "google_compute_firewall" "healthcheck_to_all" {
  name    = "${local.random}-healthcheck-to-all"
  network = module.networking.aaa_network_aaa.name

  priority = 0

  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}

resource "google_compute_firewall" "all_to_lb" {
  name    = "${local.random}-all-to-loadbalancers"
  network = module.networking.aaa_network_aaa.name

  source_tags = ["all"]

  allow {
    protocol = "tcp"
    ports    = [
      "8080"
    ]
  }
}