variable "environment" {
  description = "Environment name"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN for alarm notifications"
  type        = string
}

variable "ec2_instance_ids" {
  description = "List of EC2 instance IDs to monitor"
  type        = list(string)
  default     = []
}

variable "alb_arn_suffix" {
  description = "ALB ARN suffix for CloudWatch metrics"
  type        = string
  default     = null
}

variable "rds_instance_id" {
  description = "RDS instance identifier"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to CloudWatch alarms"
  type        = map(string)
  default     = {}
}
