resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "main-vpc"
    }
  
}

resource "aws_subnet" "public" {
    for_each = local.public_subnet
    
    vpc_id = aws_vpc.this.id
    cidr_block = each.value
    availability_zone = each.key
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet-${each.key}"
    }
  
}

resource "aws_subnet" "private" {
    for_each = local.private_subnet
    
    vpc_id = aws_vpc.this.id
    cidr_block = each.value
    availability_zone = each.key
    map_public_ip_on_launch = false
    tags = {
        Name = "private-subnet-${each.key}"
    }
  
}

resource "aws_subnet" "database" {
    for_each = local.database_subnet
    
    vpc_id = aws_vpc.this.id
    cidr_block = each.value
    availability_zone = each.key
    map_public_ip_on_launch = false
    tags = {
        Name = "database-subnet-${each.key}"
    }
  
}

## Internet Gateway
resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id
    tags = {
        Name = "main-igw"
    }
}

resource "aws_eip" "nat" {
    for_each = var.nat_type == "single" ? { (var.single_nat_az) = local.public_subnet[var.single_nat_az] } : local.public_subnet

    domain = "vpc"

    tags = {
        Name = "nat-eip-${each.key}"
    }   
}

resource "aws_nat_gateway" "this" {
    for_each = var.nat_type == "single" ? { (var.single_nat_az) = local.public_subnet[var.single_nat_az] } : { for idx, az in var.azs : az => local.public_subnet[az] }

    allocation_id = aws_eip.nat[each.key].id
    subnet_id = aws_subnet.public[each.key].id
    tags = {
        Name = "nat-gateway-${each.key}"
    }
  
}

## Public and private Routes

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id
    tags = {
        Name = "public-rt"
    }

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.this.id
    }
  
}

resource "aws_route_table_association" "public" {
    for_each = aws_subnet.public

    subnet_id = each.value.id
    route_table_id = aws_route_table.public.id
  
}

resource "aws_route_table" "private" {
    for_each = aws_subnet.private

    vpc_id = aws_vpc.this.id
    tags = {
        Name = "private-rt-${each.key}"
    }

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.this[each.key].id
    }
}

resource "aws_route_table_association" "private" {
    for_each = aws_subnet.private

    subnet_id = each.value.id
    route_table_id = aws_route_table.private[each.key].id
}