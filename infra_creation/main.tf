module "networking" {

  source = "../modules/networking"

  vpc_cidr             = var.vpc_cidr
  enable_nat_gateway   = var.enable_nat_gateway
  nat_gateway_strategy = var.nat_gateway_strategy

  subnets = var.subnets
}