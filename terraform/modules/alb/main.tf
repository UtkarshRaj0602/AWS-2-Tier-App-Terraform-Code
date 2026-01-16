resource "aws_lb" "this" {
  name               = "${var.environment}-${var.name}-alb"
  internal           = var.internal
  load_balancer_type = "application"

  security_groups = [aws_security_group.this.id]
  subnets         = var.subnet_ids

  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout               = var.idle_timeout

  dynamic "access_logs" {
    for_each = var.access_logs_enabled ? [1] : []
    content {
      enabled = true
      bucket  = var.access_logs_bucket
      prefix  = var.access_logs_prefix
    }
  }

  tags = merge(var.tags, {
    Name        = "${var.environment}-${var.name}-alb"
    Environment = var.environment
  })
}

resource "aws_security_group" "this" {
  name        = "${var.environment}-${var.name}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name        = "${var.environment}-${var.name}-alb-sg"
    Environment = var.environment
  })
}

resource "aws_lb_target_group" "this" {
  name        = "${var.environment}-${var.name}-tg"
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    enabled             = true
    path                = var.health_check_path
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.tg_health_check_timeout
    interval            = var.tg_health_check_interval
    matcher             = var.matcher_http_code
  }

  tags = merge(var.tags, {
    Name        = "${var.environment}-${var.name}-tg"
    Environment = var.environment
  })
}

