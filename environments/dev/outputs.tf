# File: environments/dev/outputs.tf
output "llm_gateway_project_id" {
  value = module.llm_gateway_project.project_id
}

output "gen_app_project_id" {
  value = module.gen_app_project.project_id
}

output "psc_service_attachment" {
  value = module.psc.service_attachment_id
}

output "producer_vm_ip" {
  value = module.test_vms.producer_vm_ip
}

output "consumer_vm_ip" {
  value = module.test_vms.consumer_vm_ip
}