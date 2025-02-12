resource "random_password" "redshift_password" {
  length           = 16
  special          = true
  override_special = "!@#%&*"
}

resource "aws_secretsmanager_secret" "redshift_secret" {
  name = var.secret_name
}

resource "aws_secretsmanager_secret_version" "redshift_secret_version" {
  secret_id = aws_secretsmanager_secret.redshift_secret.id
  secret_string = jsonencode({
    username = "admin"
    password = random_password.redshift_password.result
  })
}