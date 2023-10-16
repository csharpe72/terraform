
#Create route table for private subnets 
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = var.public_subnet_cidr
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "terraform-private-rtb"
    Tier = "private"
  }
}

#Create EIP for NAT Gateway
resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"
  depends_on = [
    aws_internet_gateway.igw
  ]
  tags = {
    Name = "terraform-nat-gw-eip"
  }
}

#Create NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  depends_on = [
    aws_subnet.public_subnets
  ]
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnets["public-subnet-1"].id
  tags = {
    Name = "terraform-nat-gw"
  }
}


#Create private route table associations
resource "aws_route_table_association" "private" {
  depends_on = [
    aws_subnet.private_subnets
  ]
  route_table_id = aws_route_table.private.id
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id

  lifecycle {
    ignore_changes = [subnet_id, route_table_id]
  }
}
