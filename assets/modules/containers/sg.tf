/*** A security group to allow SSH access into our bastion instance.*/
locals {
  ingress_rules = [{
    port        = 22
    description = "Ingress rules for port 22"
  }]
}

resource "aws_security_group" "bastion" {
  name   = "bastion-security-group"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = local.ingress.value.description
      from_port   = local.ingress.value.port
      to_port     = local.index.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # ingress {
  #   protocol    = "tcp"
  #   from_port   = 22
  #   to_port     = 22
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws_security_group.bastion"
  }

  lifecycle {
    create_before_destroy = true
  }

}
