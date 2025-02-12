output "redshift_endpoint" {
  value       = module.redshift_workgroup.redshift_endpoint
  description = "Redshift Serverless connection endpoint"
}

output "vpc_id" {
  value       = module.network.vpc_id
  description = "ID of the VPC"
}

output "namespace_name" {
  value       = module.redshift_namespace.namespace_name
  description = "Name of the Redshift Serverless namespace"
}