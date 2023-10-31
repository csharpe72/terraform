locals {
  common_tags = {
    Environment = var.environment
    ManagedBy   = var.managed_by
    Project     = var.project
  }
}
