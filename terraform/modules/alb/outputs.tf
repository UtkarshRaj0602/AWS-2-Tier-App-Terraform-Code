output "aws_lb_id" {
  description = "Output of AWS LB Id"
  value       = aws_lb.this.id
}

output "aws_lb_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.this.arn
}

output "aws_lb_arn_suffix" {
  description = "ARN suffix for use with CloudWatch Metrics"
  value       = aws_lb.this.arn_suffix
}

output "aws_lb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}

output "alb_security_group_id" {
  description = "Security group ID associated with the ALB"
  value       = aws_security_group.this.id
}

output "aws_lb_zone_id" {
  description = "Canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record)"
  value       = aws_lb.this.zone_id
}

output "aws_lb_target_group_arn_suffix" {
  description = "ARN suffix for use with CloudWatch Metrics"
  value       = aws_lb_target_group.this.arn_suffix
}

output "aws_lb_target_group_arn" {
  description = "ARN of the Target Group"
  value       = aws_lb_target_group.this.arn
}

output "aws_lb_target_group_id" {
  description = "ARN of the Target Group"
  value       = aws_lb_target_group.this.id
}

output "aws_lb_target_group_name" {
  description = "Name of the target group"
  value       = aws_lb_target_group.this.name
}

output "aws_lb_target_group_load_balancer_arns" {
  description = "List of load balancer ARNs associated with the target group"
  value       = aws_lb_target_group.this.load_balancer_arns
}

output "target_group_arn" {
  description = "Target group ARN of ALB"
  value       = aws_lb_target_group.this.arn
}
