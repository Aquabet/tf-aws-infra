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

variable "aws_regions" {
  description = "The AWS regions to deploy resources"
  type        = list(string)
}