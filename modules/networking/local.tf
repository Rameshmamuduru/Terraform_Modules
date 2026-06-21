locals {

  public_subnet_by_az = {
    for k, v in aws_subnet.this :
    var.subnets[k].az => v.id
    if var.subnets[k].subnet_type == "public"
  }

}

locals {

  private_subnet_by_az = {
    for k, v in aws_subnet.this :
    var.subnets[k].az => v.id
    if var.subnets[k].subnet_type == "private"
  }

}

locals {

  database_subnet_by_az = {
    for k, v in aws_subnet.this :
    var.subnets[k].az => v.id
    if var.subnets[k].subnet_type == "database"
  }

}