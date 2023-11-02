variable "environment" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "private_subnets" {
  
}

variable "bastion_security_groups" {
  
}

variable "web_security_groups" {
  
}

variable "tags" {
  type = map(any)
}