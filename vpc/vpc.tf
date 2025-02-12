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

resource "aws_security_group" "redshift_sg" {
  name        = "redshift-sg"
  description = "Security group for Redshift Serverless"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ⚠️ Adjust for production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}