
output "vpc_id" {
  value = aws_vpc.this.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.database.*.name
}

output "rds_db_subnet_group" {
  value = aws_db_subnet_group.database.*.id
}
output "private_subnets_db" {
  value = aws_subnet.database.*.id
}
output "rds_sg" {
  value = aws_security_group.three_tier_rds_sg.id
}

output "frontend_app_sg" {
  value = aws_security_group.three_tier_frontend_app_sg.id
}

output "backend_app_sg" {
  value = aws_security_group.three_tier_backend_app_sg.id
}

output "bastion_sg" {
  value = aws_security_group.three_tier_bastion_sg.id
}

output "lb_sg" {
  value = aws_security_group.three_tier_lb_sg.id
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}

