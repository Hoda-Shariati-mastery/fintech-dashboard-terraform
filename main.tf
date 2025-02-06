terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.19.0"
    }
  }
}

provider "google" {
  project = "fintech-dashboard-terraform"
  region  = "europe-west1-c"
}

resource "google_compute_instance" "default" {
  name         = "my-instance"
  machine_type = "n2-standard-2"
  zone         = "europe-west1-c"  # Changed to Belgium

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      # Ephemeral public IP
    }
  }

  service_account {
    email  = "terraform-runner@fintech-dashboard-terraform.iam.gserviceaccount.com"  # Use existing SA
    scopes = ["cloud-platform"]
  }
}

