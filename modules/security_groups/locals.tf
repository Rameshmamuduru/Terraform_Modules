locals {

  ingress_cidr_rules = flatten([

    for rule_name, rule in var.ingress_rules : [

      for cidr in rule.cidr_blocks : {

        key = "${rule_name}-${replace(cidr, "/", "-")}"

        description = rule.description

        from_port = rule.from_port

        to_port = rule.to_port

        protocol = rule.protocol

        cidr = cidr

      }

    ]

  ])

  egress_cidr_rules = flatten([

    for rule_name, rule in var.egress_rules : [

      for cidr in rule.cidr_blocks : {

        key = "${rule_name}-${replace(cidr, "/", "-")}"

        description = rule.description

        from_port = rule.from_port

        to_port = rule.to_port

        protocol = rule.protocol

        cidr = cidr

      }

    ]

  ])

}