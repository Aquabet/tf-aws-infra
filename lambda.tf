resource "aws_lambda_function" "lambda_function" {
  function_name = "email_verification_lambda"
  runtime       = var.lambda_runtime
  handler       = "handler.lambda_handler"
  role          = aws_iam_role.LambdaRole.arn

  filename = "./lambda.zip"

  environment {
    variables = {
      SENDGRID_API_KEY = var.sendgrid_api_key,
      DOMAIN           = var.domain_name,
      AWS_PROFILE      = var.aws_profile
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
