resource "aws_subnet" "csye6225_public" {
  count                   = 3 * length(var.aws_regions)
  vpc_id                  = aws_vpc.csye6225[floor(count.index / 3)].id
  cidr_block              = var.public_subnet_cidrs[count.index % 3]
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index % 3)
  tags = {
    Name = "public_subnet_${count.index}"
  }
}

resource "aws_subnet" "csye6225_private" {
  count             = 3 * length(var.aws_regions)
  vpc_id            = aws_vpc.csye6225[floor(count.index / 3)].id
  cidr_block        = var.private_subnet_cidrs[count.index % 3]
  availability_zone = element(data.aws_availability_zones.available.names, count.index % 3)
  tags = {
    Name = "private_subnet_${count.index}"
  }
}

resource "aws_route_table_association" "csye6225_public_assoc" {
  count          = 3 * length(var.aws_regions)
  subnet_id      = aws_subnet.csye6225_public[count.index].id
  route_table_id = aws_route_table.public_rt[floor(count.index / 3)].id
}

resource "aws_route_table_association" "csye6225_private_assoc" {
  count          = 3 * length(var.aws_regions)
  subnet_id      = aws_subnet.csye6225_private[count.index].id
  route_table_id = aws_route_table.private_rt[floor(count.index / 3)].id
}