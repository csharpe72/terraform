#Create route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = var.cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "terraform-public-rtb"
    Tier = "public"
  }
}

#Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "terraform-igw"
  }
}

#Create public route table associations
resource "aws_route_table_association" "public" {
  depends_on = [
    aws_subnet.public_subnets
  ]
  route_table_id = aws_route_table.public.id
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
}


