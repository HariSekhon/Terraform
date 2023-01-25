#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2023-01-25 19:23:33 +0000 (Wed, 25 Jan 2023)
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
#                       A W S   S S O   U s e r   D a t a
# ============================================================================ #

# populate AWS SSO user data to assign to built-in permsets

locals {
  sso_users = [
    "hari.sekhon@domain.com",
    "devops2@domain.com",
    "devops3@domain.com",
  ]
}

data "aws_ssoadmin_instances" "azure" {}

data "aws_identitystore_user" "it" {
  for_each          = toset(local.sso_users)
  identity_store_id = tolist(data.aws_ssoadmin_instances.azure.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "UserName"
      attribute_value = each.key
    }
  }
}
