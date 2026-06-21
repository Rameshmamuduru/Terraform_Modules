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
    var.nat_gateway_startagy == "single" ?
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