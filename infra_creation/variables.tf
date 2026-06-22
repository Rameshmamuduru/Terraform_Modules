variable "vpc_cidr" {
  type = string
}

variable "enable_nat_gateway" {
  type = bool
}

variable "nat_gateway_strategy" {
  type = string
}

variable "subnets" {

  type = map(object({
    cidr_block = string
    az          = string
    subnet_type = string
  }))

}

variable "name" {
  description = "Security Group Name"
  type        = string
}

variable "description" {
  description = "Security Group Description"
  type        = string
}


variable "tags" {
  description = "Common Tags"
  type        = map(string)
  default = { }

}

variable "security_groups" {

  type = map(object({

    description = string

    ingress_rules = map(object({

      description = string

      from_port = number

      to_port = number

      protocol = string

      cidr_blocks = optional(list(string), [])

      source_security_group_name = optional(string)

    }))

    egress_rules = map(object({

      description = string

      from_port = number

      to_port = number

      protocol = string

      cidr_blocks = optional(list(string), [])

      destination_security_group_name = optional(string)

    }))

  }))
}