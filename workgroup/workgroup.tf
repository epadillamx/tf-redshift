

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

