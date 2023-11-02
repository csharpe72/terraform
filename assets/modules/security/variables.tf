
variable "vpc_id" {
type = string
}

variable "vpc_cidr_block" {

}

variable "bastion_port" {

}

variable "jenkins_ports" {

}

variable "tags" {
  type = map(any)
}