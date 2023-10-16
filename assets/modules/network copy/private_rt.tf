/*** An elastic IP address to be used by the NAT Gateway defined below.  The NAT* gateway acts as a gateway between our private subnets and the public* internet, providing access out to the internet from within those subnets,* while denying access to them from the public internet.  This IP address* acts as the IP address from which all the outbound traffic from the private* subnets will originate.*/

resource "aws_eip" "eip_for_the_nat_gateway" {
  domain = "vpc"

  tags = {
    Name = "jenkins-tutoral-eip_for_the_nat_gateway"
  }
}

/*** A NAT Gateway that lives in our public subnet and provides an interface* between our private subnets and the public internet.  It allows traffic to* exit our private subnets, but prevents traffic from entering them.*/

resource "aws_nat_gateway" "nat_gateway" {
  for_each = toset(var.public_subnets)
  allocation_id = aws_eip.eip_for_the_nat_gateway.id
  # subnet_id     = element(var.public_subnets.*.id, 0)
  # subnet_id     = var.public_subnets.*.id 
  subnet_id = each.value


  tags = {
    Name = "main-nat_gateway"
  }
}

/*** A route from the private route table out to the internet through the NAT * Gateway.*/

resource "aws_route_table" "private_rt" {
  for_each = aws_nat_gateway.nat_gateway
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[each.key]
    # nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name   = "private_rt_${var.vpc_name}"
    Author = var.author
  }
}
/*** Associate the private route table with the private subnet.*/
resource "aws_route_table_association" "private" {
  for_each = aws_route_table.private_rt
  subnet_id = var.private_subnets
  route_table_id = aws_route_table.private_rt[each.key]
  # route_table_id = aws_route_table.private_rt.id
}

# resource "aws_route_table_association" "private" {
#   #count          = var.private_subnets_count
#   # subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
#   subnet_id      = aws_subnet.private_subnets.id
#   route_table_id = aws_route_table.private_rt.id
# }
