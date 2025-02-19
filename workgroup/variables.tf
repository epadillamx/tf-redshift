variable "workgroup_name" {
  description = "Name for the Redshift Serverless workgroup"
  type        = string
  default     = "voi-analytics-redshift-workgroup-infra-dev"
}

variable "base_capacity" {
  description = "Base capacity for the Redshift Serverless workgroup"
  type        = number
  default     = 8
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "namespace_name" {
  description = "Name of the Redshift namespace"
  type        = string
}



variable "db_name" {
  description = "Name of the Redshift database"
  type        = string
}



variable "sg_redshift_id" {
  description = "SG ID for Redshift"
  type        = string
}

variable "secret_id" {
  description = "secret_id for Redshift"
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
