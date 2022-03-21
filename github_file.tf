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
#                             G i t H u b   F i l e
# ============================================================================ #

# Manage files in one or more GitHub repos, such as CodeOwners, .gitignore, or GitHub Actions workflows

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file#commit_email

resource "github_repository_file" "MYFILE" {
  repository     = github_repository.foo.name
  branch         = "main" # or "master"
  file           = ".gitignore"
  content        = "**/*.tfstate"
  commit_message = "Managed by Terraform"
  # requires both or neither - uses the account owning the github token as the author if omitted
  #commit_author = "Terraform"
  #commit_email  = "terraform@MYCOMPANY.COM"
  overwrite_on_create = true

  lifecycle {
    ignore_changes = [
      commit_message
    ]
  }
}
