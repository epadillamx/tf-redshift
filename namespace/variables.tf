variable "namespace_name" {
  description = "Name for the Redshift Serverless namespace"
  type        = string
  default     = "voi-analytics-redshift-namespace-infra-dev"
}

variable "db_name" {
  description = "Name for the Redshift database"
  type        = string
  default     = "voi_com_analytics_dev"
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