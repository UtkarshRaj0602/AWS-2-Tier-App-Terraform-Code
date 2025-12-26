variable "environment" {
  description = "Environment Name - Stage Environment"
  type = string
}

variable "vpc cidr" {
  description = "CIDR block for the VPC"
  type = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type = list(string)
}

variable "public_subnet_cidrs" {
    description = "List of CIDR blocks for public subnets"
    type = list(string)
}

variable "private_subnet_cidrs" {
    description = "List of CIDR blocks for private subnets"
    type = list(string)
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type = map(string)
  default = {}
}