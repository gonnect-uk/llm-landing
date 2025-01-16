# File: modules/project/outputs.tf
output "project_id" {
  description = "The project ID"
  value       = google_project.project.project_id
}

output "project_number" {
  description = "The project number"
  value       = google_project.project.number
}