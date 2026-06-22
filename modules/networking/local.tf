locals {

  public_subnet_by_az = {
    for k, v in aws_subnet.this :
    v.availability_zone => v.id
    if var.subnets[k].subnet_type == "public"
  }

  private_subnet_by_az = {
    for k, v in aws_subnet.this :
    v.availability_zone => v.id
    if var.subnets[k].subnet_type == "private"
  }

  database_subnet_by_az = {
    for k, v in aws_subnet.this :
    v.availability_zone => v.id
    if var.subnets[k].subnet_type == "database"
  }

  nat_gateway_subnets = (
    var.nat_gateway_strategy == "single"
    ?
    {
      nat1 = values(local.public_subnet_by_az)[0]
    }
    :
    local.public_subnet_by_az
  )

}