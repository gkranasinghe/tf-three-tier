variable "db_storage" {}
variable "db_instance_class" {}
variable "db_name" {
  type = string
}
variable "dbuser" {
  type      = string
  sensitive = true
}
variable "dbpassword" {
  type      = string
  sensitive = true
}
variable "db_subnet_group_name" {}
variable "db_engine_version" {}
variable "db_identifier" {}
variable "skip_db_snapshot" {}
variable "rds_sg" {}