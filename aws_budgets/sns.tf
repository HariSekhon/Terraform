resource "aws_sns_topic" "aws-charges" {
  name = "AWS_Charges"
}

data "aws_caller_identity" "current" {}

resource "aws_sns_topic_policy" "aws-charges" {
  arn    = aws_sns_topic.aws-charges.arn
  policy = data.aws_iam_policy_document.aws-charges-sns-topic-policy.json
}

data "aws_iam_policy_document" "aws-charges-sns-topic-policy" {
  policy_id = "__default_policy_ID"

  statement {
    sid = "__default_statement_ID"
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        #var.account-id,
        data.aws_caller_identity.current.account_id
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.aws-charges.arn,
    ]
  }

  statement {
    sid = "AWSBudgets-notification"
    actions = [
      "SNS:Publish",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["budgets.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.aws-charges.arn,
    ]
  }
}

resource "aws_sns_topic_subscription" "aws-charges" {
  topic_arn = aws_sns_topic.aws-charges.arn
  protocol  = "email"
  endpoint  = var.email
  # no longer needed in Terraform 1.2.0
  #lifecycle {
  #  ignore_changes = [pending_confirmation]
  #}
}

data "aws_sns_topic" "aws-charges" {
  name       = "AWS_Charges"
  depends_on = [aws_sns_topic.aws-charges]
}
