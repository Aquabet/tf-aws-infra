# tf-aws-infra

This repository contains the Terraform configuration files for setting up AWS infrastructure, including VPC, subnets, internet gateway, route tables, RDS, security groups, auto-scaling, load balancer, AWS Lambda, SNS, KMS keys, and more. The infrastructure is designed to be scalable, secure, and highly available.

## CSYE-6225

- [Web Application](https://github.com/Aquabet/webapp)
- [Terraform-Infra](https://github.com/Aquabet/tf-aws-infra)
- [Serverless Lambda](https://github.com/Aquabet/serverless)

## Prerequisites

- aws >=5.70.0, <6.0.0
- Terraform >=v1.9.0

## Infrastructure Overview

The Terraform configuration will create the following AWS resources:

1. VPC: A Virtual Private Cloud (VPC) with a customizable CIDR block.
2. Public Subnets: 3 public subnets, each in a different availability zone.
3. Private Subnets: 3 private subnets, each in a different availability zone.
4. Internet Gateway: An internet gateway attached to the VPC for external internet access.
5. Route Tables: Public and private route tables, with the public route table allowing internet access via the internet gateway.
6. RDS Instance: A relational database instance in a private subnet, secured with a dedicated security group, and encrypted with a KMS key.
7. Application Load Balancer: Distributes incoming HTTPS traffic across multiple instances in an auto-scaling group.
8. Auto Scaling Group: Automatically scales the number of EC2 instances based on demand, ensuring high availability.
9. Security Groups: Security groups to control traffic for the load balancer, EC2 instances, and RDS instance.
10. SNS Topic: SNS topic to communicate with AWS Lambda for email verification.
11. AWS Lambda: A serverless function invoked by SNS to handle user email verification, with environment variables for configuration.
12. KMS: AWS Key Management Service (KMS) keys for encryption of sensitive data (e.g., RDS, S3, secrets).
13. Secrets Manager: AWS Secrets Manager to securely manage sensitive information such as database credentials and email service API keys.

## Setup Instructions

### Initialize Terraform

```bash
terraform init
```

### Set tfvars as varibles.tf

Set tfvars as varibles.tf

### Import SSL Certificate into AWS Certificate Manager

```bash
aws acm import-certificate \
  --certificate file://path_to_certificate_file.crt \
  --private-key file://path_to_private_key_file.key \
  --certificate-chain file://path_to_certificate_chain_file.crt \
  --region us-west-2
```

replace `path_to_certificate_file.crt`, `path_to_private_key_file.key`, and `path_to_certificate_chain_file.crt` with the appropriate file paths.

### Plan the Infrastructure

```bash
terraform plan
```

### Apply the Infrastructure Changes

```bash
terraform apply
```

### Infrastructure Details

- VPC: A VPC with a CIDR block defined in terraform.tfvars (e.g., 10.0.0.0/16).
- Public Subnets: Three public subnets, each in different availability zones (e.g., us-west-2a, us-west-2b, us-west-2c) allowing internet access.
- Private Subnets: Three private subnets, each in different availability zones, isolated from the internet.
- Internet Gateway: An internet gateway attached to the VPC for external internet access.
- RDS Instance: A relational database instance deployed in a private subnet, with security configurations to restrict public access, and encrypted using KMS keys.
- Application Load Balancer: An ALB that routes incoming HTTPS traffic to instances in the auto-scaling group.
- Auto Scaling Group: Automatically scales EC2 instances based on CPU usage policies to maintain desired performance and ensure high availability.
- Amazon SNS and Lambda: SNS for messaging and Lambda for user email verification as part of the user sign-up workflow. The Lambda function is triggered by SNS and sends a verification email.
- KMS Encryption: KMS keys for EC2, RDS, and S3 to provide data encryption and secure sensitive information.
- Secrets Manager: Used to securely manage sensitive data such as database credentials and SendGrid API keys.

### 7. Validate the Infrastructure

```bash
terraform fmt
terraform validate
```

### 8. destroy the Infrastructure (Optional)

```bash
terraform destroy
```
