resource "google_compute_instance" "bastion" {
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
    subnetwork = google_compute_subnetwork.bastion.id

    access_config {
      nat_ip = google_compute_address.bastion.address
    }
  }
  scheduling {
    preemptible       = var.preemptible
    automatic_restart = var.automatic_restart
  }

  depends_on = [
    google_compute_subnetwork.bastion,
    google_compute_address.bastion
  ]

#  lifecycle {
  #    ignore_changes = [
  #      boot_disk.0.initialize_params.0.image
  #    ]
  #  }
}