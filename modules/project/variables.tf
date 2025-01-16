# File: modules/project/variables.tf
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "project_name" {
  description = "The GCP project name"
  type        = string
}

variable "billing_account" {
  description = "The billing account ID"
  type        = string
}

variable "services" {
  description = "List of APIs to enable"
  type        = list(string)
  default     = []
}
