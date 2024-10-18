resource "aws_vpc" "csye6225" {
  count                = length(var.aws_regions)
  cidr_block           = var.vpc_cidrs[count.index]
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "csye6225_vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  count  = length(var.aws_regions)
  vpc_id = aws_vpc.csye6225[count.index].id
  tags = {
    Name = "csye6225_gateway"
  }
}

resource "aws_route_table" "public_rt" {
  count  = length(var.aws_regions)
  vpc_id = aws_vpc.csye6225[count.index].id
  route {
    cidr_block = var.public_cidr_block
    gateway_id = aws_internet_gateway.gw[count.index].id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private_rt" {
  count  = length(var.aws_regions)
  vpc_id = aws_vpc.csye6225[count.index].id
  tags = {
    Name = "private-route-table"
  }
}

