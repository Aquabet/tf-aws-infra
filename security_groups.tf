resource "aws_security_group" "db_security_group" {
  count  = length(var.aws_regions)
  vpc_id = aws_vpc.csye6225[count.index].id
  name   = "csye6225_database_security_group_${count.index}"

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.application_security_group[count.index].id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.application_security_group[count.index].id]
  }

  tags = {
    Name = "csye6225_database_security_group_${count.index}"
  }
}
