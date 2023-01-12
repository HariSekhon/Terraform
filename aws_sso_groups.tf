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
#                 A W S   S S O   G r o u p s   f r o m   I D P
# ============================================================================ #

# create Terraform data references to be able to assign users to these groups

locals {
  aws_sso_groups = [
    #"AWSAccountFactory",
    #"AWSAuditAccountAdmins",
    "AWSControlTowerAdmins",
    #"AWSLogArchiveAdmins",
    #"AWSLogArchiveViewers",
    #"AWSSecurityAuditPowerUsers",
    #"AWSSecurityAuditors",
    #"AWSServiceCatalogAdmins",
    "azure-ad--aws-admins-group",
  ]
}

data "aws_identitystore_group" "group" {
  for_each          = toset(local.aws_sso_groups)
  identity_store_id = local.sso_idp # set in aws_sso.tf
  filter {
    attribute_path  = "DisplayName"
    attribute_value = each.key
  }
}
