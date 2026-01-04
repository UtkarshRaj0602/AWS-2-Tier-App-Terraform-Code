variable "environment" {
  description = "Environment Name - Stage Environment"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "enable_dns_support" {
  description = "For enabling VPC DNS Support"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "For enabling VPC DNS Hostnames"
  type        = bool
}

variable "aws_internet_gateway" {
  description = "This is the Internet Gateway block for this VPC."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

