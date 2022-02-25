#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2022-02-24 20:22:12 +0000 (Thu, 24 Feb 2022)
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
#                             G i t H u b   R e p o
# ============================================================================ #

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository

# See this script to find any repos that exist in GitHub but not Terraform to find any manually created repos:
#
#   github_repos_not_in_terraform.sh
#
#     https://github.com/HariSekhon/DevOps-Bash-tools

resource "github_repository" "NAME" {
  name        = "NAME"
  description = ""

  allow_rebase_merge     = false
  delete_branch_on_merge = true # clean up branches automatically after merge
  has_downloads          = true
  has_issues             = true
  has_wiki               = false      # use a real wiki, don't let people write here
  visibility             = "private" # or "public", or "internal" (available only in an Org)
  vulnerability_alerts   = true

  topics = [
  ]
}
