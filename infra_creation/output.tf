output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnets" {
  value = module.networking.public_subnets_by_az
}

output "private_subnets" {
  value = module.networking.private_subnets_by_az
}

output "database_subnets" {
  value = module.networking.database_subnets_by_az
}