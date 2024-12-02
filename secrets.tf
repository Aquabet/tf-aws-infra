resource "aws_secretsmanager_secret" "db_password_secret" {
  name                    = "db_password"
  kms_key_id              = aws_kms_key.secrets_manager_key.arn
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "db_password_version" {
  secret_id = aws_secretsmanager_secret.db_password_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })
}

resource "aws_secretsmanager_secret" "email_service" {
  name                    = "email_service_credentials"
  kms_key_id              = aws_kms_key.secrets_manager_key.arn
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "email_service_version" {
  secret_id = aws_secretsmanager_secret.email_service.id
  secret_string = jsonencode({
    sendgrid_api_key = var.sendgrid_api_key
  })
}
