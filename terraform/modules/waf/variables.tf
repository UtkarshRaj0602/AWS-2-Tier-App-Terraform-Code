variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "name" {
  description = "WAF WEB ACL Name"
  type        = string
}

variable "description" {
  description = "Description of Waf Web ACL"
  type        = string
}

variable "scope" {
  description = "Scope of the WAF WEB ACL"
  type        = string
}

variable "default_action" {
  description = "Default action of WAF Web ACL (Allow/Deny)"
  type        = string
  default     = "allow"
}

variable "resource_arn" {
  description = "Resource on which WAF Web ACL will be attached"
  type        = string
}

variable "enable_aws_managed_rules" {
  description = "Enable AWS managed WAF rule groups"
  type        = bool
  default     = true
}

variable "enable_rate_limit_rule" {
  description = "Enable rate limiting rule"
  type        = bool
  default     = false
}

variable "enable_logging" {
  description = "Enable WAF logging"
  type        = bool
  default     = false
}

variable "log_destination_arn" {
  description = "ARN of Kinesis Firehose/CloudWatch Log Group for WAF logs"
  type        = string
  default     = null
}

variable "cloudwatch_metrics_enabled" {
  description = "Enable CloudWatch metrics for WAF"
  type        = bool
  default     = true
}

variable "metric_name" {
  description = "CloudWatch metric name prefix for WAF"
  type        = string
}

variable "sampled_requests_enabled" {
  description = "Sample request for WAF WEB Acl -- in CloudWatch"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to WAF resources"
  type        = map(string)
  default     = {}
}
