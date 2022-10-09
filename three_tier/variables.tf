
variable "aws_region" {}
variable "aws_account_id" {}

#########################################################
#  variables relating to networkign 
#########################################################

variable "name" {}
variable "cidr" {}
variable "azs" {}
variable "private_subnets" {}
variable "public_subnets" {}
variable "database_subnets" {}
variable "enable_nat_gateway" {}
variable "access_ip" {}

#########################################################
#  variables relating to compute module 
#########################################################

variable "key_name" {}
variable "bastion_instance_count" {}
variable "instance_type" {}

#########################################################
#  variables relating to database module 
#########################################################




variable "dbuser" {}
variable "dbpassword" {}