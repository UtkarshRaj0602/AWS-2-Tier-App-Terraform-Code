variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to be attached to Load Balancer"
  type        = string
}

variable "subnet_ids" {
  description = "VPC Subnet ID where Load Balancer will be launched"
  type        = list(string)
}

variable "name" {
  description = "Name of Load Balancer"
  type        = string
}

variable "internal" {
  description = "Load Balancer boolean value wether it will be Public-facing/internal(Private)"
  type        = bool
  default     = false
}

# Add this in main.tf file - hard-coded for any Load balancer type

# variable "load_balancer_type" {
#   description = "Type of Load Balancer"
#   type        = string
# }

variable "enable_deletion_protection" {
  description = "Enabled deletion protection for Load Balancer"
  type        = bool
  default     = false
}

variable "access_logs_enabled" {
  description = "Enable ALB access logging"
  type        = bool
  default     = false
}

variable "access_logs_bucket" {
  description = "S3 bucket for ALB access logs"
  type        = string
  default     = null
}

variable "access_logs_prefix" {
  description = "S3 prefix for ALB access logs"
  type        = string
  default     = null
}

# variable "allowed_security_group_ids" {
#   description = "Security groups allowed to access ALB"
#   type        = list(string)
#   default     = []
# }

variable "enable_http" {
  type    = bool
  default = true
}

# variable "enable_https" {
#   type    = bool
#   default = false
# }

# variable "certificate_arn" {
#   description = "ACM certificate ARN for HTTPS listener"
#   type        = string
#   default     = null
# }

variable "idle_timeout" {
  description = "Idle timeout for ALB in seconds"
  type        = number
  default     = 60
}

variable "target_type" {
  description = "Type of target group"
  type        = string
}

variable "target_group_port" {
  description = "Port on which target group will listen"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol for target group"
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "Health check path for target group"
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Number of consecutive health checks successes required before considering an unhealthy target healthy"
  type        = number
  default     = 5
}

variable "unhealthy_threshold" {
  description = "Number of consecutive health check failures required before considering a target unhealthy"
  type        = number
  default     = 2
}

variable "tg_health_check_timeout" {
  description = "Timeout of load balancer target group health check"
  type        = string
  default     = 30
}

variable "tg_health_check_interval" {
  description = "Interval of load balancer target group health check"
  type        = string
  default     = 30
}

variable "matcher_http_code" {
  description = "HTTP codes to use when checking for a successful response from a target"
  type        = string
  default     = "200"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}