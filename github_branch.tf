#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2022-03-01 14:55:25 +0000 (Tue, 01 Mar 2022)
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
#                GitHub Branch, Default & Branch Protection Rules
# ============================================================================ #

# XXX: This is better done in github_repo module with self references for proper dependency ordering (can't depends_on dynamic generated references, must be statically resolvable)

data "external" "github_repos_node_ids" {
  # https://github.com/HariSekhon/DevOps-Bash-tools
  program = ["/path/to/devops-bash-tools/terraform_resources.sh", "github_repository", "node_ids"]
}

# only useful to create subsequent branches, errors out if trying to create initial main branch, must use auto_init in github_repo instead
#resource "github_branch" "dev" {
#  # not supported as of 1.1.x :'-(
#  #for_each   = github_repository[*].name
#  for_each   = data.external.github_repos.result
#  repository = each.key
#  branch     = "main"
#
#  lifecycle {
# XXX: doesn't prevent destroy when the entire resource code block is removed!
#    prevent_destroy = true
#  }
#}

resource "github_branch_default" "main" {
  for_each   = data.external.github_repos.result
  repository = each.key
  branch     = "main"
}

resource "github_branch_protection" "main" {
  for_each      = data.external.github_repos_node_ids.result
  repository_id = each.value

  pattern             = "main"
  enforce_admins      = false # true prevents Terraform account from updating CODEOWNERS or other files
  allows_deletions    = false
  allows_force_pushes = false

  require_signed_commits          = false
  required_linear_history         = false
  require_conversation_resolution = false

  #required_status_checks {
  #  strict   = false
  #  contexts = []
  #}
  # may want to add to this on a per repo basis and not have it standardized
  lifecycle {
    # XXX: doesn't prevent destroy when the entire resource code block is removed!
    prevent_destroy = true
    ignore_changes = [
      required_status_checks
    ]
  }

  #required_pull_request_reviews {
  #  required_approving_review_count = 0  # XXX: set to 1 to enforce mandatory reviews before PR merges
  #  require_code_owner_reviews: false    # XXX: set to true to enforce CODEOWNERS
  #  dismiss_stale_reviews  = false       # XXX: set to true to prevent slip throughs
  #  restrict_dismissals    = false
  #  #dismissal_restrictions = [
  #  #  data.github_user.harisekhon.node_id,
  #  #  github_team.devops.node_id,
  #  #]
  #}

  push_restrictions = [
    # limited to a list of one type of restriction (user, team, app)
    #data.github_user.harisekhon.node_id,
    #github_team.devops.node_id
  ]

}
