# File: modules/psc/main.tf
resource "google_compute_service_attachment" "psc_attachment" {
  provider = google-beta
  name     = "llm-psc-attachment"
  region   = var.region
  project  = var.producer_project_id

  enable_proxy_protocol = true
  connection_preference = "ACCEPT_AUTOMATIC"
  nat_subnets          = [var.psc_subnet_id]  # Using PSC subnet
  target_service       = google_compute_forwarding_rule.producer_forwarding_rule.id

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_compute_forwarding_rule" "producer_forwarding_rule" {
  name    = "llm-producer-forwarding-rule"
  region  = var.region
  project = var.producer_project_id

  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.producer_backend.id
  all_ports            = true
  network              = var.network_id
  subnetwork           = var.subnet_id

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_compute_region_backend_service" "producer_backend" {
  name                  = "llm-producer-backend"
  region                = var.region
  project               = var.producer_project_id
  protocol              = "TCP"
  load_balancing_scheme = "INTERNAL"
  health_checks         = [google_compute_health_check.health_check.id]

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_compute_health_check" "health_check" {
  name               = "llm-health-check"
  project            = var.producer_project_id
  timeout_sec        = 1
  check_interval_sec = 1

  tcp_health_check {
    port = "80"
  }

  lifecycle {
    prevent_destroy = false
  }
}