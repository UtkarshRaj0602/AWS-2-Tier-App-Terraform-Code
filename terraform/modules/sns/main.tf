resource "aws_sns_topic" "this" {
  name = "${var.environment}-${var.topic_name}"

  tags = merge(var.tags, {
    Name        = "${var.environment}-${var.topic_name}"
    Environment = var.environment
  })
}

resource "aws_sns_topic_subscription" "email" {
  for_each = toset(var.email_subscriptions)

  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = each.value
}
