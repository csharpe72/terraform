output "ami" {
  value = data.aws_ami.ubuntu.image_id
}

output "bastion_ip" {
  value = aws_instance.bastion.public_ip
}

output "jenkins_master" {
  value = {
    for k, v in aws_instance.jenkins_master : k => v.id
  }
}

# output "public_subnets" {
#   value = module.vpc.public_subnets
# }