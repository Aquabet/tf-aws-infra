resource "aws_subnet" "csye6225_public" {
  count                   = 3
  vpc_id                  = aws_vpc.csye6225.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "public_subnet_${count.index + 1}"
  }
}

resource "aws_subnet" "csye6225_private" {
  count             = 3
  vpc_id            = aws_vpc.csye6225.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "private_subnet_${count.index + 1}"
  }
}

resource "aws_route_table_association" "csye6225_public_assoc" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.csye6225_public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "csye6225_private_assoc" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.csye6225_private[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
