output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.csye6225[*].id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.csye6225_public[*].id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.csye6225_private[*].id
}

output "az" {
  value = data.aws_availability_zones.available.names
}

output "webapp_instance_public_ip" {
  description = "Public IP of the WebApp instance"
  value       = aws_instance.webapp_instance[*].public_ip
}

output "webapp_instance_id" {
  description = "ID of the WebApp instance"
  value       = aws_instance.webapp_instance[*].id
}
output "db_instance_endpoint" {
  description = "The RDS instance endpoint"
  value       = aws_db_instance.csye6225_rds_instance[*].endpoint
}
