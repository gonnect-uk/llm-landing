# File: modules/psc/outputs.tf
output "service_attachment_id" {
  description = "The ID of the service attachment"
  value       = google_compute_service_attachment.psc_attachment.id
}

output "forwarding_rule_id" {
  description = "The ID of the forwarding rule"
  value       = google_compute_forwarding_rule.producer_forwarding_rule.id
}

output "backend_service_id" {
  description = "The ID of the backend service"
  value       = google_compute_region_backend_service.producer_backend.id
}