module "vpc" {
  source = "../../modules/vpc"

  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  aws_internet_gateway = var.aws_internet_gateway

  tags = var.tags
}

module "ec2" {
  source = "../../modules/ec2"

  environment    = var.environment
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.private_subnet_ids[0]
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  instance_count = var.instance_count

  user_data = file("${path.module}/user_data.sh")

  alb_security_group_id = module.alb.alb_security_group_id

  iam_instance_profile = var.iam_instance_profile
  allowed_ingress_cidr = [module.vpc.vpc_cidr]
  http_ingress_cidrs   = var.http_ingress_cidrs
  https_ingress_cidrs  = var.https_ingress_cidrs
  keypair_bucket_name  = var.keypair_bucket_name

  root_volume_size      = var.root_volume_size
  root_volume_type      = var.root_volume_type
  root_volume_encrypted = var.root_volume_encrypted

  tags = var.tags
}

module "rds" {
  source = "../../modules/rds"

  environment                = var.environment
  vpc_id                     = module.vpc.vpc_id
  private_subnet_ids         = [module.vpc.private_subnet_ids[0]]
  allowed_security_group_ids = [module.ec2.aws_security_group_ids]

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  db_name  = var.db_name
  username = var.username
  password = var.password

  allocated_storage            = var.allocated_storage
  storage_type                 = var.storage_type
  storage_encrypted            = var.storage_encrypted
  multi_az                     = var.multi_az
  publicly_accessible          = var.publicly_accessible
  backup_retention_period      = var.backup_retention_period
  skip_final_snapshot          = var.skip_final_snapshot
  performance_insights_enabled = var.performance_insights_enabled
  monitoring_interval          = var.monitoring_interval
  monitoring_role_arn          = var.monitoring_role_arn
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  maintenance_window           = var.maintenance_window
  deletion_protection          = var.deletion_protection

  tags = var.tags
}

module "alb" {
  source = "../../modules/alb"

  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
  name        = var.alb_name
  internal    = var.internal
  target_type = var.target_type

  enable_deletion_protection = var.enable_deletion_protection
  access_logs_enabled        = var.access_logs_enabled
  access_logs_bucket         = var.access_logs_bucket
  access_logs_prefix         = var.access_logs_prefix

  enable_http = var.enable_http
  # enable_https = true
  # certificate_arn = "arn:aws:acm:ap-south-1:051826706795:certificate/your-certificate-id"

  idle_timeout          = var.idle_timeout
  target_group_port     = var.target_group_port
  target_group_protocol = var.target_group_protocol
  health_check_path     = var.health_check_path
  health_check_interval = var.health_check_interval
  health_check_timeout  = var.health_check_timeout
  healthy_threshold     = var.healthy_threshold
  unhealthy_threshold   = var.unhealthy_threshold
  matcher_http_code     = var.matcher_http_code

  tags = var.tags
}

module "waf" {
  source = "../../modules/waf"

  environment = var.environment

  name        = var.waf_name
  description = var.description
  scope       = var.scope

  default_action = var.default_action

  resource_arn = module.alb.aws_lb_arn

  enable_aws_managed_rules   = var.enable_aws_managed_rules
  enable_rate_limit_rule     = var.enable_rate_limit_rule
  enable_logging             = var.enable_logging
  log_destination_arn        = var.log_destination_arn
  cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
  metric_name                = var.metric_name
  sampled_requests_enabled   = var.sampled_requests_enabled

  tags = var.tags
}

