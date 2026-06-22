resource "aws_security_group" "this" {

  name        = var.name

  description = var.description

  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "cidr" {

  for_each = {

    for rule in local.ingress_cidr_rules :

    rule.key => rule

  }

  security_group_id = aws_security_group.this.id

  description = each.value.description

  from_port = each.value.from_port

  to_port = each.value.to_port

  ip_protocol = each.value.protocol

  cidr_ipv4 = each.value.cidr
}

resource "aws_vpc_security_group_ingress_rule" "sg" {

  for_each = {

    for idx, rule in var.ingress_rules :

    idx => rule

    if try(rule.source_security_group_id, null) != null

  }

  security_group_id = aws_security_group.this.id

  description = each.value.description

  from_port = each.value.from_port

  to_port = each.value.to_port

  ip_protocol = each.value.protocol

  referenced_security_group_id = each.value.source_security_group_id
}

resource "aws_vpc_security_group_egress_rule" "cidr" {

  for_each = {

    for rule in local.egress_cidr_rules :

    rule.key => rule

  }

  security_group_id = aws_security_group.this.id

  description = each.value.description

  from_port = each.value.from_port

  to_port = each.value.to_port

  ip_protocol = each.value.protocol

  cidr_ipv4 = each.value.cidr
}

resource "aws_vpc_security_group_egress_rule" "sg" {

  for_each = {

    for idx, rule in var.egress_rules :

    idx => rule

    if try(rule.destination_security_group_id, null) != null

  }

  security_group_id = aws_security_group.this.id

  description = each.value.description

  from_port = each.value.from_port

  to_port = each.value.to_port

  ip_protocol = each.value.protocol

  referenced_security_group_id = each.value.destination_security_group_id
}