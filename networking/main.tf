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