variable "bastion_ingress_rules" {
  type = map(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = list(string)
  }))
  default = {
    allow_ssh = {
      description     = "Allow SSH from trusted IPs"
      from_port       = 22,
      to_port         = 22,
      protocol        = "TCP",
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = null,
  } }
}

variable "jenkins_ingress_rules" {
  type = map(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = list(string)
  }))
  default = {
    allow_ssh = {
      description     = "Allow SSH from bastion on the private subnet"
      from_port       = 22,
      to_port         = 22,
      protocol        = "TCP",
      cidr_blocks     = ["172.0.0.0/16"]
      security_groups = null
    },
    allow_web1 = {
      description     = "Allow Web Traffic from Load Balancer"
      from_port       = 8080,
      to_port         = 8080,
      protocol        = "TCP",
      cidr_blocks     = ["0.0.0.0/0"] #Placeholder until the LB is configured
      security_groups = null
    },
    allow_web2 = {
      description     = "Allow Web Traffic from Everywhere"
      from_port       = 8080,
      to_port         = 8080,
      protocol        = "TCP",
      cidr_blocks     = ["0.0.0.0/0"],
      security_groups = null
    }
  }
}
