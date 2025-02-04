

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.19.0"
    }
  }
}

provider "google" {
  project     = "fintech-dashboard-terraform"
  region      = "europe-west1"
  }
