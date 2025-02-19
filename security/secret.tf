resource "random_password" "redshift_password" {
  length           = 16
  special          = true
  override_special = "!@#%&*"
}

resource "aws_secretsmanager_secret" "redshift_secret" {
  name = var.secret_name
  tags = {
    "Redshift" = "true"
  }
}

resource "aws_secretsmanager_secret_version" "redshift_secret_version" {
  secret_id = aws_secretsmanager_secret.redshift_secret.id
  secret_string = jsonencode({
    username = "admin"
    password = random_password.redshift_password.result
  })
}


resource "aws_iam_role" "redshift_role" {
  name = "voi-analytics-redshift-RedshiftServerlessRole-infra-dev"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "redshift.amazonaws.com"
        }
      }
    ]
  })
}


# IAM Policy para permitir acceso a Secrets Manager
resource "aws_iam_role_policy" "redshift_secret_policy" {
  name = "voi-analytics-redshift-RedshiftSecretsAccessPolicy-infra-dev"
  role = aws_iam_role.redshift_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = [aws_secretsmanager_secret.redshift_secret.arn]
      }
    ]
  })
}