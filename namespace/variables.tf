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