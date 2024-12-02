resource "aws_lambda_function" "lambda_function" {
  function_name = "email_verification_lambda"
  runtime       = var.lambda_runtime
  handler       = "handler.lambda_handler"
  role          = aws_iam_role.LambdaRole.arn

  filename = "./lambda.zip"
  layers = [
    "arn:aws:lambda:us-west-2:345057560386:layer:AWS-Parameters-and-Secrets-Lambda-Extension:12"
  ]

  environment {
    variables = {
      DOMAIN                                 = var.domain_name,
      SECRET_NAME                            = aws_secretsmanager_secret.email_service.name
      AWS_PROFILE_NAME                       = var.aws_profile
      PARAMETERS_SECRETS_EXTENSION_HTTP_PORT = 2773
    }
  }
}

resource "aws_lambda_permission" "allow_sns_invoke" {
  statement_id  = "AllowSNSInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.arn
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.csye6225_signup_topic.arn
}

resource "aws_sns_topic_subscription" "sns_to_lambda" {
  topic_arn = aws_sns_topic.csye6225_signup_topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.lambda_function.arn
}
