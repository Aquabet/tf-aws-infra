resource "aws_iam_role" "WebappRole" {
  name = "WebappRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role" "LambdaRole" {
  name = "LambdaRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "cloudwatch_policy" {
  name        = "cloudwatch_policy"
  description = "Allows CloudWatch Agent to log and send metrics"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "cloudwatch:PutMetricData",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3_access_policy"
  description = "Allows EC2 instance to access S3 bucket for web application"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        "Resource" : [
          aws_s3_bucket.webapp_bucket.arn,
          "${aws_s3_bucket.webapp_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_execution_policy" {
  name = "lambda_execution_policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        "Resource" : "arn:aws:logs:*:*:*"
      },
      {
        "Effect" : "Allow",
        "Action" : "sns:Publish",
        "Resource" : aws_sns_topic.csye6225_signup_topic.arn
      }
    ]
  })
}

resource "aws_iam_policy" "sns_publish_policy" {
  name = "sns_publish_policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sns:Publish",
        "Resource" : aws_sns_topic.csye6225_signup_topic.arn
      }
    ]
  })
}
resource "aws_iam_policy" "kms_access_policy" {
  name = "kms_access_policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:CreateGrant",
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy" "secrets_manager_policy" {
  name = "secrets_manager_policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetSecretValue",
        ],
        "Resource" : "arn:aws:secretsmanager:*:*:secret:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy_attach" {
  role       = aws_iam_role.WebappRole.name
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
}
resource "aws_iam_role_policy_attachment" "s3_policy_attach" {
  role       = aws_iam_role.WebappRole.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "sns_publish_policy_policy_attach" {
  role       = aws_iam_role.WebappRole.name
  policy_arn = aws_iam_policy.sns_publish_policy.arn
}

resource "aws_iam_role_policy_attachment" "kms_policy_attach" {
  role       = aws_iam_role.WebappRole.name
  policy_arn = aws_iam_policy.kms_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "secrets_manager_policy_attach" {
  role       = aws_iam_role.WebappRole.name
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.LambdaRole.name
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_kms_policy_attach" {
  role       = aws_iam_role.LambdaRole.name
  policy_arn = aws_iam_policy.kms_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_secrets_manager_policy_attach" {
  role       = aws_iam_role.LambdaRole.name
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
}

resource "aws_iam_instance_profile" "webapp_ec2_instance_profile" {
  name = "WebAppEC2InstanceProfile"
  role = aws_iam_role.WebappRole.name
}
