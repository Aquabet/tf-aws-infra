resource "aws_db_parameter_group" "csye6225_rds_parameter_group" {
  name        = "csye6225-rds-pg"
  family      = "mysql8.0"
  description = "Custom parameter group for CSYE6225 RDS"

  tags = {
    Name = "csye6225_rds_pg"
  }
}

resource "aws_db_instance" "csye6225_rds_instance" {
  identifier             = "csye6225-rds-instance"
  engine                 = var.db_engine
  instance_class         = var.db_instance_class
  allocated_storage      = 20
  username               = var.db_username
  password               = var.db_password
  port                   = var.db_port
  db_subnet_group_name   = aws_db_subnet_group.csye6225_subnet_group.name
  vpc_security_group_ids = [aws_security_group.database.id]
  publicly_accessible    = false
  multi_az               = false
  db_name                = var.db_name
  parameter_group_name   = aws_db_parameter_group.csye6225_rds_parameter_group.name
  skip_final_snapshot    = true

  tags = {
    Name = "csye6225_rds_instance"
  }
}

resource "aws_db_subnet_group" "csye6225_subnet_group" {
  name = "csye6225_rds_subnet_group"

  subnet_ids = [
    aws_subnet.csye6225_private[0].id,
    aws_subnet.csye6225_private[1].id,
    aws_subnet.csye6225_private[2].id,
  ]

  tags = {
    Name = "csye6225_rds_subnet_group"
  }
}
