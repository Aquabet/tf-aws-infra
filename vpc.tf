resource "aws_vpc" "csye6225" {
  cidr_block           = var.vpc_cidrs[0]
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "csye6225_vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.csye6225.id
  tags = {
    Name = "csye6225_gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.csye6225.id
  route {
    cidr_block = var.public_cidr_block
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.csye6225.id
  tags = {
    Name = "private-route-table"
  }
}

