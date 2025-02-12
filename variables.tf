variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# Puedes agregar más variables según necesites
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "vol"
}