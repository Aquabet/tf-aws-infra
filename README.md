# tf-aws-infra

This repository contains the Terraform configuration files for setting up AWS infrastructure, including VPC, subnets, internet gateway, route tables, and more. The infrastructure is set up to include three public subnets and three private subnets, each in different availability zones.

## Prerequisites

- aws >=5.70.0, <6.0.0
- Terraform >=v1.9.0
AWS account with proper permissions to create VPC, subnets, internet gateway, and route tables

## Infrastructure Overview

The Terraform configuration will create the following AWS resources:

1. VPC: A Virtual Private Cloud (VPC) with a customizable CIDR block.
2. Public Subnets: 3 public subnets, each in a different availability zone.
3. Private Subnets: 3 private subnets, each in a different availability zone.
4. Internet Gateway: An internet gateway attached to the VPC for external internet access.
5. Route Tables: Public and private route tables, with the public route table allowing internet access via the internet gateway.

## Setup Instructions

### 1. Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/your-username/tf-aws-infra.git
cd tf-aws-infra
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Configure Variables

Modify the terraform.tfvars file to define your VPC CIDR block, public and private subnets CIDR blocks, and the AWS CLI profile you wish to use (e.g., dev or demo).

```bash
# Example (terraform.tfvars)
vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24",
  "10.0.3.0/24"
]

private_subnet_cidrs = [
  "10.0.4.0/24",
  "10.0.5.0/24",
  "10.0.6.0/24"
]

aws_profile = "dev"  # or "demo"
```

### 4. Plan the Infrastructure

```bash
terraform plan
```

### 5. Apply the Infrastructure Changes

```bash
terraform apply
```

### 6. Infrastructure Details

- VPC: A VPC with CIDR block defined in terraform.tfvars (e.g., 10.0.0.0/16).
- Public Subnets: Three public subnets, each in different availability zones (us-west-2a, us-west-2b, us-west-2c), allowing internet access.
- Private Subnets: Three private subnets, each in different availability zones, isolated from the internet.
- Internet Gateway: An internet gateway attached to the VPC for external internet access.
- Public Route Table: Routes traffic from public subnets to the internet via the internet gateway.
- Private Route Table: Routes internal traffic within private subnets (no internet access).

### 7. Validate the Infrastructure

```bash
terraform fmt
terraform validate
```

### 8. destroy the Infrastructure (Optional)

```bash
terraform destroy
```
