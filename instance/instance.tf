resource "google_compute_instance" "instance" {
  name           = var.name
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
    subnetwork = google_compute_subnetwork.instance.id

    access_config {
      nat_ip = google_compute_address.instance.address
    }
  }
  scheduling {
    preemptible       = var.preemptible
    automatic_restart = var.automatic_restart
  }

  depends_on = [
    google_compute_subnetwork.instance,
    google_compute_address.instance
  ]

  lifecycle {
    ignore_changes = [
      boot_disk.0.initialize_params.0.image
    ]
  }
}