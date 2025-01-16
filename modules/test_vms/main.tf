# File: modules/test_vms/main.tf
resource "google_compute_instance" "producer_vm" {
  name         = "producer-vm"
  project      = var.producer_project_id
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["allow-iap", "allow-health-check"]  # Added network tags

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = var.producer_network_id
    subnetwork = var.producer_subnet_id
  }

  metadata = {
    enable-oslogin = "TRUE"
    startup-script = <<-EOF
      #!/bin/bash
      apt-get update
      apt-get install -y python3
      python3 -m http.server 80
    EOF
  }

  service_account {
    scopes = ["cloud-platform"]
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_compute_instance" "consumer_vm" {
  name         = "consumer-vm"
  project      = var.consumer_project_id
  machine_type = "e2-micro"
  zone         = var.zone
  
  tags = ["allow-iap"]  # Added network tag

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  service_account {
    scopes = ["cloud-platform"]
  }

  lifecycle {
    prevent_destroy = false
  }
}