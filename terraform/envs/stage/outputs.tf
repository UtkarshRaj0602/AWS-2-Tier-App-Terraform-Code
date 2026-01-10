######################################################
################ VPC MODULE OUTPUTS ##################
######################################################

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "VPC - Public Subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "VPC - Private Subnet IDs"
  value       = module.vpc.private_subnet_ids
}

######################################################
################ EC2 MODULE OUTPUTS ##################
######################################################

output "aws_instance_ids" {
  description = "AWS EC2 Instance ID"
  value       = module.ec2.aws_instance_ids
}

output "aws_instance_private_ips" {
  description = "AWS EC2 Instance Private IP"
  value       = module.ec2.aws_instance_private_ips
}

######################################################
################ RDS MODULE OUTPUTS ##################
######################################################

output "aws_db_instance_id" {
  description = "RDS Instance ID"
  value       = module.rds.aws_db_instance_id
}

output "aws_db_instance_arn" {
  description = "RDS Instance ARN"
  value       = module.rds.aws_db_instance_arn
}

output "aws_db_endpoint" {
  description = "RDS Instance Endpoint"
  value       = module.rds.aws_db_endpoint
}

######################################################
################ ALB MODULE OUTPUTS ##################
######################################################

output "aws_lb_id" {
  description = "Output of AWS LB Id"
  value       = module.alb.aws_lb_id
}

output "aws_lb_arn" {
  description = "ARN of the load balancer"
  value       = module.alb.aws_lb_arn
}

output "aws_lb_arn_suffix" {
  description = "ARN suffix for use with CloudWatch Metrics"
  value       = module.alb.aws_lb_arn_suffix
}

output "aws_lb_dns_name" {
  description = "DNS name of the load balancer"
  value       = module.alb.aws_lb_dns_name
}

output "aws_lb_zone_id" {
  description = "Canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record)"
  value       = module.alb.aws_lb_zone_id
}

######################################################
################ WAF MODULE OUTPUTS ##################
######################################################