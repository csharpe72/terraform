output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main_vpc.cidr_block
}

# output "public_subnets" {
#   value = aws_subnet.public_subnets.id
# }

output "public_subnets" {
  value = {
    for k, v in aws_subnet.public_subnets : k => v.id
  }
}

output "private_subnets" {
  value = {
    for k, v in aws_subnet.private_subnets : k => v.id
  }
}