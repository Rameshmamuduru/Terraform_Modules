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