#########################
#########GLOBAL##########
#########################

environment = "stage"

tags = {
  Project     = "AWS-2-Tier-App"
  Environment = "Stage"
}

#########################
###########VPC###########
#########################

vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
enable_dns_support   = true
enable_dns_hostnames = true
aws_internet_gateway = "igw"

#########################
###########EC2###########
#########################

ami_id         = "ami-00ca570c1b6d79f36"
instance_type  = "t3a.micro"
instance_count = 1

iam_instance_profile = "EC2-SSM-Role"
http_ingress_cidrs   = ["0.0.0.0/0"]
https_ingress_cidrs  = ["0.0.0.0/0"]
keypair_bucket_name  = "practice-terraform-states-bucket"

root_volume_size      = 30
root_volume_type      = "gp3"
root_volume_encrypted = false

#########################
###########RDS###########
#########################

engine         = "mysql"
engine_version = "8.4.7"
instance_class = "db.t3.micro"

db_name  = "stage_db"
username = "admin"
password = "Stage1234"

allocated_storage            = 20
storage_type                 = "gp3"
storage_encrypted            = false
multi_az                     = false
publicly_accessible          = false
backup_retention_period      = 7
skip_final_snapshot          = true
performance_insights_enabled = false
monitoring_interval          = 60
monitoring_role_arn          = "arn:aws:iam::051826706795:role/RDS-Enhanced-Monitoring-IAM-ROLE"
auto_minor_version_upgrade   = false
maintenance_window           = "sat:12:00-sat:12:30"
deletion_protection          = false
parameter_group_name         = "stage-mysql-custom-pg"
parameter_group_family       = "mysql8.4"
parameter_group_description  = "Custom MySQL Parameter Group"

#########################
###########ALB###########
#########################

alb_name    = "App"
internal    = false
target_type = "instance"

enable_deletion_protection = false
access_logs_enabled        = false
access_logs_bucket         = "hospital-management-app-alb-access-logs-bucket"
access_logs_prefix         = "stage"

enable_http = true
# enable_https = true
# certificate_arn = "arn:aws:acm:ap-south-1:051826706795:certificate/your-certificate-id"

idle_timeout             = 60
target_group_port        = 3000
target_group_protocol    = "HTTP"
health_check_path        = "/health"
health_check_interval    = 60
health_check_timeout     = 30
healthy_threshold        = 5
unhealthy_threshold      = 2
tg_health_check_timeout  = 30
tg_health_check_interval = 60
matcher_http_code        = "200-399"

#########################
###########WAF###########
#########################

waf_name    = "app"
description = "This is a Stage environment WAF Web ACL"
scope       = "REGIONAL"

default_action = "allow"

enable_aws_managed_rules   = true
enable_rate_limit_rule     = true
enable_logging             = true
log_destination_arn        = "arn:aws:logs:ap-south-1:051826706795:log-group:stage-app-waf-web-acl-log-group:*"
cloudwatch_metrics_enabled = true
metric_name                = "stage-app-waf"
sampled_requests_enabled   = false

#########################
###########SNS###########
#########################

topic_name          = "stage-sns"
email_subscriptions = ["utkarsh.r@cloudworkmates.com"]

#########################
#######CLOUDWATCH########
#########################

#Variables will be added using modules.
