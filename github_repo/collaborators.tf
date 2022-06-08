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
#                            Individual Collaborators
# ============================================================================ #

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborator

resource "github_repository_collaborator" "ci" {
  repository = github_repository.repo.id
  username   = "my-ci-machine-user"
  #permission = var.ci_permission # may need to set this to "admin" if using this account to run Terraform CI/CD
  permission = "admin"
}

resource "github_user_invitation_accepter" "ci" {
  invitation_id = github_repository_collaborator.ci.invitation_id
}
