# File: modules/network/main.tf
resource "google_compute_network" "vpc" {
  name                    = "llm-network"
  project                 = var.project_id
  auto_create_subnetworks = false

  lifecycle {
    prevent_destroy = false
  }
}

# Main subnet for VMs and general use
resource "google_compute_subnetwork" "subnet" {
  name          = "llm-subnet"
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.vpc.self_link
  ip_cidr_range = "10.0.0.0/24"

  lifecycle {
    prevent_destroy = false
  }
}

# Dedicated PSC subnet
resource "google_compute_subnetwork" "psc_subnet" {
  name          = "llm-psc-subnet"
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.vpc.self_link
  ip_cidr_range = "10.0.1.0/24"
  purpose       = "PRIVATE_SERVICE_CONNECT"

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = google_compute_network.vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.0.0.0/24", "10.0.1.0/24"]
  target_tags   = ["allow-internal"]

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_compute_firewall" "allow_health_check" {
  name    = "allow-health-check"
  network = google_compute_network.vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_compute_firewall" "allow_iap" {
  name    = "allow-iap"
  network = google_compute_network.vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]  # SSH port
  }

  # IAP IP ranges
  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["allow-iap"]

  lifecycle {
    prevent_destroy = false
  }
}