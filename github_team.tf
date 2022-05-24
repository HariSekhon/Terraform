#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2022-02-25 17:21:14 +0000 (Fri, 25 Feb 2022)
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
#                             G i t H u b   T e a m
# ============================================================================ #

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team

# See this script to find any repos that exist in GitHub but not Terraform to find any manually created repos:
#
#   github_teams_not_in_terraform.sh
#
#     https://github.com/HariSekhon/DevOps-Bash-tools

locals {
  github_teams = [
    "team1",
    "team2",
  ]
}

resource "github_team" "team" {
  for_each = toset(local.github_teams)
  name     = each.key

  privacy = "closed" # must be "closed", not "secret", otherwise can't be @mentioned or used in CODEOWNERS for auto PR review requests

  lifecycle {
    # XXX: doesn't prevent destroy when the entire resource code block is removed!
    prevent_destroy = true
  }
}
