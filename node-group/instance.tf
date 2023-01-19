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
    subnetwork = google_compute_subnetwork.node_group.id
  }
  scheduling {
    preemptible       = var.preemptible
    automatic_restart = var.automatic_restart
  }

  depends_on = [
    google_compute_subnetwork.node_group
  ]

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
  }
}