variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  
}

variable "security_group_description" {
  description = "Description of the security group"
  type        = string
  
}

variable "security_group_ingress_rules" {
  description = "List of ingress rules for the security group"
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  
}

variable "security_group_egress_rules" {
  description = "List of egress rules for the security group"
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  
}