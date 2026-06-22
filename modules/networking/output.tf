output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets_by_az" {
  value = local.public_subnet_by_az
}

output "private_subnets_by_az" {
  value = local.private_subnet_by_az
}

output "database_subnets_by_az" {
  value = local.database_subnet_by_az
}