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
      description     = "${ingress.key}-${ingress.value.port}"
      protocol        = ingress.value.protocol
      from_port       = ingress.value.port
      to_port         = ingress.value.port
      cidr_blocks     = ["${data.external.myipaddr.result.ip}/32"]
      security_groups = []
    }
  }
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "aws_security_group.bastion"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "web" {
  name        = "jenkins"
  description = "Inbound Rules for Jenkins"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = local.jenkins-sg
    content {
      description     = "${ingress.key}-${ingress.value.port}"
      protocol        = ingress.value.protocol
      from_port       = ingress.value.port
      to_port         = ingress.value.port
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = ingress.value.security_groups
    }
  }
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "aws_security_group.web"
    },
  )
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "lb" {
  name        = "alb-security-group"
  description = "Inbound Rules for Load Balancer"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = local.lb-sg
    content {
      description = "${ingress.key}-${ingress.value.port}"
      protocol    = ingress.value.protocol
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "aws_security_group.lb"
    },
  )
  lifecycle {
    create_before_destroy = true
  }
}
