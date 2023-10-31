#Obtain availability zones
data "aws_availability_zones" "azs" {
  state = "available"

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}

#Create n public subnets
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, each.value + 100)
  availability_zone       = tolist(data.aws_availability_zones.azs.names)[each.value - 1]
  map_public_ip_on_launch = true


  tags = merge(
    var.tags,
    {
      Name = "${each.key}"
      Tier = "public"
    },
  )
}

#Create n private subnets
resource "aws_subnet" "private_subnets" {
  for_each                = var.private_subnets
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, each.value)
  availability_zone       = tolist(data.aws_availability_zones.azs.names)[each.value - 1]
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    {
      Name = "${each.key}"
      Tier = "private"
    },
  )
}
