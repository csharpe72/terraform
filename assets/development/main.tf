terraform {
  backend "s3" {
    bucket  = "jenkins-terraform-state-bucket-imminent"
    key     = "development/network/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

module "backend-state" {
  source = "../modules/backend-state"
}

module "vpc" {
  source         = "../modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  environment    = var.environment
  public_subnet_cidr = var.public_subnet_cidr
}

module "ec2" {
  source = "../modules/aws-instance"
  instance_type = var.instance_type
  key_name = var.key_name
  environment = var.environment
  subnets = values(module.vpc.public_subnets)
  private_subnets = module.vpc.private_subnets
}