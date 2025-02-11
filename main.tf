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
  region  = "europe-west1"
}

# Compute instance resource
resource "google_compute_instance" "default" {
  name         = "my-instance"
  machine_type = "n2-standard-2"
  zone         = "europe-west1-c"

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
    email  = "terraform-runner@fintech-dashboard-terraform.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}

# Google Cloud Storage bucket
resource "google_storage_bucket" "static-site" {
  name          = "fintech-dashboard-terraform"
  location      = "EU"
  force_destroy = true

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  cors {
    origin          = ["http://image-store.com"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

# Cloud SQL PostgreSQL instance
resource "google_sql_database_instance" "postgresql" {
  name             = "fintechsql-instance"
  region           = "europe-west1"
  database_version = "POSTGRES_13"

  settings {
    tier         = "db-f1-micro"  # Updated billing tier
    pricing_plan = "PACKAGE"           # Pricing plan

    ip_configuration {
      authorized_networks {
        name  = "office-ip"
        value = "123.45.67.89/32"  # Replace with your IP or IP range
      }
      ipv4_enabled = true
    }

    backup_configuration {
      enabled = true
      start_time = "03:00"  # Choose a backup time
      point_in_time_recovery_enabled = true
    }

    maintenance_window {
      day  = 6  # Saturday
      hour = 2  # 2 AM
    }
  }

  deletion_protection = true
}

# Cloud SQL database (PostgreSQL)
resource "google_sql_database" "postgresql_database" {
  name     = "fintechdb"
  instance = google_sql_database_instance.postgresql.name
}

# Cloud SQL user (PostgreSQL)
resource "google_sql_user" "postgresql_user" {
  name     = "dbuser"
  instance = google_sql_database_instance.postgresql.name
  password = var.db_password  # Use a variable for better security
}

# Define the database password variable
variable "db_password" {
  type      = string
  sensitive = true
}

# BigQuery dataset
resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "credit_card_transactions_fraud_detection"
  friendly_name               = "Credit Card Transactions Fraud Detection Dataset"
  description                 = "Dataset for storing credit card transaction data for fraud detection."
  location                    = "EU"

  access {
    role          = "roles/bigquery.dataOwner"
    user_by_email = "terraform-runner@fintech-dashboard-terraform.iam.gserviceaccount.com"
  }
}

# Grant the terraform-runner service account the bigquery.dataOwner role for the dataset
resource "google_bigquery_dataset_iam_member" "dataset_iam_member" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  role       = "roles/bigquery.dataOwner"
  member     = "serviceAccount:terraform-runner@fintech-dashboard-terraform.iam.gserviceaccount.com"
}
