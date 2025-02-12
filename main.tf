terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.aws_region
}

# VPC Module
module "network" {
  source = "./vpc"
}

# Secrets Module
module "secrets_manager" {
  source = "./security"
  depends_on = [module.network]
}

# Namespace Module
module "redshift_namespace" {
  source = "./namespace"
  depends_on = [module.secrets_manager]
}

# Workgroup Module
module "redshift_workgroup" {
  source = "./workgroup"
  vpc_id = module.network.vpc_id
  private_subnets = module.network.private_subnets
  public_subnets = module.network.public_subnets
  sg_redshift_id = module.network.sg_redshift_id
  namespace_name = module.redshift_namespace.namespace_name
  secret_arn = module.secrets_manager.secret_arn
  db_name = module.redshift_namespace.db_name
  redshift_password = module.secrets_manager.redshift_password
}