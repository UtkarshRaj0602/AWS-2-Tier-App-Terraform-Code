resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = merge(var.tags, {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  })
}

resource "aws_subnet" "public" {
  for_each = zipmap(var.availability_zones, var.public_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = merge(var.tags, {
    Name        = "${var.environment}-public-subnet-${each.key}"
    Environment = var.environment
    Type        = "public"
  })
}

resource "aws_subnet" "private" {
  for_each = zipmap(var.availability_zones, var.private_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = merge(var.tags, {
    Name        = "${var.environment}-private-subnet-${each.key}"
    Environment = var.environment
    Type        = "private"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  })
}

resource "aws_eip" "this" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name        = "${var.environment}-nat-eip"
    Environment = var.environment
  })
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public["${var.availability_zones[0]}"].id

  tags = merge(var.tags, {
    Name        = "${var.environment}-nat-gateway"
    Environment = var.environment
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(var.tags, {
    Name        = "${var.environment}-public-rt"
    Environment = var.environment
  })
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = merge(var.tags, {
    Name        = "${var.environment}-private-rt"
    Environment = var.environment
  })
}

resource "aws_route_table_association" "public_association" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_association" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

data "aws_region" "current" {}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private.id,
    aws_route_table.public.id
  ]

  tags = merge(var.tags, {
    Name        = "${var.environment}-s3-endpoint"
    Environment = var.environment
  })
}