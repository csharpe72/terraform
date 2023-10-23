variable "environment" {
  
}

variable "instance_type" {
  
}

variable "key_name" {
  
}

variable "subnets" {
  type = list(string)
}

variable "private_subnets" {
  
}

# variable "public_subnets" {
#   type = list(string)
# }

variable "bastion_security_groups" {
  
}

variable "web_security_groups" {
  
}

# variable "security_groups" {
#   type = list(string)
#   default = []
# }