# Creating VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = merge(
    var.tags,
    {
      LaunchMonthYear = formatdate("MM-YYYY", timestamp())
    },
  )

  lifecycle {
    ignore_changes = [
      # Ensure tags are only added at the time of resource creation and not updated everytime I run terraform
      tags["LaunchMonthYear"]
    ]
  }
}
