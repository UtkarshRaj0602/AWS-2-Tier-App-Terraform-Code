output "vpc_id" {
  description = "The VPC Id block of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "List of Public Subnet IDs"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "List of Private Subnet IDs"
  value       = [for subnet in aws_subnet.private : subnet.id]
}

output "aws_internet_gateway_id" {
  description = "The Internet Gateway ID of the VPC"
  value       = aws_internet_gateway.this.id
}

output "aws_eip_id" {
    description = "The Elastic IP ID of the VPC"
    value       = aws_eip.this.id
}

output "nat_gateway_id" {
  description = "The NAT Gateway ID of the VPC"
  value       = aws_nat_gateway.this.id
}

output "aws_route_table_public_id" {
  description = "The Public Route Table ID of the VPC"
  value       = aws_route_table.public.id
}

output "aws_route_table_private_id" {
  description = "The Private Route Table ID of the VPC"
  value       = aws_route_table.private.id
}

output "aws_route_table_association_private_id" {
    description = "The Private Route Table Association IDs of the VPC"
    value       = [for assoc in aws_route_table_association.private_association : assoc.id]
}

output "aws_route_table_association_public_id" {
    description = "The Public Route Table Association IDs of the VPC"
    value       = [for assoc in aws_route_table_association.public_association : assoc.id]
}

output "vpc_endpoint_id" {
  description = "The VPC Endpoint ID for S3"
  value       = aws_vpc_endpoint.s3.id
}

