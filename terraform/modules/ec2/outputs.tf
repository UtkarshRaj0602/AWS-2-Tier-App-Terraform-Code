output "aws_instance_ids" {
  description = "List of EC2 Instance IDs"
  value       = [for instance in aws_instance.this : instance.id]
}

output "aws_instance_arns" {
  description = "EC2 Instance ARN"
  value       = [for instance in aws_instance.this : instance.arn]
}

output "aws_instance_private_ips" {
  description = "List of EC2 Instance Private IPs"
  value       = [for instance in aws_instance.this : instance.private_ip]
}

output "vpc_security_group_ids" {
  description = "Security group ID of VPC in which EC2 is being launched"
  value       = [for sg in aws_instance.this : sg.id]
}

output "aws_key_pair_ids" {
  description = "The Key Pair ID used for the EC2 Instance"
  value       = aws_key_pair.this.id
}

output "aws_key_pair_arns" {
  description = "The Key Pair ARN used for the EC2 Instance"
  value       = aws_key_pair.this.arn
}

output "aws_key_pair_key_pair_ids" {
  description = "The Key Pair Key Pair ID used for the EC2 Instance"
  value       = aws_key_pair.this.key_pair_id
}

output "aws_key_pair_fingerprint" {
  description = "The Key Pair Fingerprint used for the EC2 Instance"
  value       = aws_key_pair.this.fingerprint
}

output "aws_security_group_ids" {
  description = "The security group ID of the EC2 Instance"
  value       = aws_security_group.this.id
}

output "aws_security_group_arns" {
  description = "The security group ARN of the EC2 Instance"
  value       = aws_security_group.this.arn
}

output "tls_private_key_private_key_pem" {
  description = "The Private Key PEM used for the EC2 Instance"
  value       = tls_private_key.this.private_key_pem
}

output "tls_private_key_ids" {
  description = "The Private Key PEM used for the EC2 Instance"
  value       = tls_private_key.this.id
}

