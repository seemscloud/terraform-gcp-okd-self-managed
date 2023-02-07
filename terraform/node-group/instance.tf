resource "google_compute_address" "node_group-internal" {
  name   = "${var.name}-${count.index}"
  region = var.region

  count = var.counter

  address_type = "INTERNAL"
  subnetwork   = var.okd_subnetwork.id
}

resource "google_compute_instance" "node_group" {
  count          = var.counter
  name           = "${var.name}-${count.index}"
  machine_type   = var.type
  zone           = var.zones
  tags           = var.tags
  desired_status = var.desired_status

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.root_disk_size
      type  = var.root_disk_type
    }
  }

  network_interface {
    network    = var.network.id
    subnetwork = var.okd_subnetwork.id

    network_ip = google_compute_address.node_group-internal[count.index].address
  }
  scheduling {
    preemptible       = var.preemptible
    automatic_restart = var.automatic_restart
  }

  lifecycle {
    ignore_changes = [
      boot_disk.0.initialize_params.0.image
    ]
  }

  shielded_instance_config {
    enable_vtpm                 = false
    enable_integrity_monitoring = false
    enable_secure_boot          = false
  }

  metadata = {
    serial-port-enable = true
    user-data          = file("${path.root}/${var.metadata-user_data}")
  }
}