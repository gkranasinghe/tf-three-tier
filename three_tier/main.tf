provider "aws" {
  region                   = var.aws_region
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
  environment = terraform.workspace
}

# creating new keypair in EC2

resource "tls_private_key" "three_tier_private_key" {
  algorithm = "RSA"
}
resource "local_file" "three_tier_key" {
  content  = tls_private_key.three_tier_private_key.private_key_pem
  filename = "${var.key_name}.pem"
}
resource "aws_key_pair" "three_tier_aws_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.three_tier_private_key.public_key_openssh
}

module "compute" {
  source                 = "../modules/compute"
  name                   = var.name
  frontend_app_sg        = module.vpc.frontend_app_sg
  backend_app_sg         = module.vpc.backend_app_sg
  bastion_sg             = module.vpc.backend_app_sg
  private_subnets        = module.vpc.private_subnets
  public_subnets         = module.vpc.public_subnets
  bastion_instance_count = var.bastion_instance_count
  key_name               = aws_key_pair.three_tier_aws_key_pair.key_name
  instance_type          = var.instance_type
  lb_tg_name             = module.loadbalancing.lb_tg_name
  lb_tg                  = module.loadbalancing.lb_tg

}

module "vpc" {
  source             = "../modules/networking"
  name               = var.name
  cidr               = var.cidr
  azs                = var.azs
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  database_subnets   = var.database_subnets
  enable_nat_gateway = var.enable_nat_gateway
  access_ip          = var.access_ip

  tags = {
    Terraform   = "true"
    Environment = terraform.workspace
  }
}

module "loadbalancing" {
  source            = "../modules/loadbalancer"
  lb_sg             = module.vpc.lb_sg
  public_subnets    = module.vpc.public_subnets
  tg_port           = 80
  tg_protocol       = "HTTP"
  vpc_id            = module.vpc.vpc_id
  app_asg           = module.compute.app_asg
  listener_port     = 80
  listener_protocol = "HTTP"
  azs               = 2
}

module "database" {
  source               = "../modules/database"
  db_storage           = 10
  db_engine_version    = "5.7.39"
  db_instance_class    = "db.t2.micro"
  db_name              = "${var.name}db${terraform.workspace}"
  dbuser               = var.dbuser
  dbpassword           = var.dbpassword
  db_identifier        = "${var.name}db${terraform.workspace}"
  skip_db_snapshot     = true
  rds_sg               = module.vpc.rds_sg
  db_subnet_group_name = module.vpc.db_subnet_group_name[0]
}