variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EC2 will be launched"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where EC2 will be launched"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
}

variable "user_data" {
  description = "User data for EC2 Instance"
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  description = "IAM Role which will be attached to the EC2 Instance"
  type        = string
  default     = null
}

variable "allowed_ingress_cidr" {
  description = "List of CIDR blocks allowed for ingress traffic"
  type        = list(string)
  default     = []
}

variable "http_ingress_cidrs" {
  description = "CIDRs allowed for HTTP (80)"
  type        = list(string)
  default     = []
}

variable "https_ingress_cidrs" {
  description = "CIDRs allowed for HTTPS (443)"
  type        = list(string)
  default     = []
}

variable "keypair_bucket_name" {
  description = "S3 bucket name to store EC2 private key"
  type        = string
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "Root EBS volume type"
  type        = string
  default     = "gp3"
}

variable "root_volume_encrypted" {
  description = "Encrypt root EBS volume"
  type        = bool
  default     = false
}

variable "aws_lb_target_group_arn" {
  description = "ARN of the target group to attach to the ALB"
  type = string
  default = null
}

variable "aws_lb_target_group_http_port" {
  description = "HTTP port number of target group"
  type = number
  default = 80
}

variable "alb_security_group_id" {
  description = "ID of ALB security group"
  type = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}