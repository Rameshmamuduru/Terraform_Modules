locals {

  ingress_cidr_rules = flatten([

    for rule_index, rule in var.ingress_rules : [

      for cidr in rule.cidr_blocks : {

        key = "${rule_index}-${cidr}"

        description = rule.description

        from_port = rule.from_port

        to_port = rule.to_port

        protocol = rule.protocol

        cidr = cidr

      }

    ]

  ])

  egress_cidr_rules = flatten([

    for rule_index, rule in var.egress_rules : [

      for cidr in rule.cidr_blocks : {

        key = "${rule_index}-${cidr}"

        description = rule.description

        from_port = rule.from_port

        to_port = rule.to_port

        protocol = rule.protocol

        cidr = cidr

      }

    ]

  ])

}