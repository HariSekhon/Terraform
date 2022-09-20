#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2022-09-02 09:54:20 +0100 (Fri, 02 Sep 2022)
#
#  https://github.com/HariSekhon/Terraform
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# ============================================================================ #
#                                 A W S   S S O
# ============================================================================ #

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_account_assignment

# Data source to get the SSO ARN + IDP ID
data "aws_ssoadmin_instances" "my" {}

# ====================

locals {
  # Convenience variables for shortness - would use var instead of local if this wasn't really tied to the specific account, modules across accounts won't add much here
  sso_arn = tolist(data.aws_ssoadmin_instances.my.arns)[0]
  sso_idp = tolist(data.aws_ssoadmin_instances.my.identity_store_ids)[0]

  # get the IDP ID from:
  #
  #  https://eu-west-2.console.aws.amazon.com/singlesignon/identity/home?region=eu-west-2#!/settings
  #
  # get the group list via this AWS CLI command:
  #
  #   aws identitystore list-groups --identity-store-id d-1a234567b8 | jq -r '.Groups[].DisplayName' | sort | sed 's/^/  "/; s/$/",/'
  #
  groups = [
    "admins",
  ]
}

# ====================
# Output all available SSO + IDP
#
output "aws-sso-arns" {
  value = data.aws_ssoadmin_instances.my.arns # a set
}

output "aws-sso-identity_store_ids" {
  value = data.aws_ssoadmin_instances.my.identity_store_ids # a set
}

# ====================
# Show the SSO + IDP we're working on
#
output "aws-sso-arn" {
  value = local.sso_arn
}

output "aws-sso-idp" {
  value = local.sso_idp
}

# =======================
# Create a Permission Set

resource "aws_ssoadmin_permission_set" "admin" {
  name         = "AWSAdministratorAccess"
  description  = "Provides full access to AWS services and resources"
  instance_arn = local.sso_arn
  #relay_state      = "https://s3.console.aws.amazon.com/s3/home?region=us-east-1#"
  session_duration = "PT12H" # valid duration, default: PT1H
}

resource "aws_ssoadmin_permission_set" "poweruser" {
  name         = "AWSPowerUserAccess"
  description  = "Provides full access to AWS services and resources, but does not allow management of Users and groups"
  instance_arn = local.sso_arn
  #relay_state      = "https://s3.console.aws.amazon.com/s3/home?region=us-east-1#"
  session_duration = "PT12H" # valid duration, default: PT1H
}

resource "aws_ssoadmin_permission_set" "readonly" {
  name         = "AWSReadOnlyAccess"
  description  = "This policy grants permissions to view resources and basic metadata across all AWS services"
  instance_arn = local.sso_arn
  #relay_state      = "https://s3.console.aws.amazon.com/s3/home?region=us-east-1#"
  session_duration = "PT12H" # valid duration, default: PT1H
}

resource "aws_ssoadmin_permission_set" "org-admin" {
  name         = "AWSOrganizationsFullAccess"
  instance_arn = local.sso_arn
  #relay_state      = "https://s3.console.aws.amazon.com/s3/home?region=us-east-1#"
  session_duration = "PT12H" # valid duration, default: PT1H
}

resource "aws_ssoadmin_permission_set" "catalog-admin" {
  name         = "AWSServiceCatalogAdminFullAccess"
  instance_arn = local.sso_arn
  #relay_state      = "https://s3.console.aws.amazon.com/s3/home?region=us-east-1#"
  session_duration = "PT12H" # valid duration, default: PT1H
}

resource "aws_ssoadmin_permission_set" "catalog-user" {
  name         = "AWSServiceCatalogEndUserAccess"
  instance_arn = local.sso_arn
  #relay_state      = "https://s3.console.aws.amazon.com/s3/home?region=us-east-1#"
  session_duration = "PT12H" # valid duration, default: PT1H
}

resource "aws_ssoadmin_permission_set" "billing" {
  name         = "Billing"
  description  = "Grants Billing access"
  instance_arn = local.sso_arn
  #relay_state      = "https://s3.console.aws.amazon.com/s3/home?region=us-east-1#"
  session_duration = "PT12H" # valid duration, default: PT1H
}

# ===================
# Get the permission set's arn

#data "aws_ssoadmin_permission_set" "admin" {
#  instance_arn = local.sso_arn
#  name         = "AWSAdministratorAccess"
#}
#
#data "aws_ssoadmin_permission_set" "poweruser" {
#  instance_arn = local.sso_arn
#  name         = "AWSPowerUserAccess"
#}
#
#data "aws_ssoadmin_permission_set" "readonly" {
#  instance_arn = local.sso_arn
#  name         = "AWSReadOnlyAccess"
#}

data "aws_ssoadmin_permission_set" "org-admin" {
  instance_arn = local.sso_arn
  name         = "AWSOrganizationsFullAccess"
}

data "aws_ssoadmin_permission_set" "catalog-admin" {
  instance_arn = local.sso_arn
  name         = "AWSServiceCatalogAdminFullAccess"
}

data "aws_ssoadmin_permission_set" "catalog-user" {
  instance_arn = local.sso_arn
  name         = "AWSServiceCatalogEndUserAccess"
}

# =====================
# Get the group's ID by name filter
#
# aws identitystore list-groups --identity-store-id d-1a234567b8 | jq -r '.Groups[].DisplayName' | sort
data "aws_identitystore_group" "my-group" { # XXX: Edit
  identity_store_id = local.sso_idp

  filter {
    attribute_path  = "DisplayName"
    attribute_value = "My Group" # XXX: Edit
  }
}

# =========================================
# Assign

resource "aws_ssoadmin_account_assignment" "admins" {
  #instance_arn       = data.aws_ssoadmin_permission_set.my-permset.instance_arn # should be same as local.sso_arn
  instance_arn       = local.sso_arn
  permission_set_arn = data.aws_ssoadmin_permission_set.my-permset.arn

  principal_id   = data.aws_identitystore_group.my-group.group_id
  principal_type = "GROUP" # should always be group - don't assign things on a per user basis - that is against best practice and maintainability

  target_id   = "012347678910" # Required: AWS Account ID
  target_type = "AWS_ACCOUNT"  # Optional: AWS_ACCOUNT is the only valid value, but if you omit this and then later backport eg. using terraform_import_aws_sso_account_assignment.sh in DevOps Bash tools repo, then this missing field will force replacement unless you add it back in
}

# ==============================
# Attach AWS Managed Policy

resource "aws_ssoadmin_managed_policy_attachment" "my-policy-attachment" {
  instance_arn       = local.sso_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AWSAdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.my-permset.arn
}

# ==============================
# Attach Customer Managed Policy - must already be created in each AWS account where you want this applied

resource "aws_ssoadmin_customer_managed_policy_attachment" "my-customer-policy-attachment" {
  instance_arn       = local.sso_arn
  permission_set_arn = aws_ssoadmin_permission_set.my-permset.arn
  customer_managed_policy_reference {
    name = aws_iam_policy.my-policy.name # define this aws_iam_policy elsewhere
    path = "/"
  }
}

# =============================
# Inline Policy on a Permissions Set - can only be 1 per permission set
data "aws_iam_policy_document" "my-inline-policy-document" {
  statement {
    sid = "1"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

resource "aws_ssoadmin_permission_set_inline_policy" "my-inline-policy" {
  inline_policy = data.aws_iam_policy_document.my-inline-policy-document.json
  #inline_policy      = file("${path.module}/sso_poweruser_policy.json") # for example to lock out access to Secrets Manager
  instance_arn       = local.sso_arn
  permission_set_arn = aws_ssoadmin_permission_set.my-permset.arn
}
