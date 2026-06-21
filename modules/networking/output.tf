output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets_by_az" {

  value = {
    for k, v in aws_subnet.this :
    var.subnets[k].az => v.id
    if var.subnets[k].subnet_type == "public"
  }
}

output "private_subnets_by_az" {

  value = {
    for k, v in aws_subnet.this :
    var.subnets[k].az => v.id
    if var.subnets[k].subnet_type == "private"
  }
}

output "database_subnets_by_az" {

  value = {
    for k, v in aws_subnet.this :
    var.subnets[k].az => v.id
    if var.subnets[k].subnet_type == "database"
  }
}