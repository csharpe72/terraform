
#Create 3 public subnets
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, each.value + 100)
  availability_zone       = tolist(data.aws_availability_zones.azs.names)[each.value - 1]
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-public-${each.key}"
    Tier = "public"
  }
}

#Create 3 private subnets
resource "aws_subnet" "private_subnets" {
  for_each                = var.private_subnets
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, each.value)
  availability_zone       = tolist(data.aws_availability_zones.azs.names)[each.value - 1]
  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-private-${each.key}"
    Tier = "private"
  }
}