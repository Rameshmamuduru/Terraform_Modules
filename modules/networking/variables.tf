variable "vpc_cidr" {
    type = string
    description = "CIDR block for VPC" 
}

variable "azs" {
    type = map(string)
    description = "List of availability zones"
}

variable "public_subnet_cidrs" {
    type = map(string)
    description = "List of CIDR blocks for public subnets"

    validation {
      condition = length(var.public_subnet_cidrs) == length(var.azs)
      error_message = "public subnet CIDR must match with Number of AZs"
    }
}

variable "private_subnet_cidrs" {
    type = map(string)
    description = "List of CIDR blocks for private subnets"

    validation {
      condition = length(var.private_subnet_cidrs) == length(var.azs)
      error_message = "private subnet CIDR must match with Number of AZs"
    }
}

variable "database_subnet_cidrs" {
    type = map(string)
    description = "List of CIDR blocks for database subnets"
    default = [ ]

    validation {
      condition = (
        length(var.database_subnet_cidrs) == 0 || length(var.database_subnet_cidrs) == length(var.azs)

      )
      error_message = "database subnet CIDR must match with Number of AZs"
    }
}


variable "nat_type" {
  type = string
  description = "NAT deployment type: Single or Multi"

  validation {
    condition = contains(["single", "multi"], var.nat_type)
    error_message = "nat_type must be single or multi"
  }
}

variable "single_nat_az" {
  type = string
  default = "null"

  validation {
    condition = (
        var.single_nat_az == null || contains (var.azs, var.single_nat_az)
    )
    error_message = "single nat must exsist in azs"
  }
}