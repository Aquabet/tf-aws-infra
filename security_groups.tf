resource "aws_security_group" "webapp" {
  name        = "webapp"
  description = "Security group for webapp"
  vpc_id      = aws_vpc.csye6225.id

  ingress {
    description = "Allow SSH traffic"
    from_port   = var.allow_ports[0]
    to_port     = var.allow_ports[0]
    protocol    = "tcp"
    cidr_blocks = var.ipv4_cidr_blocks_allow_all
  }

  ingress {
    description     = "Allow webapp port 5000"
    from_port       = var.allow_ports[3]
    to_port         = var.allow_ports[3]
    protocol        = "tcp"
    security_groups = [aws_security_group.load_balancer.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.ipv4_cidr_blocks_allow_all
    ipv6_cidr_blocks = var.ipv6_cidr_blocks_allow_all
  }

  tags = {
    Name = "webapp"
  }
}

resource "aws_security_group" "database" {
  vpc_id = aws_vpc.csye6225.id
  name   = "database"

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.webapp.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.webapp.id]
  }

  tags = {
    Name = "database"
  }
}

resource "aws_security_group" "load_balancer" {
  name        = "load_balancer"
  description = "Security group for load balancer to access web app"
  vpc_id      = aws_vpc.csye6225.id

  ingress {
    description      = "Allow HTTPS traffic"
    from_port        = var.allow_ports[2]
    to_port          = var.allow_ports[2]
    protocol         = "tcp"
    cidr_blocks      = var.ipv4_cidr_blocks_allow_all
    ipv6_cidr_blocks = var.ipv6_cidr_blocks_allow_all
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.ipv4_cidr_blocks_allow_all
    ipv6_cidr_blocks = var.ipv6_cidr_blocks_allow_all
  }
  tags = {
    Name = "load_balancer"
  }
}
