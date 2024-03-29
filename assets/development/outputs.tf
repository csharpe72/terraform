output "vpc_id" {
  value = module.vpc.vpc_id
}

output "bastion_ip" {
  value = module.ec2.bastion_ip
}

output "public_subnets" {
  value = module.vpc.public_subnets
}
output "private_subnets" {
  value = module.vpc.private_subnets
}

output "jenkins" {
  value = module.ec2.jenkins_master
}

 output "load_balancer_dns" { 
 	value = module.network.load_balancer_dns
 }