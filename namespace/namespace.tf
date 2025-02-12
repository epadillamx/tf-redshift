resource "aws_redshiftserverless_namespace" "main" {
  namespace_name = var.namespace_name
  db_name       = var.db_name
}