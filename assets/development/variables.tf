variable "aws_region" {
  type = string
}
variable "environment" {
  type = string
}

variable "project" {
  type = string
}

variable "managed_by" {
  type = string
}
variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}
variable "public_subnet_cidr" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}
