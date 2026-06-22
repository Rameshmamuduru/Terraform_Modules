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