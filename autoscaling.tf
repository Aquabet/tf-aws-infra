resource "aws_launch_template" "csye6225_asg" {
  name          = "csye6225_asg"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  iam_instance_profile {
    name = aws_iam_instance_profile.webapp_ec2_instance_profile.name
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.webapp.id]
  }

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = var.root_volume_size
      volume_type           = var.volume_type
      delete_on_termination = true
      encrypted             = true
      kms_key_id            = aws_kms_key.ec2_key.arn
    }
  }
  user_data = base64encode(<<-EOF
#!/bin/bash
####################################################
# Configure .env for webapp                        #
####################################################
touch /opt/webapp/.env
echo "RDS_ENDPOINT=${aws_db_instance.csye6225_rds_instance.endpoint}
DB_NAME=${var.db_name}
DB_SECRETS_NAME=${aws_secretsmanager_secret.db_password_secret.name}
S3_BUCKET_NAME=${aws_s3_bucket.webapp_bucket.bucket}
S3_ENDPOINT_URL=https://s3.${var.aws_regions[0]}.amazonaws.com
AWS_REGION=${var.aws_regions[0]}
BASE_URL=https://${var.aws_profile}.${var.domain_name}
SNS_TOPIC_ARN=${aws_sns_topic.csye6225_signup_topic.arn}
" > /opt/webapp/.env

sudo chown csye6225:csye6225 /opt/webapp/.env
sudo chmod 600 /opt/webapp/.env
sudo systemctl restart webapp.service
  EOF
  )

  monitoring {
    enabled = true
  }
}

resource "aws_autoscaling_group" "webapp_asg" {
  launch_template {
    id      = aws_launch_template.csye6225_asg.id
    version = "$Latest"
  }
  name                = "webapp-asg"
  default_cooldown    = var.cooldown_time
  min_size            = var.asg_min_size
  max_size            = var.asg_max_size
  desired_capacity    = var.asg_desired_capacity
  vpc_zone_identifier = aws_subnet.csye6225_public[*].id

  tag {
    key                 = "Name"
    value               = "WebApp-ASG-Instance"
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up-policy"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = var.scaling_adjustment_scale_up
  cooldown               = var.cooldown_time
  autoscaling_group_name = aws_autoscaling_group.webapp_asg.name
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name          = "HighCPUUsage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.cloudwatch_alarm_period
  statistic           = "Average"
  threshold           = var.scale_up_threshold
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.webapp_asg.name
  }
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down-policy"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = var.scaling_adjustment_scale_down
  cooldown               = var.cooldown_time
  autoscaling_group_name = aws_autoscaling_group.webapp_asg.name
}

resource "aws_cloudwatch_metric_alarm" "low_cpu_alarm" {
  alarm_name          = "LowCPUUsage"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.cloudwatch_alarm_period
  statistic           = "Average"
  threshold           = var.scale_down_threshold
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.webapp_asg.name
  }
}
