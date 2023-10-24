variable "aws_region" {
  type = string
}

variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "public_subnets" {
  type = map(any)
  default = {
    "public-subnet-1" = 1
    "public-subnet-2" = 2
    "public-subnet-3" = 3
  }
}

variable "private_subnets" {
  type = map(any)
  default = {
    "private-subnet-1" = 1
    "private-subnet-2" = 2
    "private-subnet-3" = 3
  }
}

variable "public_subnet_cidr" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {

}

# variable "resource_tags" {
#   description = "Tags to set for all resources"
#   type        = map(string)
#   default = {
#     project_name = var.project_name,
#     environment  = var.environment
#     Terraform    = "true"
#   }
# }

# locals {
#   name_suffix = "${var.resource_tags["project_name"]}-${var.resource_tags["environment"]}"
# }
