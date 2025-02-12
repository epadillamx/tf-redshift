output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID of the VPC"
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "List of private subnet IDs"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "List of public subnet IDs"
}

output "sg_redshift_id" {
  value       = aws_security_group.redshift_sg.id
  description = "SG ID for Redshift"
}