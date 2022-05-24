#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2022-03-01 12:00:27 +0000 (Tue, 01 Mar 2022)
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
#                      GitHub Teams Repository Permissions
# ============================================================================ #


# manually list select repos a given team can access and then for_each it further down
locals {
  devs_team_repos = [
    "myrepo1",
    "myrepo2",
  ]
}

resource "github_team_repository" "devs-team" {
  permission = "push"
  for_each   = toset(local.devs_team_repos)
  repository = each.key
  team_id    = github_team.devs.id
  # if generated via a for_each as per adjacent github_team.tf
  #team_id    = github_team.team["devs"].id
}

# ============================================================================ #
# XXX: Dynamically adding team to all repos is better done in github_repo module with self references for proper dependency ordering (can't depends_on dynamic generated references, must be statically resolvable)

# works around Terraform splat expressions not supporting top-level resource globbing of 1.1.x :'-(
#
#    https://github.com/hashicorp/terraform/issues/19931
#
data "external" "github_repos" {
  # https://github.com/HariSekhon/DevOps-Bash-tools
  program = ["/path/to/devops-bash-tools/terraform_resources.sh", "github_repository"]
}

# automatically find and grant admin on all GitHub repositories to the devops team
resource "github_team_repository" "devops" {
  permission = "admin"
  # not supported as of 1.1.x :'-(
  #for_each   = github_repository[*].name
  for_each   = data.external.github_repos.result
  repository = each.key
  team_id    = github_team.devops.id

  lifecycle {
    # XXX: doesn't prevent destroy when the entire resource code block is removed!
    prevent_destroy = true
  }
}
