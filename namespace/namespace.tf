resource "aws_redshiftserverless_namespace" "main" {
  namespace_name      = var.namespace_name
  db_name             = var.db_name
  admin_username      = var.admin_username_sm
  admin_user_password = var.admin_user_password_sm
  iam_roles           = [var.iam_roles_arn]
}
