# Obtain User Local Public IP
data "external" "myipaddr" {
  program = ["bash", "-c", "curl -s 'https://ipinfo.io/json'"]
}

resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Inbound Rules for Bastion"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = local.bastion-sg
    content {
      description = "description ${ingress.key}-${ingress.value.port}"
      protocol    = ingress.value.protocol
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      cidr_blocks = ["${data.external.myipaddr.result.ip}/32"]
    }
  }
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws_security_group.bastion"
  }
}

resource "aws_security_group" "web" {
  name        = "jenkins"
  description = "Inbound Rules for Web"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = local.jenkins-sg
    content {
      description     = ingress.key
      protocol        = ingress.value.protocol
      from_port       = ingress.value.port
      to_port         = ingress.value.port
      security_groups = [aws_security_group.bastion.id]
    }
  }
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws_security_group.web"
  }
}
