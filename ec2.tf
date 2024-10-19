resource "aws_instance" "webapp_instance" {
  count                       = length(var.aws_regions)
  ami                         = var.ami_id[count.index]
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.csye6225_public[0].id
  associate_public_ip_address = true
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.application_security_group[count.index].id]

  disable_api_termination = false
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.volume_type
    delete_on_termination = true
  }

  tags = {
    Name = "webapp_instance"
  }
}

resource "aws_security_group" "application_security_group" {
  count       = length(var.aws_regions)
  name        = "application_security_group"
  description = "Security group for web application"
  vpc_id      = aws_vpc.csye6225[count.index].id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.ipv4_cidr_blocks_allow_all
    ipv6_cidr_blocks = var.ipv6_cidr_blocks_allow_all
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = var.ipv4_cidr_blocks_allow_all
    ipv6_cidr_blocks = var.ipv6_cidr_blocks_allow_all
  }

  ingress {
    from_port        = 443
    to_port          = 443
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
    Name = "application_security_group"
  }
}
