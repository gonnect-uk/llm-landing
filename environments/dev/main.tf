# File: environments/dev/main.tf
module "llm_gateway_project" {
  source          = "../../modules/project"
  project_id      = "llm-gw-${substr(var.project_id, -8, 8)}"  # Use last 8 chars
  project_name    = "LLM Gateway"
  billing_account = var.billing_account
  services        = [
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
    "networkservices.googleapis.com",
    "iam.googleapis.com"
  ]
}

module "gen_app_project" {
  source          = "../../modules/project"
  project_id      = "gen-app-${substr(var.project_id, -8, 8)}"  # Use last 8 chars
  project_name    = "Gen Application"
  billing_account = var.billing_account
  services        = [
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
    "iam.googleapis.com"
  ]
}

module "network" {
  source     = "../../modules/network"
  project_id = module.llm_gateway_project.project_id
  region     = var.region
  depends_on = [module.llm_gateway_project]
}

module "psc" {
  source              = "../../modules/psc"
  producer_project_id = module.llm_gateway_project.project_id
  consumer_project_id = module.gen_app_project.project_id
  network_id         = module.network.network_id
  subnet_id          = module.network.subnet_id
  psc_subnet_id      = module.network.psc_subnet_id
  region             = var.region
  depends_on         = [module.network]
}

module "test_vms" {
  source              = "../../modules/test_vms"
  producer_project_id = module.llm_gateway_project.project_id
  consumer_project_id = module.gen_app_project.project_id
  producer_network_id = module.network.network_id
  producer_subnet_id  = module.network.subnet_id
  region             = var.region
  zone               = var.zone
  depends_on         = [module.psc]
}