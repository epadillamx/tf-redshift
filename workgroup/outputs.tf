output "redshift_endpoint" {
  value       = aws_redshiftserverless_workgroup.main.endpoint[0]
  sensitive   = false
  description = "Endpoint de conexión de Redshift Serverless"
}