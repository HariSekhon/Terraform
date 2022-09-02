resource "aws_budgets_budget" "aws-charges" {
  name              = var.name
  budget_type       = "COST"
  limit_amount      = var.budget
  limit_unit        = "USD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2021-08-01_00:00"
  time_unit         = "MONTHLY"

  #cost_filter {
  #}
  cost_types {
    # XXX: in testing if credit/refund are true this prevents/delays the thresholds from triggering when created
    include_credit             = false # XXX: should be false, see note above
    include_discount           = true
    include_other_subscription = true
    include_recurring          = true
    include_refund             = false # XXX: should be false, see note above
    include_subscription       = true
    include_support            = true
    include_tax                = true
    include_upfront            = true
    use_blended                = false
  }

  notification {
    comparison_operator       = "GREATER_THAN"
    threshold                 = var.threshold_percent # eg 80%
    threshold_type            = "PERCENTAGE"
    notification_type         = "FORECASTED"
    subscriber_sns_topic_arns = [data.aws_sns_topic.aws-charges.arn]
    #subscriber_email_addresses = ["me@domain.com"]
  }
  notification {
    comparison_operator       = "GREATER_THAN"
    threshold                 = var.threshold_percent
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_sns_topic_arns = [data.aws_sns_topic.aws-charges.arn]
  }
  notification {
    comparison_operator       = "GREATER_THAN"
    threshold                 = 100
    threshold_type            = "PERCENTAGE"
    notification_type         = "FORECASTED"
    subscriber_sns_topic_arns = [data.aws_sns_topic.aws-charges.arn]
  }
  notification {
    comparison_operator       = "GREATER_THAN"
    threshold                 = 100
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_sns_topic_arns = [data.aws_sns_topic.aws-charges.arn]
  }
  depends_on = [data.aws_sns_topic.aws-charges]
}
