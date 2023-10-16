# resource "aws_security_group" "jenkins" {
#   vpc_id = var.vpc_id
#   name     = "jenkins-security-group"

#   dynamic "ingress" {
#     for_each = var.jenkins_ingress_rules
#     content {
#       description     = each.value["description"]
#       from_port       = each.value["from_port"]
#       to_port         = each.value["to_port"]
#       protocol        = each.value["protocol"]
#       security_groups = each.value["security_groups"]
#     }
#   }
resource "aws_security_group" "jenkins" {

  for_each    = var.jenkins_ingress_rules
  name        = each.key
  description = each.value.description
  vpc_id      = var.vpc_id

  ingress {
    description     = each.value.description
    from_port       = each.value.from_port
    to_port         = each.value.to_port
    protocol        = each.value.protocol
    security_groups = each.value.security_groups
  }
  
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws_security_group.jenkins"
  }
}
