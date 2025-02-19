output "secret_arn" {
  value       = aws_secretsmanager_secret.redshift_secret.arn
  description = "ARN of the Secrets Manager secret"
}

output "redshift_password" {
  value       = random_password.redshift_password.result
  sensitive   = true
  description = "Generated Redshift password"
}


output "iam_roles_arn" {
  value       = aws_iam_role.redshift_role.arn
  description = "Generated Redshift password"
}

output "admin_username_sm" {
  description = "admin_username SM for the Redshift"
  value       = jsondecode(aws_secretsmanager_secret_version.redshift_secret_version.secret_string)["username"]
}

output "admin_user_password_sm" {
  description = "admin_user_password SM for the Redshift"
  value       = jsondecode(aws_secretsmanager_secret_version.redshift_secret_version.secret_string)["password"]
}
