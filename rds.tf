resource "aws_db_parameter_group" "csye6225_rds_parameter_group" {
  count       = length(var.aws_regions)
  name        = "csye6225-rds-pg-${count.index}"
  family      = "mysql8.0"
  description = "Custom parameter group for CSYE6225 RDS"

  tags = {
    Name = "csye6225_rds_pg_${count.index}"
  }
}

resource "aws_db_instance" "csye6225_rds_instance" {
  count                  = length(var.aws_regions)
  identifier             = "csye6225-${count.index}"
  engine                 = var.db_engine
  instance_class         = var.db_instance_class
  allocated_storage      = 20
  username               = var.db_username
  password               = var.db_password
  port                   = var.db_port
  db_subnet_group_name   = aws_db_subnet_group.csye6225_subnet_group[count.index].name
  vpc_security_group_ids = [aws_security_group.db_security_group[count.index].id]
  publicly_accessible    = false
  multi_az               = false
  db_name                = var.db_name
  parameter_group_name   = aws_db_parameter_group.csye6225_rds_parameter_group[count.index].name
  skip_final_snapshot    = true

  tags = {
    Name = "csye6225_rds_instance_${count.index}"
  }
}

resource "aws_db_subnet_group" "csye6225_subnet_group" {
  count = length(var.aws_regions)
  name  = "csye6225_rds_subnet_group_${count.index}"

  subnet_ids = [
    aws_subnet.csye6225_private[count.index * 3].id,
    aws_subnet.csye6225_private[count.index * 3 + 1].id,
    aws_subnet.csye6225_private[count.index * 3 + 2].id,
  ]

  tags = {
    Name = "csye6225_rds_subnet_group_${count.index}"
  }
}
