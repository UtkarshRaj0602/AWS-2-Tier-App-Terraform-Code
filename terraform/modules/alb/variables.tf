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
  type = list(string)
}

variable "name" {
  description = "Name of Load Balancer"
  type = string
}

variable "internal" {
  description = "Load Balancer boolean value wether it will be Public-facing/internal(Private)"
  type        = bool
  default = false
}

variable "load_balancer_type" {
    description = "Type of Load Balancer"
    type        = string
}

variable "enable_deletion_protection" {
  description = "Enabled deletion protection for Load Balancer"
  type = bool
  default = false
}

variable "bucket" {
  description = "S3 bucket name where ALB access logs will be stored"
  type = string
}

variable "prefix" {
  description = "Access log - S3 bucket prefix name"
  type = string
}

variable "enabled" {
    description = "Enable access logging for Load Balancer"
    type = bool
    default = false
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
