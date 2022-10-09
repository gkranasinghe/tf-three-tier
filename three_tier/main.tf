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
  aws_region      = var.aws_region
  environment   = terraform.workspace
}

module "aws-instance" {
  source         = "../modules/ec2"
  aws_region       = local.aws_region
  instance_type  = local.instance_type
  instance_count = 2
}