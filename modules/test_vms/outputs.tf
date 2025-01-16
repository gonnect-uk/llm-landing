# File: modules/test_vms/outputs.tf
output "producer_vm_ip" {
  description = "Internal IP of the producer VM"
  value       = google_compute_instance.producer_vm.network_interface[0].network_ip
}

output "consumer_vm_ip" {
  description = "Internal IP of the consumer VM"
  value       = google_compute_instance.consumer_vm.network_interface[0].network_ip
}