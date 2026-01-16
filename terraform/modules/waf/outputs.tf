output "aws_wafv2_web_acl_application_integration_url" {
  description = "The URL to use in SDK integrations with managed rule groups"
  value       = aws_wafv2_web_acl.this.application_integration_url
}

output "aws_wafv2_web_acl_arn" {
  description = "ARN of the WAF Web ACL"
  value       = aws_wafv2_web_acl.this.arn
}

output "aws_wafv2_web_acl_capacity" {
  description = "Web ACL capacity units (WCUs) currently being used by this web ACL"
  value       = aws_wafv2_web_acl.this.capacity
}

output "aws_wafv2_web_acl_id" {
  description = "The ID of the WAF WebACL"
  value       = aws_wafv2_web_acl.this.id
}

output "aws_wafv2_web_acl_association_id" {
  description = "WAF Web ACL association ID"
  value       = aws_wafv2_web_acl_association.this.id
}