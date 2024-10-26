resource "aws_instance" "webapp_instance" {
  count                       = length(var.aws_regions)
  ami                         = var.ami_id[count.index]
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.csye6225_public[count.index].id
  associate_public_ip_address = true
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.application_security_group[count.index].id]

  disable_api_termination = false

  user_data = <<-EOF
#!/bin/bash
####################################################
# Configure .env for webapp                       #
####################################################
touch /opt/webapp/.env
echo "DATABASE_URI=mysql+mysqlconnector://${var.db_username}:${var.db_password}@${aws_db_instance.csye6225_rds_instance[count.index].endpoint}/${var.db_name}" > /opt/webapp/.env

sudo chown csye6225:csye6225 /opt/webapp/.env
sudo chmod 600 /opt/webapp/.env
sudo systemctl restart webapp.service
  EOF

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
    from_port        = var.allow_ports[0]
    to_port          = var.allow_ports[0]
    protocol         = "tcp"
    cidr_blocks      = var.ipv4_cidr_blocks_allow_all
    ipv6_cidr_blocks = var.ipv6_cidr_blocks_allow_all
  }

  ingress {
    from_port        = var.allow_ports[1]
    to_port          = var.allow_ports[1]
    protocol         = "tcp"
    cidr_blocks      = var.ipv4_cidr_blocks_allow_all
    ipv6_cidr_blocks = var.ipv6_cidr_blocks_allow_all
  }

  ingress {
    from_port        = var.allow_ports[2]
    to_port          = var.allow_ports[2]
    protocol         = "tcp"
    cidr_blocks      = var.ipv4_cidr_blocks_allow_all
    ipv6_cidr_blocks = var.ipv6_cidr_blocks_allow_all
  }

  ingress {
    from_port        = var.allow_ports[3]
    to_port          = var.allow_ports[3]
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
