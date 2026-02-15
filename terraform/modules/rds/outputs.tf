output "aws_db_instance_id" {
  description = "RDS Instance ID"
  value       = aws_db_instance.this.id
}

output "aws_db_instance_arn" {
  description = "RDS Instance ARN"
  value       = aws_db_instance.this.arn
}

output "aws_db_subnet_group_id" {
  description = "RDS DB Subnet Group ID"
  value       = aws_db_subnet_group.this.id
}

output "aws_db_subnet_group_arns" {
  description = "RDS DB Subnet Group ARN"
  value       = aws_db_subnet_group.this.arn
}

output "db_port" {
  description = "RDS database port"
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.this.db_name
}

output "db_identifier" {
  description = "RDS DB identifier"
  value       = aws_db_instance.this.identifier
}

output "aws_db_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.this.endpoint
}

output "aws_security_group_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.this.id
}

output "aws_security_group_arns" {
  description = "RDS Security Group ARN"
  value       = aws_security_group.this.arn
}

output "aws_custom_parameter_group_id" {
  description = "Custom parameter group ID of RDS"
  value       = aws_db_parameter_group.this.id
}

output "aws_custom_parameter_group_arn" {
  description = "Custom parameter group ARN of RDS"
  value       = aws_db_parameter_group.this.arn
}
