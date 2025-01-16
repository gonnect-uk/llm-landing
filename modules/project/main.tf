# File: modules/project/main.tf
resource "google_project" "project" {
  name            = var.project_name
  project_id      = var.project_id
  billing_account = var.billing_account

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_project_service" "services" {
  for_each = toset(var.services)
  project  = google_project.project.project_id
  service  = each.value

  disable_dependent_services = true
  disable_on_destroy        = true

  lifecycle {
    prevent_destroy = false
  }
}