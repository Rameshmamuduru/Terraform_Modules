module "networking" {

  source = "../modules/networking"

  vpc_cidr = var.vpc_cidr

  subnets = var.subnets
  enable_nat_gateway = var.enable_nat_gateway


  
}