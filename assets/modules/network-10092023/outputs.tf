output "vpc_id" { 
	value = aws_vpc.main_vpc.id 
} 

output "vpc_cidr_block" { 
	value = aws_vpc.main_vpc.cidr_block 
}  
# output "public_route_table" {
#   value = aws_route_table.public_rt[*]
# }
output "public_subnets" {
  value = {
    for k, public_subnets in aws_subnet.public_subnets : k => public_subnets.id
  }
}
output "private_subnets" {
  value = {
    for k, private_subnets in aws_subnet.private_subnets : k => private_subnets.id
  }
}
output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}

# output "bastion_sg_id" {
#   value = {
#     for k, v in aws_security_group.bastion : k => v.id
#     }
# }

output "jenkins_sg_id" {
  value = {
    for k, v in aws_security_group.jenkins : k => v.id
  }
}