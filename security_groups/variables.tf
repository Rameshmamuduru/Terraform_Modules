variable "name" {
    type = string
    description = "Name security group"  
}

variable "description" {
    type = string
    description = "Description security group"
}

variable "vpc_id" {
    type = string
    description = "VPC ID for security group"
  
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