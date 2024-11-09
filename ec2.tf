# resource "aws_instance" "webapp_instance" {
#   ami                         = var.ami_id
#   instance_type               = var.instance_type
#   subnet_id                   = aws_subnet.csye6225_public[0].id
#   associate_public_ip_address = true
#   key_name                    = var.key_name
#   vpc_security_group_ids      = [aws_security_group.webapp.id]
#   iam_instance_profile        = aws_iam_instance_profile.cloudwatch_s3_instance_profile.name
#   disable_api_termination     = false

#   user_data = <<-EOF
# #!/bin/bash
# ####################################################
# # Configure .env for webapp                       #
# ####################################################
# touch /opt/webapp/.env
# echo "DATABASE_URI=mysql+mysqlconnector://${var.db_username}:${var.db_password}@${aws_db_instance.csye6225_rds_instance.endpoint}/${var.db_name}
# S3_BUCKET_NAME=${aws_s3_bucket.webapp_bucket.bucket}
# S3_ENDPOINT_URL=https://s3.${var.aws_regions[0]}.amazonaws.com
# AWS_REGION=${var.aws_regions[0]}
# SENDGRID_API_KEY=${var.sendgrid_api_key}
# " > /opt/webapp/.env

# sudo chown csye6225:csye6225 /opt/webapp/.env
# sudo chmod 600 /opt/webapp/.env
# sudo systemctl restart webapp.service
#   EOF

#   root_block_device {
#     volume_size           = var.root_volume_size
#     volume_type           = var.volume_type
#     delete_on_termination = true
#   }

#   tags = {
#     Name = "webapp_instance"
#   }
# }

