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

# output "webapp_instance_public_ip" {
#   description = "Public IP of the WebApp instance"
#   value       = aws_instance.webapp_instance[*].public_ip
# }

# output "webapp_instance_id" {
#   description = "ID of the WebApp instance"
#   value       = aws_instance.webapp_instance[*].id
# }

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.csye6225_asg[*].id
}

output "db_instance_endpoint" {
  description = "The RDS instance endpoint"
  value       = aws_db_instance.csye6225_rds_instance[*].endpoint
}

output "sns_topic_arn" {
  description = "The ARN of the SNS topic"
  value       = aws_sns_topic.csye6225_signup_topic.arn
}

output "lambda_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.lambda_function.arn
}