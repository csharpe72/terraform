# resource "aws_subnet" "public_subnets" {
#   count                   = var.public_subnets_count
#   vpc_id                  = var.vpc_id
#   cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, 2 + count.index)
#   availability_zone       = element(var.availability_zones, count.index)
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "main-public-subnet"
#   }
# }

# resource "aws_subnet" "private_subnets" {
#   count                   = var.private_subnets_count
#   vpc_id                  = var.vpc_id
#   cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index)
#   availability_zone       = element(var.availability_zones, count.index)
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "main-private-subnet"
#   }
# }

# resource "aws_subnet" "public_subnets" {
#   vpc_id = var.vpc_id
#   cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 2)
#   availability_zone = var.availability_zones
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "main-public-subnet"
#   }
# }

# resource "aws_subnet" "private_subnets" {
#   vpc_id = var.vpc_id
#   cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 1)
#   availability_zone = var.availability_zones
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "main-private-subnet"
#   }
# }

resource "aws_subnet" "public_subnets" {
  for_each          = toset(var.public_subnet_cidr_blocks)
  vpc_id            = var.vpc_id
  cidr_block        = each.value
  # availability_zone = element(var.availability_zones, count.index)
  availability_zone = var.availability_zones
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnets" {
  for_each          = toset(var.private_subnet_cidr_blocks)
  vpc_id            = var.vpc_id
  cidr_block        = each.value
  # availability_zone = element(var.availability_zones, count.index)
  availability_zone = var.availability_zones
  map_public_ip_on_launch = false
}


