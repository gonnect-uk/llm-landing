# File: environments/dev/variables.tf
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The default GCP region"
  type        = string
}

variable "zone" {
  description = "The default GCP zone"
  type        = string
}

variable "billing_account" {
  description = "The billing account ID"
  type        = string
}