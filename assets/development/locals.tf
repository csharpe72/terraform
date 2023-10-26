locals {
  environment = "Development"
  managed_by  = "Terraform"
  project     = "Jenkins"
}

locals {
  common_tags = {
    Environment = local.environment
    ManagedBy   = local.managed_by
    Project     = local.project
  }
}
