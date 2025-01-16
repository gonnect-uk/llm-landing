# File: environments/dev/backend.tf
terraform {
  backend "gcs" {
    bucket = "gonnect-llm-hub-tfstate"
    prefix = "terraform/state/dev"
  }
}