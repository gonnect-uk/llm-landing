# File: modules/network/outputs.tf
output "network_id" {
  description = "The ID of the VPC"
  value       = google_compute_network.vpc.id
}

output "network_self_link" {
  description = "The self-link of the VPC"
  value       = google_compute_network.vpc.self_link
}

output "subnet_id" {
  description = "The ID of the main subnet"
  value       = google_compute_subnetwork.subnet.id
}

output "psc_subnet_id" {
  description = "The ID of the PSC subnet"
  value       = google_compute_subnetwork.psc_subnet.id
}