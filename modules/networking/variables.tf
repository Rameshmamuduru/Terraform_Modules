variable "vpc_cidr" {
    type = string
    description = "CIDR block for VPC" 
}

variable "subnets" {
    type = map(object({
      cidr_block = string
      az = string
      subnet_type = string

    }))

    validation {
      condition = alltrue([
        for subnet in values(var.subnets) :
        can(cidrnetmask(subnet.cidr_block))
      ])
      error_message = "all subnet CIDR must be in valid range"
    }

    validation {
      condition = alltrue([
        for subnet in values(var.subnets) :
        contains(
          ["public", "private", "database"], lower(subnet.subnet_type)
        )
      ])
      error_message = "subnet type must be in public, private or database"
    }
}

## IGW and NAT variables

variable "enable_nat_gateway" {

  description = "Enable NAT for PROD, in all the azs"
  type = bool
  default = true
  
}

variable "nat_gateway_strategy" {

  description = "single or one_per_az"
  type = string
  default = "single"

  validation {
    condition = contains(
      ["single", "one_per_az"], var.nat_gateway_strategy  
    )

    error_message = "allowed values are single or one_per_az"
  }
  
}
