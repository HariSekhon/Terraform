#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2022-07-06 12:24:13 +0100 (Wed, 06 Jul 2022)
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
#                 S e m g r e p   S e c u r i t y   A l e r t s
# ============================================================================ #

resource "github_repository_file" "workflow-semgrep" {
  count               = var.actions_repo ? 0 : 1
  repository          = github_repository.repo.name
  branch              = data.github_repository.repo.default_branch
  file                = ".github/workflows/semgrep.yaml"
  content             = file("${path.module}/../../.github/workflows/semgrep.yaml") # path must be relative to module since Terraform doesn't understand relative to git root
  commit_message      = "Semgrep workflow managed by Terraform"
  overwrite_on_create = true

  lifecycle {
    ignore_changes = [
      commit_message,
      overwrite_on_create
    ]
  }
}
