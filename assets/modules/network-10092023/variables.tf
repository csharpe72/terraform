variable "env" {
  description = "The environment (dev/qa/stage/prod)"
}


variable "vpc_id" {

}

variable "instance_tenancy" {
  
}

variable "cidr_block" {
  description = "The VPC's for the project"
  #type = list()
}

variable "public_subnets" {
  default = {
    "public-subnet-1" = 1
    "public-subnet-2" = 2
    "public-subnet-3" = 3
  }
}

variable "private_subnets" {
  default = {
    "private-subnet-1" = 1
    "private-subnet-2" = 2
    "private-subnet-3" = 3
  }
}

variable "cidr" {
  
}



# variable "public_subnets" {
#   description = "The public subnets for the vpc"
#   type = map(any)
# }
