# Terraform_Modules

## locals Use cases:
| Category                       | Purpose                            | Example                                                |
| ------------------------------ | ---------------------------------- | ------------------------------------------------------ |
| Naming Conventions             | Standardized resource names        | `name_prefix = "${var.project}-${var.environment}"`    |
| Common Tags                    | Reusable tags for all resources    | `common_tags = {...}`                                  |
| Maps for `for_each`            | Convert lists to maps              | `zipmap(var.azs, var.subnet_cidrs)`                    |
| Conditional Logic              | Environment-specific decisions     | `nat_count = var.environment == "prod" ? 3 : 1`        |
| Calculated Values              | Derived values                     | `db_port = var.engine == "mysql" ? 3306 : 5432`        |
| Resource Counts                | Centralize count logic             | `instance_count = var.environment == "prod" ? 3 : 1`   |
| Environment Configuration      | Different settings per environment | `backup_days = var.environment == "prod" ? 30 : 7`     |
| CIDR Calculations              | Network calculations               | `private_subnets = cidrsubnets(var.vpc_cidr, 4, 4, 4)` |
| Availability Zone Mapping      | AZ to subnet mapping               | `az_subnet_map = zipmap(var.azs, var.subnets)`         |
| Dynamic Resource Configuration | Build complex objects              | `eks_node_groups = {...}`                              |
| Security Group Rules           | Centralize ports/protocols         | `web_ports = [80, 443]`                                |
| IAM Policy Fragments           | Reusable policy statements         | `s3_read_permissions = {...}`                          |
| Route Table Logic              | NAT/IGW route decisions            | `default_route_target = ...`                           |
| Load Balancer Settings         | ALB/NLB configuration              | `lb_idle_timeout = 60`                                 |
| Autoscaling Values             | Min/max/desired counts             | `asg_config = {...}`                                   |
| Database Configuration         | DB settings by environment         | `db_settings = {...}`                                  |
| EKS Configuration              | Node groups, taints, labels        | `node_group_config = {...}`                            |
| ECS Configuration              | CPU/memory combinations            | `task_sizes = {...}`                                   |
| Standardized Resource Labels   | Consistent metadata                | `resource_labels = {...}`                              |
| Merged Configurations          | Combine multiple maps              | `final_tags = merge(...)`                              |
| Feature Flags                  | Enable/disable features            | `enable_nat = var.environment == "prod"`               |
| Region-Based Logic             | Region-specific settings           | `ami_map = {...}`                                      |
| Application Configuration      | App-specific values                | `app_config = {...}`                                   |
| DNS Naming                     | Standard DNS names                 | `domain_name = "${var.env}.example.com"`               |
| Monitoring Settings            | CloudWatch/Prometheus configs      | `alarm_thresholds = {...}`                             |
