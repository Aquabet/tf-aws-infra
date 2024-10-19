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