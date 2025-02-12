terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  region = "us-east-1"
}

# 1️⃣ Crear la VPC con 3 Zonas de Disponibilidad (AZs)
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "vol-vpc"
  cidr = "192.168.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  public_subnets  = ["192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# 2️⃣ Crear un grupo de seguridad para Redshift Serverless
resource "aws_security_group" "redshift_sg" {
  name        = "redshift-sg"
  description = "Grupo de seguridad para Redshift Serverless"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ⚠️ Ajustar para producción (evitar acceso público)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3️⃣ Generar una contraseña segura
resource "random_password" "redshift_password" {
  length           = 16
  special         = true
  override_special = "!@#%&*"
}

# 4️⃣ Guardar credenciales en AWS Secrets Manager
resource "aws_secretsmanager_secret" "redshift_secret" {
  name = "redshift-secret-vol-02"
}

resource "aws_secretsmanager_secret_version" "redshift_secret_version" {
  secret_id     = aws_secretsmanager_secret.redshift_secret.id
  secret_string = jsonencode({
    username = "admin"
    password = random_password.redshift_password.result
  })
}

# 5️⃣ Crear el namespace de Redshift Serverless
resource "aws_redshiftserverless_namespace" "main" {
  namespace_name = "vol-redshift-namespace"
  db_name        = "voldb"
}

# 6️⃣ Crear el Workgroup de Redshift con subredes privadas y públicas (3 AZs)
resource "aws_redshiftserverless_workgroup" "main" {
  workgroup_name = "vol-workgroup"
  namespace_name = aws_redshiftserverless_namespace.main.namespace_name
  base_capacity  = 32

  subnet_ids = concat(
    module.vpc.public_subnets,
    module.vpc.private_subnets
  )

  security_group_ids = [aws_security_group.redshift_sg.id]
  publicly_accessible = true
}

# 7️⃣ Guardar la URL de conexión en Secrets Manager
resource "aws_secretsmanager_secret_version" "redshift_secret_connection" {
  secret_id     = aws_secretsmanager_secret.redshift_secret.id
  secret_string = jsonencode({
    username = "admin"
    password = random_password.redshift_password.result
    endpoint = aws_redshiftserverless_workgroup.main.endpoint
    port     = aws_redshiftserverless_workgroup.main.port
    database = aws_redshiftserverless_namespace.main.db_name
  })
}


output "redshift_endpoint" {
  value     = aws_redshiftserverless_workgroup.main.endpoint[0]
  sensitive = false
  description = "Endpoint de conexión de Redshift Serverless"
}





