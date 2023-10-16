output "ami" {
  value = data.aws_ami.ubuntu.image_id
}

output "bastion_ip" {
  value = aws_instance.bastion.public_ip
}

# output "public_subnets" {
#   value = module.vpc.public_subnets
# }