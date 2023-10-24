
locals {
  bastion-sg = {
    "SSH" = {
      protocol        = "tcp"
      port            = 22,
      cidr_blocks     = [],
      security_groups = null,
    }
  }
  jenkins-sg = {
    "WEB" = {
      protocol        = "tcp"
      port            = 8080,
      cidr_blocks     = ["0.0.0.0/0"],
      security_groups = [],
    }
    "TLS" = {
      protocol        = "tcp"
      port            = 8443,
      cidr_blocks     = ["0.0.0.0/0"],
      security_groups = [],
    }
    "SSH" = {
      protocol        = "tcp"
      port            = 22,
      cidr_blocks     = [],
      security_groups = [aws_security_group.bastion.id],
    }
  }
  lb-sg = {
    "LB" = {
      protocol        = "tcp"
      port            = 80,
      cidr_blocks     = ["0.0.0.0/0"],
      security_groups = [],
    }
    "LB-TLS" = {
      protocol        = "tcp"
      port            = 443,
      cidr_blocks     = ["0.0.0.0/0"],
      security_groups = null,
    }
  }
}
