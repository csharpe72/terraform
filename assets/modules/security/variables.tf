locals {
  bastion-sg = {
    "SSH" = {
      protocol    = "tcp"
      port        = 22,
      cidr_blocks = ["0.0.0.0/0"],
      security_groups = null,
    }
  }
  jenkins-sg = {
    "SSH" = {
      protocol    = "tcp"
      port        = 22,
      cidr_blocks = null,
      security_groups = [aws_security_group.bastion]
    }
    "WEB" = {
      protocol    = "tcp"
      port        = 8080,
      cidr_blocks = ["0.0.0.0/0"],
    }
    "TLS" = {
      protocol    = "tcp"
      port        = 8443,
      cidr_blocks = ["0.0.0.0/0"],
    }
  }
}

variable "vpc_id" {

}

variable "bastion_port" {

}

variable "jenkins_ports" {

}
