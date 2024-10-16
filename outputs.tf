output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.csye6225.id
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