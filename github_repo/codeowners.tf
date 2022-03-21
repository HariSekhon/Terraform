#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2022-03-21 16:34:40 +0000 (Mon, 21 Mar 2022)
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
#                       G i t H u b   C o d e O w n e r s
# ============================================================================ #

resource "github_repository_file" "codeowners" {
  repository          = github_repository.repo.name
  branch              = "main" # or "master"
  file                = ".github/CODEOWNERS"
  content             = ".github/** @devops-team" # XXX: Edit
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform"
  commit_email        = "terraform@MYCOMPANY.COM" # XXX: Edit
  overwrite_on_create = true
}
