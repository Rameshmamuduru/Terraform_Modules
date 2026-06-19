output "security_group_id" {
  description = "security group ID"
  value = aws_security_group.this.id
}

output "security_group_arn" {
  description = "security group ARN"
  value = aws_security_group.this.arn
}

output "security_group_name" {
  description = "security group name"
  value = aws_security_group.this.name
  
}