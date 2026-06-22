variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "subnets" {

  type = map(object({
    cidr_block = string
    az          = string
    subnet_type = string
  }))

  validation {
    condition = alltrue([
      for subnet in values(var.subnets) :
      can(cidrnetmask(subnet.cidr_block))
    ])

    error_message = "All subnet CIDRs must be valid."
  }

  validation {
    condition = alltrue([
      for subnet in values(var.subnets) :
      contains(
        ["public", "private", "database"],
        lower(subnet.subnet_type)
      )
    ])

    error_message = "Subnet type must be public, private or database."
  }
}

variable "enable_nat_gateway" {
  type        = bool
  default     = true
  description = "Enable NAT Gateway"
}

variable "nat_gateway_strategy" {

  type        = string
  default     = "single"
  description = "single or one_per_az"

  validation {
    condition = contains(
      ["single", "one_per_az"],
      var.nat_gateway_strategy
    )

    error_message = "Allowed values are single or one_per_az."
  }
}