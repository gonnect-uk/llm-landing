# File: modules/test_vms/variables.tf
variable "producer_project_id" {
  description = "The producer project ID"
  type        = string
}

variable "consumer_project_id" {
  description = "The consumer project ID"
  type        = string
}

variable "producer_network_id" {
  description = "The producer VPC network ID"
  type        = string
}

variable "producer_subnet_id" {
  description = "The producer subnet ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "zone" {
  description = "The GCP zone"
  type        = string
}