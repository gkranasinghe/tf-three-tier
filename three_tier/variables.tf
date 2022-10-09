variable "instance_count" {
    type = number
}

variable "aws_region" {
  type    = string
}

variable "instance_type" {
  type    = string
}

variable "aws_account_id" {
  type    = string
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}
