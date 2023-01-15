terraform {
  backend "local" {
    path = ".states/terraform.tfstate"
  }
}

provider "google" {
  credentials = ".credentials.json"
  project     = var.project_id
  region      = var.region
}

resource "google_compute_project_metadata" "metadata" {
  metadata = {
    ssh-keys = var.terraform_ssh_key_pub
  }
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}