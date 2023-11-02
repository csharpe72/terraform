terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }

  backend "s3" {
    bucket  = "jenkins-terraform-state-bucket-imminent"
    key     = "development/network/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

module "backend-state" {
  source = "../modules/backend-state"
  tags   = local.common_tags
}

module "vpc" {
  source             = "../modules/vpc"
  vpc_cidr_block     = var.vpc_cidr_block
  environment        = var.environment
  public_subnet_cidr = var.public_subnet_cidr
  tags               = local.common_tags
}
module "security" {
  source         = "../modules/security"
  vpc_id         = module.vpc.vpc_id
  bastion_port   = module.security.bastion_port
  jenkins_ports  = module.security.jenkins_ports
  vpc_cidr_block = var.vpc_cidr_block
  tags           = local.common_tags
}
module "ec2" {
  source                  = "../modules/compute"
  instance_type           = var.instance_type
  key_name                = var.key_name
  environment             = var.environment
  subnets                 = values(module.vpc.public_subnets)
  private_subnets         = module.vpc.private_subnets
  bastion_security_groups = module.security.bastion_security_group_ids
  web_security_groups     = module.security.web_security_group_ids
  tags                    = local.common_tags
}
module "network" {
  source                = "../modules/network"
  public_subnet_id      = module.vpc.public_subnets
  lb_security_group_ids = [module.security.lb_security_group_ids]
  ec2_instance_ids      = module.ec2.jenkins_master
  tags                  = local.common_tags
}
