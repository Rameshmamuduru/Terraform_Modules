variable "name" {
  type        = string
  description = "Security Group Name"
}

variable "description" {
  type        = string
  description = "Security Group Description"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))

  default = []
}

variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))

  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}