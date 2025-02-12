output "secret_arn" {
  value       = aws_secretsmanager_secret.redshift_secret.arn
  description = "ARN of the Secrets Manager secret"
}

output "redshift_password" {
  value       = random_password.redshift_password.result
  sensitive   = true
  description = "Generated Redshift password"
}