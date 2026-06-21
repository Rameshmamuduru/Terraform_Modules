## vpc resouce block

resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "main-vpc"
    }
  
}

## subnet resource block

resource "aws_subnet" "this" {
    for_each = var.subnets

    vpc_id = aws_vpc.this.id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.az

    map_public_ip_on_launch = (
        each.value.subnet_type == "public"
    )
     
}


## Internet gate way and NAT gate way

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id
  
}

locals {
  public_subnet_ids = [
    for key, subnet in aws_subnet.this :
    subnet.id if subnet.map_public_ip_on_launch == true
  ]

nat_gateway_subnets = (
  var.nat_gateway_strategy == "single" ?
  {
      nat1 = local.public_subnet_ids[0]
  } :
  {
      for idx, subnet_id in local.public_subnet_ids :
      "nat${idx + 1}" => subnet_id
  }
)
}

resource "aws_eip" "nat" {
    for_each = (
        var.enable_nat_gateway ? local.nat_gateway_subnets : {}
    )

    domain = "vpc"
  
}

resource "aws_nat_gateway" "this" {
    for_each =(
        var.enable_nat_gateway ? local.nat_gateway_subnets : {}
    ) 

    allocation_id = aws_eip.nat[each.key].subnet_id
    subnet_id = each.value

    depends_on = [
    aws_internet_gateway.this
  ]
  
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "public_internet" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
    for_each = {
        for k, v in aws_subnet.this :
        k => v
        if var.subnets[k].subnet_type == "public"
    }

    subnet_id = each.value.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  for_each = local.public_subnet_by_az

  vpc_id = aws_vpc.this.id

}

resource "aws_route" "private_route" {
  for_each = local.private_subnet_by_az
  route_table_id = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.this[each.key].id
}

resource "aws_route_table_association" "private" {
  for_each = local.private_subnet_by_az
  subnet_id = each.value
  route_table_id = aws_route_table.private[each.key].id
}