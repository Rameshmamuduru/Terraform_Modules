module "networking" {
  source = "../modules/networking"

  vpc_cidr = var.vpc_cidr
  nat_type = "single"

  azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

}

module "security_groups" {
  source = "../modules/security_groups"

  vpc_id = module.networking.vpc_id

  name = var.security_group_name
  description = var.security_group_description
    ingress_rules = var.security_group_ingress_rules
    egress_rules = var.security_group_egress_rules
 
}

resource "aws_security_group_rule" "web_sg_ingress_from_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.security_groups[web_sg].security_group_id
  source_security_group_id = module.security_groups[external_alb].security_group_id

  description = "Allow HTTP traffic from the external ALB security group"
  
}