variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where RDS will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for RDS subnet group"
  type        = list(string)
}

variable "allowed_security_group_ids" {
  description = "Security group IDs allowed to access RDS"
  type        = list(string)
}

variable "engine" {
  description = "Database Engine"
  type        = string
}

variable "engine_version" {
  description = "Database Engine Version"
  type        = string
}

variable "instance_class" {
  description = "RDS Instance Class"
  type        = string
}

variable "db_name" {
  description = "This is the main database name"
  type        = string
}

variable "username" {
  description = "RDS database default username"
  type        = string
}

variable "password" {
  description = "RDS database default usernames - password"
  type        = string
  sensitive   = true
}

# variable "parameter_group_name" {
#   description = "RDS Parameter Group Name"
#   type        = string
# }

variable "allocated_storage" {
  description = "Allocated Storage of the RDS Engine"
  type        = number
}

variable "storage_type" {
  description = "Storage type (gp3, gp2, io1)"
  type        = string
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Whether DB is publicly accessible"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Backup retention in days"
  type        = number
}

variable "skip_final_snapshot" {
  description = "Final snapshot of RDS database instance taken before terminating"
  type        = bool
  default     = false
}

# variable "availability_zone" {
#   description = "Availability Zone in which the RDS will be launched"
#   type        = string
# }

# variable "ca_cert_identifier" {
#   description = "Certificate_Authority of RDS Instance"
#   type        = string
# }

variable "performance_insights_enabled" {
  description = "Enable performance insights for RDS"
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "Monitoring Interval for RDS performance insights"
  type        = number
}

# variable "enabled_cloudwatch_logs_exports" {
#   description = "RDS cloudwatch logging"
#   type        = list(string)
# }

# variable "option_group_name" {
#   description = "RDS Option Group Name"
#   type        = string
# }

# variable "kms_key_id" {
#   description = "KMS key id to be used for RDS"
#   type        = string
# }

variable "auto_minor_version_upgrade" {
  description = "Enable auto minor version upgrade for RDS"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "Preferred maintenance window for RDS"
  type        = string
}

variable "deletion_protection" {
  description = "Enable deletion protection for RDS"
  type        = bool
  default     = false
}

variable "monitoring_role_arn" {
  description = "Existing IAM role ARN for RDS Enhanced Monitoring"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

