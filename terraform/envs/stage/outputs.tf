######################################################
################ VPC MODULE OUTPUTS ##################
######################################################

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

######################################################
################ EC2 MODULE OUTPUTS ##################
######################################################

output "aws_instance_ids" {
  description = "AWS EC2 Instance ID"
  value       = module.ec2.aws_instance_ids
}

output "aws_instance_private_ips" {
  description = "AWS EC2 Instance Private IP"
  value       = module.ec2.aws_instance_private_ips
}