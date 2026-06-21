vpc_cidr = "10.0.0.0/16"

subnets = {
  public_subnet_1 = {

    public_subnet_cidr = "10.0.1.0/24"
    az = "us-east-1a"
    subnet_type = public
    
  }

  public_subnet_2 = {
    public_subnet_cidr = "10.0.2.0/24"
    az = "us-east-1b"
    subnet_type = public
    
  }

  private_subnet_1 = {

    public_subnet_cidr = "10.0.3.0/24"
    az = "us-east-1a"
    subnet_type = public
    
  }

  private_subnet_2 = {
    public_subnet_cidr = "10.0.4.0/24"
    az = "us-east-1b"
    subnet_type = public
    
  }

  database_subnet_1 = {

    public_subnet_cidr = "10.0.5.0/24"
    az = "us-east-1a"
    subnet_type = public
    
  }

  database_subnet_2 = {
    public_subnet_cidr = "10.0.6.0/24"
    az = "us-east-1b"
    subnet_type = public
    
  }
}

enable_nat_gateway  = true

nat_gateway_strategy = "single"
