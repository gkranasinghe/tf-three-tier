provider "aws" {
  region                   = local.aws_region
  profile                  = "terraform"
  shared_credentials_files = ["/home/gk/.aws/credentials"]

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/terraform"
  }

  # assume_role {
  #   role_arn = "arn:aws:iam::${lookup(var.aws_account_id, var.tag_environment)}:role/MYASSUMEROLE"
  # }
}

locals {
  instance_type = var.instance_type
  aws_region    = var.aws_region
  environment   = terraform.workspace
}

module "aws-instance" {
  source         = "../modules/ec2"
  aws_region       = local.aws_region
  instance_type  = local.instance_type
  instance_count = var.instance_count
}


module "vpc" {
  source         = "../modules/networking"
  name = var.name
  cidr = var.cidr
  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  access_ip=var.access_ip

  tags = {
    Terraform = "true"
    Environment = terraform.workspace
  }
}