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

output "aws_lb_target_group_arn" {
  description = "ARN of the Target Group"
  value       = module.alb.aws_lb_target_group_arn
}

output "aws_lb_target_group_id" {
  description = "ARN of the Target Group"
  value       = module.alb.aws_lb_target_group_id
}

output "aws_lb_target_group_name" {
  description = "Name of the target group"
  value       = module.alb.aws_lb_target_group_name
}

output "aws_lb_target_group_load_balancer_arns" {
  description = "List of load balancer ARNs associated with the target group"
  value       = module.alb.aws_lb_target_group_load_balancer_arns
}

######################################################
################ WAF MODULE OUTPUTS ##################
######################################################

output "aws_wafv2_web_acl_application_integration_url" {
  description = "The URL to use in SDK integrations with managed rule groups"
  value       = module.waf.aws_wafv2_web_acl_application_integration_url
}

output "aws_wafv2_web_acl_arn" {
  description = "ARN of the WAF Web ACL"
  value       = module.waf.aws_wafv2_web_acl_arn
}

output "aws_wafv2_web_acl_capacity" {
  description = "Web ACL capacity units (WCUs) currently being used by this web ACL"
  value       = module.waf.aws_wafv2_web_acl_capacity
}

output "aws_wafv2_web_acl_id" {
  description = "The ID of the WAF WebACL"
  value       = module.waf.aws_wafv2_web_acl_id
}

output "aws_wafv2_web_acl_association_id" {
  description = "WAF Web ACL association ID"
  value       = module.waf.aws_wafv2_web_acl_association_id
}

######################################################
############# CloudFront MODULE OUTPUTS ##############
######################################################

