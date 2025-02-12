

resource "aws_redshiftserverless_workgroup" "main" {
  workgroup_name      = var.workgroup_name
  namespace_name      = var.namespace_name
  base_capacity      = var.base_capacity
  
  subnet_ids = concat(
    var.public_subnets,
    var.private_subnets
  )
  
  security_group_ids  = [var.sg_redshift_id]
  publicly_accessible = true
}

resource "aws_secretsmanager_secret_version" "redshift_secret_connection" {
  secret_id = var.secret_arn
  secret_string = jsonencode({
    username = "admin"
    password = var.redshift_password
    endpoint = aws_redshiftserverless_workgroup.main.endpoint
    port     = aws_redshiftserverless_workgroup.main.port
    database = var.db_name
  })
}