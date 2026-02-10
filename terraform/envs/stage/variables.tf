##############################################
########### Global Variables ###########
##############################################

variable "environment" {
  description = "Environment of Application (Prod/Stage)"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

##############################################
########### MODULE - VPC Variables ###########
##############################################

variable "vpc_cidr" {
  description = "VPC_CIDR of the AWS Application"
  type        = string
}

variable "availability_zones" {
  description = "Availability Zone of the VPC"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public Subnet CIDRs which will be added in the VPC - Public Subnet"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private Subnet CIDRs which will be added in the VPC - Private Subnet"
  type        = list(string)
}

variable "enable_dns_support" {
  description = "Enables DNS Support for VPC"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enables DNS Hostnames for VPC"
  type        = bool
}

variable "aws_internet_gateway" {
  description = "AWS-Internet-Gateway - Enabled for VPC"
  type        = string
}

##############################################
########### MODULE - EC2 Variables ###########
##############################################

variable "ami_id" {
  description = "AMI-ID of the EC2 instance using which Instance will be created."
  type        = string
}

variable "instance_type" {
  description = "Instance Type of the EC2 Instance which has to be launched"
  type        = string
}

variable "instance_count" {
  description = "EC2 Instance Count - Number of EC2 instance to be launched"
  type        = number
}

#User-Data is not needed in variables file

variable "iam_instance_profile" {
  description = "EC2 - IAM Instance Profile for Instance EC2 Security and Instance Connect"
  type        = string
}

variable "http_ingress_cidrs" {
  description = "HTTP Ingress CIDRs to be allowed in EC2"
  type        = list(string)
}

variable "https_ingress_cidrs" {
  description = "HTTPs Ingress CIDRs to be allowed in EC2"
  type        = list(string)
}

variable "keypair_bucket_name" {
  description = "S3 bucket name for storing EC2 keypairs"
  type        = string
}

variable "root_volume_size" {
  description = "Size of EC2 - EBS root volume"
  type        = number
}

variable "root_volume_type" {
  description = "Type of EC2 - EBS root volume"
  type        = string
}

variable "root_volume_encrypted" {
  description = "Encryption enabled/disabled for EC2 - EBS root volume"
  type        = bool
}

##############################################
########### MODULE - RDS Variables ###########
##############################################

variable "engine" {
  description = "Engine of RDS"
  type        = string
}

variable "engine_version" {
  description = "Engine version of RDS"
  type        = string
}

variable "instance_class" {
  description = "Instance Class of RDS"
  type        = string
}

variable "db_name" {
  description = "Database Name of RDS"
  type        = string
}

variable "username" {
  description = "Username of RDS database"
  type        = string
}

variable "password" {
  description = "Password of RDS database"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated Storage for the RDS database"
  type        = number
}

variable "storage_type" {
  description = "Storage Type of RDS database"
  type        = string
}

variable "storage_encrypted" {
  description = "RDS Database storage encypted is enabled/disabled"
  type        = bool
}

variable "multi_az" {
  description = "Multi-AZ for RDS is enabled/disabled"
  type        = bool
}

variable "publicly_accessible" {
  description = "RDS database is public/private"
  type        = bool
}

variable "backup_retention_period" {
  description = "Automated Backup retention period of RDS database"
  type        = number
}

variable "skip_final_snapshot" {
  description = "Final Snapshot of RDS to be taken before deletion"
  type        = bool
}

variable "performance_insights_enabled" {
  description = "Performance insights for RDS database (enabled/disabled)"
  type        = bool
}

variable "monitoring_interval" {
  description = "Monitoring Interval time of RDS"
  type        = number
}

variable "monitoring_role_arn" {
  description = "IAM Role ARN for monitoring for RDS database"
  type        = string
}

variable "auto_minor_version_upgrade" {
  description = "auto_minor_version_upgrade for RDS database"
  type        = bool
}

variable "maintenance_window" {
  description = "Weekly maintance window for RDS database"
  type        = string
}

variable "deletion_protection" {
  description = "deletion_protection enabled/disbaled for RDS database"
  type        = bool
}

##############################################
########### MODULE - ALB Variables ###########
##############################################

variable "alb_name" {
  description = "Name of ALB"
  type        = string
}

variable "internal" {
  description = "internal/external (Public/Private) ALB"
  type        = bool
}

variable "target_type" {
  description = "Target type of ALB"
  type        = string
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for ALB"
  type        = bool
}

variable "access_logs_enabled" {
  description = "access_logs_enabled/disabled for ALB"
  type        = bool
}

variable "access_logs_bucket" {
  description = "S3 bucket for ALB access_logs"
  type        = string
}

variable "access_logs_prefix" {
  description = "Prefix for S3 bucket for storing ALB Access logs"
  type        = string
}

variable "enable_http" {
  description = "Enable HTTP for ALB"
  type        = bool
}

# variable "enable_https" {
#    description = "Enable HTTPs for ALB"
#   type = bool
# }

# variable "certificate_arn" {
#   description = "certificate_arn to be attached to ALB"
#   type = string
# }

variable "idle_timeout" {
  description = "Idle timeout for ALB"
  type        = number
}

variable "target_group_port" {
  description = "target_group_port number for ALB"
  type        = number
}

variable "target_group_protocol" {
  description = "target_group_protocol for ALB"
  type        = string
}

variable "health_check_path" {
  description = "health_check_path for ALB"
  type        = string
}

variable "health_check_interval" {
  description = "health_check_interval for ALB"
  type        = number
}

variable "health_check_timeout" {
  description = "health_check_timeout for ALB"
  type        = number
}

variable "healthy_threshold" {
  description = "healthy_threshold for ALB"
  type        = number
}

variable "unhealthy_threshold" {
  description = "unhealthy_threshold for ALB"
  type        = number
}

variable "tg_health_check_timeout" {
  description = "Timeout of load balancer target group health check"
  type        = number
}

variable "tg_health_check_interval" {
  description = "Interval of load balancer target group health check"
  type        = number
}

variable "matcher_http_code" {
  description = "matcher_http_code for ALB"
  type        = string
}

##############################################
########### MODULE - WAF Variables ###########
##############################################

variable "waf_name" {
  description = "Name of WAF Web ACL"
  type        = string
}

variable "description" {
  description = "Description of WAF Web ACL"
  type        = string
}

variable "scope" {
  description = "Scope of WAF Web ACL (Regional/Private/Public)"
  type        = string
}

variable "default_action" {
  description = "Default Action for WAF Web ACL"
  type        = string
}

variable "enable_aws_managed_rules" {
  description = "enable_aws_managed_rules for WAF"
  type        = bool
}

variable "enable_rate_limit_rule" {
  description = "enable_rate_limit_rule for WAF"
  type        = bool
}

variable "enable_logging" {
  description = "enable_logging for WAF"
  type        = bool
}

variable "log_destination_arn" {
  description = "log_destination_arn for WAF"
  type        = string
}

variable "cloudwatch_metrics_enabled" {
  description = "cloudwatch_metrics_enabled for WAF"
  type        = bool
}

variable "metric_name" {
  description = "metric_name for Cloudwatch for WAF"
  type        = string
}

variable "sampled_requests_enabled" {
  description = "sampled_requests_enabled/disabled for WAF"
  type        = string
}

##############################################
########### MODULE - SNS Variables ###########
##############################################

variable "topic_name" {
  description = "SNS Topic Name - Standard SNS Topic"
  type        = string
}

variable "email_subscriptions" {
  description = "Email Subscriptions for SNS topic"
  type        = list(string)
}

##############################################
####### MODULE - CLOUDWATCH Variables ########
##############################################

# variable "sns_topic_arn" {
#   description = "SNS topic ARN for CloudWatch alarms"
#   type        = string
# }

# variable "ec2_instance_ids" {
#   description = "EC2 instance IDs for alarms"
#   type        = list(string)
# }

# variable "alb_arn_suffix" {
#   description = "ALB ARN suffix"
#   type        = string
# }

# variable "rds_instance_id" {
#   description = "RDS instance identifier"
#   type        = string
# }
