resource "aws_instance" "this" {
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.this.id]
  user_data              = var.user_data
  iam_instance_profile   = var.iam_instance_profile
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    encrypted             = var.root_volume_encrypted
    delete_on_termination = true
  }

  tags = merge(var.tags, {
    Name        = "${var.environment}-ec2-instance"
    Environment = var.environment
  })
}

resource "aws_security_group" "this" {
  name        = "${var.environment}-ec2-sg"
  description = "Security group for EC2 instances in ${var.environment} environment"
  vpc_id      = var.vpc_id

  tags = merge(var.tags,
    {
      Name        = "${var.environment}-ec2-sg"
      Environment = var.environment
    }
  )
}

resource "aws_security_group_rule" "ingress_http" {
  for_each          = toset(var.http_ingress_cidrs)
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "ingress_https" {
  for_each          = toset(var.https_ingress_cidrs)
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "ingress_mysql" {
  for_each          = toset(var.allowed_ingress_cidr)
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "ingress_ssh" {
  for_each          = toset(var.allowed_ingress_cidr)
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "ingress_app" {
  for_each          = toset(var.allowed_ingress_cidr)
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = "${var.environment}-ec2-keypair"
  public_key = tls_private_key.this.public_key_openssh

  tags = merge(var.tags, {
    Name        = "${var.environment}-ec2-keypair"
    Environment = var.environment
  })
}

resource "aws_s3_object" "this" {
  bucket  = var.keypair_bucket_name
  key     = "${var.environment}/ec2-keypair/${var.environment}-ec2-keypair.pem"
  content = tls_private_key.this.private_key_pem

  server_side_encryption = "AES256"

  tags = merge(var.tags, {
    Name        = "${var.environment}-ec2-keypair"
    Environment = var.environment
  })
}

resource "aws_lb_target_group_attachment" "this" {
  count            = length(aws_instance.this)
  target_group_arn = var.aws_lb_target_group_arn
  target_id        = aws_instance.this[count.index].id
  port             = var.aws_lb_target_group_http_port
}

resource "aws_security_group_rule" "alb_to_ec2_ingress" {
  # depends_on = [aws_security_group.alb_sg]
  # count = var.alb_security_group_id != null ? 1 : 0
  # for_each = var.alb_security_group_id == null ? {} : {
  #   alb = var.alb_security_group_id
  # }

  type                     = "ingress"
  from_port                = var.aws_lb_target_group_http_port
  to_port                  = var.aws_lb_target_group_http_port
  protocol                 = "tcp"
  source_security_group_id = var.alb_security_group_id
  security_group_id        = aws_security_group.this.id
}

