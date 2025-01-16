# File: modules/psc/variables.tf
variable "producer_project_id" {
  description = "The producer project ID"
  type        = string
}

variable "consumer_project_id" {
  description = "The consumer project ID"
  type        = string
}

variable "network_id" {
  description = "The VPC network ID"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID"
  type        = string
}

variable "psc_subnet_id" {
  description = "The PSC subnet ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}