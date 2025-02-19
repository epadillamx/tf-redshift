

resource "aws_redshiftserverless_workgroup" "main" {
  workgroup_name = var.workgroup_name
  namespace_name = var.namespace_name
  base_capacity  = var.base_capacity

  subnet_ids = concat(
    var.public_subnets,
    var.private_subnets
  )

  security_group_ids  = [var.sg_redshift_id]
  publicly_accessible = true
}


resource "aws_secretsmanager_secret_version" "redshift_secret_version_final" {
  secret_id = var.secret_id
  secret_string = jsonencode({
    username = var.admin_username_sm
    password = var.admin_user_password_sm
    engine   = "redshift"
    host     = aws_redshiftserverless_workgroup.main.endpoint[0]
    port     = 5439
    dbname   = var.db_name
  })
}
