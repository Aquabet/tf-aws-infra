provider "aws" {
  profile = var.aws_profile
  region = var.aws_regions[0]
}