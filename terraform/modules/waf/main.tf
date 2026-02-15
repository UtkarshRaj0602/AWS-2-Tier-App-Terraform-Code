resource "aws_wafv2_web_acl" "this" {
  name        = "${var.environment}-${var.name}-waf-web-acl"
  description = var.description
  scope       = var.scope

  default_action {
    dynamic "allow" {
      for_each = var.default_action == "allow" ? [1] : []
      content {}
    }

    dynamic "block" {
      for_each = var.default_action == "block" ? [1] : []
      content {}
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
    metric_name                = var.metric_name
    sampled_requests_enabled   = var.sampled_requests_enabled
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
      metric_name                = "aws-managed-common"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "global-limit-rule"
    priority = 2

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 10000
        aggregate_key_type = "IP"

        # scope_down_statement {
        #   geo_match_statement {
        #     country_codes = ["US", "NL", "IN"]
        #   }
        # }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
      metric_name                = "global-limit-regional"
      sampled_requests_enabled   = true
    }
  }

  tags = merge(var.tags, {
    Name        = "${var.environment}-${var.name}-waf-web-acl"
    Environment = "${var.environment}"
  })
}

resource "aws_wafv2_web_acl_association" "this" {
  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.this.arn
}
