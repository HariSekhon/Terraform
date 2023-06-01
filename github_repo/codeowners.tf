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

# https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners
#
# https://git-scm.com/docs/gitignore#_pattern_format

# teams must be set to "closed" (visible in the UI), not "secret", otherwise they'll appear in PR draft but disappear in PR, looking like a bug, but it's expected behaviour, team visibility is a requirement

resource "github_repository_file" "codeowners" {
  repository = github_repository.repo.name
  branch     = data.github_repository.repo.default_branch
  file       = ".github/CODEOWNERS"
  # permit codeowners override in module caller using var below instead
  #content       = ".github/ @myorg/devops-team"
  # ensure there is a newline at end of file via EOT style so people with IDEs or pre-commit hooks aren't changing the file during PRs
  # XXX: Edit the MYORG/DEVOPS-TEAM with your actual github team (which must be Visible aka "closed" in Terraform)
  #%{if var.codeowners != ""}${var.codeowners}%{else}.github/ @MYORG/DEVOPS-TEAM%{endif}
  content        = <<EOF
# Managed by Terraform - DO NOT EDIT
CODEOWNERS          @MYORG/DEVOPS-TEAM
.github/            @MYORG/DEVOPS-TEAM
**devops**          @MYORG/DEVOPS-TEAM
**infrastructure**  @MYORG/DEVOPS-TEAM
**infra**           @MYORG/DEVOPS-TEAM
**terraform**       @MYORG/DEVOPS-TEAM
**docker**          @MYORG/DEVOPS-TEAM
**kubernetes**      @MYORG/DEVOPS-TEAM
**k8s**             @MYORG/DEVOPS-TEAM
**Dockerfile**      @MYORG/DEVOPS-TEAM
**Jenkinsfile**     @MYORG/DEVOPS-TEAM
**cloudbuild.y*ml** @MYORG/DEVOPS-TEAM
**.envrc**          @MYORG/DEVOPS-TEAM
${var.codeowners}
EOF
  commit_message = "CODEOWNERS managed by Terraform"
  # requires both or neither - uses the account owning the github token as the author if omitted
  #commit_author = "Terraform"
  #commit_email  = "terraform@MYCOMPANY.COM"
  overwrite_on_create = false

  lifecycle {
    ignore_changes = [
      commit_message,
      overwrite_on_create
    ]
  }
}
