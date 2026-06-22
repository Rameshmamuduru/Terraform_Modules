module "networking" {

  source = "../modules/networking"

  vpc_cidr             = var.vpc_cidr
  enable_nat_gateway   = var.enable_nat_gateway
  nat_gateway_strategy = var.nat_gateway_strategy

  subnets = var.subnets
}

module "security_groups" {

  for_each = var.security_groups

  source = "../modules/security_groups"

  name = each.key

  description = each.value.description

  vpc_id = module.networking.vpc_id

  ingress_rules = each.value.ingress_rules

  egress_rules = each.value.egress_rules

}