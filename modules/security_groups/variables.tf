variable "name" {
  description = "Security Group Name"
  type        = string
}

variable "description" {
  description = "Security Group Description"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "tags" {
  description = "Common Tags"
  type        = map(string)
  default     = {}
}

variable "ingress_rules" {

  description = "Ingress Rules"

  type = map(object({

    description = string

    from_port = number

    to_port = number

    protocol = string

    cidr_blocks = optional(list(string), [])

    source_security_group_id = optional(string)

  }))

  default ={}
}

variable "egress_rules" {

  description = "Egress Rules"

  type = map(object({

    description = string

    from_port = number

    to_port = number

    protocol = string

    cidr_blocks = optional(list(string), [])

    destination_security_group_id = optional(string)

  }))

  default = {}
}