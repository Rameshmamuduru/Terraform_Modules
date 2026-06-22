vpc_cidr = "10.0.0.0/16"

enable_nat_gateway = true

nat_gateway_strategy = "single"

subnets = {

  public_a = {
    cidr_block = "10.0.1.0/24"
    az          = "us-east-1a"
    subnet_type = "public"
  }

  public_b = {
    cidr_block = "10.0.2.0/24"
    az          = "us-east-1b"
    subnet_type = "public"
  }

  private_a = {
    cidr_block = "10.0.11.0/24"
    az          = "us-east-1a"
    subnet_type = "private"
  }

  private_b = {
    cidr_block = "10.0.12.0/24"
    az          = "us-east-1b"
    subnet_type = "private"
  }

  database_a = {
    cidr_block = "10.0.21.0/24"
    az          = "us-east-1a"
    subnet_type = "database"
  }

  database_b = {
    cidr_block = "10.0.22.0/24"
    az          = "us-east-1b"
    subnet_type = "database"
  }

}

name = "test"
description = "description"

security_groups = {

  alb-sg = {

    description = "External Load Balancer"

    ingress_rules = {
      http = {

        description = "Allow HTTP from Internet"

        from_port = 80
        to_port   = 80

        protocol = "tcp"

        cidr_blocks = [
          "0.0.0.0/0"
        ]
      }

      https = {

        description = "Allow HTTPS from Internet"

        from_port = 443
        to_port   = 443

        protocol = "tcp"

        cidr_blocks = [
          "0.0.0.0/0"
        ]
      }

      egress_rules = {

      backend = {

        description = "Traffic to Backend"

        from_port = 8080
        to_port   = 8080

        protocol = "tcp"

        cidr_blocks = [
          "10.0.0.0/16"
        ]
      }
    }
  }

  }

}