variable "access_ip" {
  type    = string
}
variable "name" {
  type    = string
}
variable "public_subnets" {
  type        = list(string)
  default     = []
}
variable "private_subnets" {

  type        = list(string)
  default     = []
}
variable "private_subnet_suffix" {

  type        = string
  default     = "private"
}
variable "database_subnets" {

  type        = list(string)
  default     = []
}
variable "azs" {

  type        = list(string)
  default     = []
}
variable "cidr" {
  type        = string
  default     = "0.0.0.0/0"
}
variable "nat_gateway_destination_cidr_block" {
  type        = string
  default     = "0.0.0.0/0"
}
variable "enable_dns_hostnames" {
  type        = bool
  default     = false
}
variable "enable_dns_support" {
  type        = bool
  default     = true
}
variable "single_nat_gateway" {
  type        = bool
  default     = false
}
variable "one_nat_gateway_per_az" {
  type        = bool
  default     = false
}
variable "enable_nat_gateway" {
  type        = bool
  default     = false
}
variable "create_igw" {
  type        = bool
  default     = true
}
variable "create_database_subnet_group" {
  description = "Controls if database subnet group should be created (n.b. database_subnets must also be set)"
  type        = bool
  default     = true
}
variable "database_subnet_group_name" {
  description = "Name of database subnet group"
  type        = string
  default     = null
}
variable "database_subnet_suffix" {
  description = "Suffix to append to database subnets name"
  type        = string
  default     = "db"
}
variable "create_database_subnet_route_table" {
  description = "Controls if separate route table for database should be created"
  type        = bool
  default     = false
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}