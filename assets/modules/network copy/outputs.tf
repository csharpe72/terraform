output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main_vpc.cidr_block
}

# output "private_subnets" {

#   value = aws_subnet.private_subnets.id
# }

# output "public_subnets" {

#   value = aws_subnet.public_subnets.id
# }

# output "private_subnets" {
#   value = values(aws_subnet.private_subnet_cidr_blocks)[*].id
# }

# output "public_subnets" {
#   value = values(aws_subnet.public_subnet_cidr_blocks)[*].id
# }

output "private_subnets" {
  value = values(aws_subnet.private_subnets)[*].id
}

output "public_subnets" {
  value = values(aws_subnet.public_subnets)[*].id
}
