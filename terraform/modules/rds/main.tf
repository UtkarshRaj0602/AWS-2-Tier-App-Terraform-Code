resource "aws_db_instance" "this" {
  identifier     = "${var.environment}-rds-instance"
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  db_name  = var.db_name
  username = var.username
  password = var.password

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]

  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type
  storage_encrypted = var.storage_encrypted

  multi_az            = var.multi_az
  publicly_accessible = var.publicly_accessible

  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot

  #   parameter_group_name            = var.parameter_group_name
  #   availability_zone               = var.availability_zone
  #   option_group_name               = var.option_group_name
  #   kms_key_id                      = var.kms_key_id
  #   ca_cert_identifier              = var.ca_cert_identifier
  performance_insights_enabled = var.performance_insights_enabled
  monitoring_interval          = var.monitoring_interval
  monitoring_role_arn          = var.monitoring_role_arn
  #   enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  maintenance_window         = var.maintenance_window
  deletion_protection        = var.deletion_protection

  tags = merge(var.tags, {
    "Name"        = "${var.environment}-rds-instance"
    "Environment" = var.environment
  })
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.environment}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.tags, {
    "Name"        = "${var.environment}-rds-subnet-group"
    "Environment" = var.environment
  })
}

resource "aws_security_group" "this" {
  name        = "${var.environment}-rds-sg"
  vpc_id      = var.vpc_id
  description = "Security group for RDS instance"

  tags = merge(var.tags, {
    "Name"        = "${var.environment}-rds-sg"
    "Environment" = var.environment
  })
}

resource "aws_security_group_rule" "mysql_ingress" {
  count = length(var.allowed_security_group_ids)

  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.this.id
  source_security_group_id = var.allowed_security_group_ids[count.index]
}
