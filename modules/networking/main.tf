# VPC

resource "aws_vpc" "this" {

  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

# Subnets

resource "aws_subnet" "this" {

  for_each = var.subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  map_public_ip_on_launch = (
    each.value.subnet_type == "public"
  )

  tags = {
    Name = each.key
  }
}

# Internet Gate Way

resource "aws_internet_gateway" "this" {

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "main-igw"
  }
}

# Elastic IP

resource "aws_eip" "nat" {

  for_each = (
    var.enable_nat_gateway
    ? local.nat_gateway_subnets
    : {}
  )

  domain = "vpc"

  tags = {
    Name = each.key
  }
}

# NAT gateway

resource "aws_nat_gateway" "this" {

  for_each = (
    var.enable_nat_gateway
    ? local.nat_gateway_subnets
    : {}
  )

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value

  depends_on = [
    aws_internet_gateway.this
  ]

  tags = {
    Name = each.key
  }
}

# public route table

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route" "public_internet" {

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {

  for_each = {
    for k, v in aws_subnet.this :
    k => v
    if var.subnets[k].subnet_type == "public"
  }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}


# Private Route Tables

resource "aws_route_table" "private" {

  for_each = local.private_subnet_by_az

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "private-${each.key}"
  }
}

resource "aws_route" "private_route" {

  for_each = local.private_subnet_by_az

  route_table_id = aws_route_table.private[each.key].id

  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = (
    var.nat_gateway_strategy == "single"
    ?
    aws_nat_gateway.this["nat1"].id
    :
    aws_nat_gateway.this[each.key].id
  )
}

resource "aws_route_table_association" "private" {

  for_each = local.private_subnet_by_az

  subnet_id      = each.value
  route_table_id = aws_route_table.private[each.key].id
}


# Database Route Tables

resource "aws_route_table" "database" {

  for_each = local.database_subnet_by_az

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "database-${each.key}"
  }
}

resource "aws_route_table_association" "database" {

  for_each = local.database_subnet_by_az

  subnet_id      = each.value
  route_table_id = aws_route_table.database[each.key].id
}