output "bastion" {
  value = aws_instance.bastion.public_ip
}

output "public_subnets" {
  value = module.network-module.public_subnets.id
}