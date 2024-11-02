variable "vpc_cidrs" {
  description = "The CIDR block for the VPC"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "aws_profile" {
  type = string
}

variable "public_cidr_block" {
  description = "The CIDR block for the public route"
  type        = string
}

variable "ipv4_cidr_blocks_allow_all" {
  description = "The CIDR blocks for the IPv4 addresses"
  type        = list(string)
}

variable "ipv6_cidr_blocks_allow_all" {
  description = "The CIDR blocks for the IPv6 addresses"
  type        = list(string)
}

variable "aws_regions" {
  description = "The AWS regions to deploy resources"
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = list(string)
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "The key pair name for the EC2 instance"
  type        = string
}

variable "root_volume_size" {
  description = "The size of the root volume for the EC2 instance"
  type        = number
}

variable "volume_type" {
  description = "The type of the volume for the EC2 instance"
  type        = string
}

variable "allow_ports" {
  description = "The ports to allow"
  type        = list(number)
}

variable "db_username" {
  description = "The username for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string

}

variable "db_port" {
  description = "The port for the database"
  type        = number

}

variable "db_engine" {
  description = "The database engine"
  type        = string
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "domain_name" {
  description = "The root domain name for the project (e.g., example.com)"
  type        = string
}

variable "dev_zone_id" {
  description = "The Route 53 zone ID for the dev environment"
  type        = string
}

variable "demo_zone_id" {
  description = "The Route 53 zone ID for the demo environment"
  type        = string
}

variable "ttl" {
  description = "The time to live for the Route 53 record"
  type        = number
}

variable "encryption_algorithm" {
  description = "The encryption algorithm for the S3 bucket"
  type        = string
}

variable "record_type" {
  description = "The record type for the Route 53 record"
  type        = string
}

variable "root_account_id" {
  description = "The root account ID for the AWS account"
  type        = string
}

variable "sendgrid_api_key" {
  description = "The SendGrid API key for the email service"
  type        = string
}