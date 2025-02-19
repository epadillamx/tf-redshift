variable "workgroup_name" {
  description = "Name for the Redshift Serverless workgroup"
  type        = string
  default     = "vol-workgroup"
}

variable "base_capacity" {
  description = "Base capacity for the Redshift Serverless workgroup"
  type        = number
  default     = 32
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