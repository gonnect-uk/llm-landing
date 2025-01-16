# File: scripts/cleanup.sh
#!/bin/bash
set -e

echo "Starting cleanup process..."

# Change to the Terraform directory
cd ../environments/dev

# Destroy all resources
echo "Destroying Terraform-managed resources..."
terraform destroy -auto-approve

# Remove Terraform state bucket
echo "Removing Terraform state bucket..."
gsutil rm -r gs://gonnect-llm-hub-tfstate/terraform/state/dev || true
gsutil rb gs://gonnect-llm-hub-tfstate || true

# Disable services in the base project
echo "Disabling services in base project..."
gcloud services disable \
  compute.googleapis.com \
  servicenetworking.googleapis.com \
  iam.googleapis.com \
  --project gonnect-llm-hub-439014 \
  --force

echo "Cleanup complete!"