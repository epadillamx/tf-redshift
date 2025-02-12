output "namespace_name" {
  value       = aws_redshiftserverless_namespace.main.namespace_name
  description = "Name of the Redshift Serverless namespace"
}

output "db_name" {
  value       = aws_redshiftserverless_namespace.main.db_name
  description = "Name of the Redshift database"
}