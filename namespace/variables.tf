variable "namespace_name" {
  description = "Name for the Redshift Serverless namespace"
  type        = string
  default     = "vol-redshift-namespace"
}

variable "db_name" {
  description = "Name for the Redshift database"
  type        = string
  default     = "voldb"
}

variable "iam_roles_arn" {
  description = "ARN ROLE for the Redshift"
  type        = string
}

variable "admin_username_sm" {
  description = "admin_username SM for the Redshift"
  type        = string
}

variable "admin_user_password_sm" {
  description = "admin_user_password SM for the Redshift"
  type        = string
}