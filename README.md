# Terraform Templates

[![GitHub stars](https://img.shields.io/github/stars/HariSekhon/Terraform?logo=github)](https://github.com/HariSekhon/Terraform//stargazers)
[![GitHub forks](https://img.shields.io/github/forks/HariSekhon/Terraform?logo=github)](https://github.com/HariSekhon/Terraform/network)
[![Lines of Code](https://img.shields.io/badge/lines%20of%20code-2k-lightgrey?logo=codecademy)](https://github.com/HariSekhon/Terraform)
[![License](https://img.shields.io/github/license/HariSekhon/Terraform)](https://github.com/HariSekhon/Terraform/blob/master/LICENSE)
[![My LinkedIn](https://img.shields.io/badge/LinkedIn%20Profile-HariSekhon-blue?logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIGZpbGw9IiNmZmZmZmYiIHZpZXdCb3g9IjAgMCAyNCAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+TGlua2VkSW48L3RpdGxlPjxwYXRoIGQ9Ik0yMC40NDcgMjAuNDUyaC0zLjU1NHYtNS41NjljMC0xLjMyOC0uMDI3LTMuMDM3LTEuODUyLTMuMDM3LTEuODUzIDAtMi4xMzYgMS40NDUtMi4xMzYgMi45Mzl2NS42NjdIOS4zNTFWOWgzLjQxNHYxLjU2MWguMDQ2Yy40NzctLjkgMS42MzctMS44NSAzLjM3LTEuODUgMy42MDEgMCA0LjI2NyAyLjM3IDQuMjY3IDUuNDU1djYuMjg2ek01LjMzNyA3LjQzM2MtMS4xNDQgMC0yLjA2My0uOTI2LTIuMDYzLTIuMDY1IDAtMS4xMzguOTItMi4wNjMgMi4wNjMtMi4wNjMgMS4xNCAwIDIuMDY0LjkyNSAyLjA2NCAyLjA2MyAwIDEuMTM5LS45MjUgMi4wNjUtMi4wNjQgMi4wNjV6bTEuNzgyIDEzLjAxOUgzLjU1NVY5aDMuNTY0djExLjQ1MnpNMjIuMjI1IDBIMS43NzFDLjc5MiAwIDAgLjc3NCAwIDEuNzI5djIwLjU0MkMwIDIzLjIyNy43OTIgMjQgMS43NzEgMjRoMjAuNDUxQzIzLjIgMjQgMjQgMjMuMjI3IDI0IDIyLjI3MVYxLjcyOUMyNCAuNzc0IDIzLjIgMCAyMi4yMjIgMGguMDAzeiIvPjwvc3ZnPgo=)](https://www.linkedin.com/in/HariSekhon/)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/HariSekhon/Terraform?logo=github)](https://github.com/HariSekhon/Terraform/commits/master)

[![CI Builds Overview](https://img.shields.io/badge/CI%20Builds-Overview%20Page-blue?logo=circleci)](https://harisekhon.github.io/CI-CD/)
[![Fmt](https://github.com/HariSekhon/Terraform/actions/workflows/terraform-fmt-write.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/terraform-fmt-write.yaml)
[![YAML](https://github.com/HariSekhon/Terraform/actions/workflows/yaml.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/yaml.yaml)
[![ShellCheck](https://github.com/HariSekhon/Terraform/actions/workflows/shellcheck.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/shellcheck.yaml)
[![Validation](https://github.com/HariSekhon/Terraform/actions/workflows/validate.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/validate.yaml)
[![tfsec](https://github.com/HariSekhon/Terraform/actions/workflows/tfsec.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/tfsec.yaml)
[![Checkov](https://github.com/HariSekhon/Terraform/actions/workflows/checkov.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/checkov.yaml)
[![Grype](https://github.com/HariSekhon/Terraform/actions/workflows/grype.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/grype.yaml)
[![Kics](https://github.com/HariSekhon/Terraform/actions/workflows/kics.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/kics.yaml)
[![Semgrep](https://github.com/HariSekhon/Terraform/actions/workflows/semgrep.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/semgrep.yaml)
[![Semgrep Cloud](https://github.com/HariSekhon/Terraform/actions/workflows/semgrep-cloud.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/semgrep-cloud.yaml)
[![Trivy](https://github.com/HariSekhon/Terraform/actions/workflows/trivy.yaml/badge.svg)](https://github.com/HariSekhon/Terraform/actions/workflows/trivy.yaml)

[![Repo on GitHub](https://img.shields.io/badge/repo-GitHub-2088FF?logo=github)](https://github.com/HariSekhon/Terraform)
[![Repo on GitLab](https://img.shields.io/badge/repo-GitLab-FCA121?logo=gitlab)](https://gitlab.com/HariSekhon/Terraform)
[![Repo on Azure DevOps](https://img.shields.io/badge/repo-Azure%20DevOps-0078D7?logo=azure%20devops)](https://dev.azure.com/harisekhon/GitHub/_git/Terraform)
[![Repo on BitBucket](https://img.shields.io/badge/repo-BitBucket-0052CC?logo=bitbucket)](https://bitbucket.org/HariSekhon/Terraform)

[git.io/tf-templates](https://git.io/tf-templates)

Terraform templates for AWS / GCP / Azure.

Forked from the [Templates](https://github.com/HariSekhon/Templates) repo for which this is now a submodule.

## New

`new.pl` can instantiate these templates as new date-timestamped files, autopopulating the date, vim tags, GitHub URL and other headers and drops you in to your `$EDITOR` of choice (eg. `vim`).

You can give an exact filename like `provider.tf` or `backend.tf` to instantiate that exact template, or any filename ending in `.tfvars` will instantitate some common terraform variables such as `project`, `region`, `vpc_name` etc...  otherwise any filename ending in `tf` will give you a blank terraform template.

Examples:

```bash
new provider.tf
```

```bash
new backend.tf
```

`new.pl` can be found in the [DevOps Perl tools](https://github.com/HariSekhon/DevOps-Perl-tools) repo.

`alias new=new.pl`

(done automatically in the [DevOps Bash tools](https://github.com/HariSekhon/DevOps-Bash-tools) repo `.bash.d/`)

### New Terraform Structure

```bash
new terraform
```

or shorter:

```bash
new tf
```

Instantly creates and opens all standard files for a Terraform deployment in your `$EDITOR` of choice:

- [provider.tf](https://github.com/HariSekhon/Terraform/blob/master/provider.tf)
- [backend.tf](https://github.com/HariSekhon/Terraform/blob/master/backend.tf)
- [variables.tf](https://github.com/HariSekhon/Terraform/blob/master/variables.tf)
- [versions.tf](https://github.com/HariSekhon/Terraform/blob/master/versions.tf)
- [terraform.tfvars](https://github.com/HariSekhon/Terraform/blob/master/terraform.tfvars)
- [main.tf](https://github.com/HariSekhon/Terraform/blob/master/main.tf)

all heavily commented to get a new Terraform environment up and running quickly - with links to things like AWS / GCP regions, Terraform backend providers, state locking etc.

## Troubleshooting

### DeleteConflict: Recreating Resources with Dependencies That Do Not Permit Deletion

Example:
`│Error: error deleting IAM policy arn:aws:iam::***:policy/MYPOLICY: DeleteConflict: Cannot delete a policy attached to entities.`

The Terraform AWS Provider does not help you when you recreate a resource that another resources depends on, such as recreating an IAM policy due to a rename, while it is still attached to a role, or recreating an AWS Batch compute environment while it's still attached to queues.

Unfortunately the Terraform AWS Provider isn't smart enough to know that for such dependencies with AWS specific API constraints that it should simply detach, and then reattach afterwards.

The quickest solution / workaround is to find the dependent resources, and `terraform taint` them so that they are destroyed first using the generic implicit Terraform dependency ordering, eg. the role gets deleted first for recreation because its tainted, then the IAM policy is deleted and recreated with the new name, and then the role is recreated and attached to the new policy.

Example:

`terraform taint <full_path_of_resource_in_terraform_state>`

## Terraform CI/CD

Production-grade Terraform CI/CD pipelines can be found for Jenkins and GitHub Actions in my adjacent repos:

- [Jenkins](https://github.com/HariSekhon/Jenkins) - runs terraform code with a specific version of Terraform:
  - `fmt` (info only)
  - `validate`
  - `plan` (saves plan so apply is this exact plan, recommended)
  - prompts for plan approval
  - runs `apply`
  - has full locking and milestones for Plan and Apply stages for serialized queuing to avoid terraform state lock failures
  - skips intermediate queued runs for efficiency

- [GitHub Actions](https://github.com/HariSekhon/GitHub-Actions) - similar to above, plus:
  - optional environment / approvals (protects admin credentials for things like GitHub which doesn't have read-only repo API tokens)
  - posts the full `terraform plan` result into the Pull Request that triggered the workflow, along with the status of `fmt` & `validate`
  - applies once Pull Request is merged to the default branch or master or main

### Jenkins screenshots

Applied, ignoring informational fmt check:

![](https://github.com/HariSekhon/Diagrams-as-Code/blob/master/screenshots/terraform_applied_but_failed_fmt_check.png)

Plan found no changes so skipped Apply or asking for Approval:

![](https://github.com/HariSekhon/Diagrams-as-Code/blob/master/screenshots/terraform_plan_no_changes.png)

Plan found changes but Approval was not authorized, so Apply did not proceed:

![](https://github.com/HariSekhon/Diagrams-as-Code/blob/master/screenshots/terraform_not_approved.png)

## Stargazers over time

[![Stargazers over time](https://starchart.cc/HariSekhon/Terraform.svg)](https://starchart.cc/HariSekhon/Terraform)

[git.io/tf-templates](https://git.io/tf-templates)

## More Core Repos

<!-- OTHER_REPOS_START -->

### Knowledge

[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=Knowledge-Base&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/Knowledge-Base)
[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=Diagrams-as-Code&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/Diagrams-as-Code)

<!--

Not support on GitHub Markdown:

<iframe src="https://raw.githubusercontent.com/HariSekhon/HariSekhon/main/knowledge.md" width="100%" height="500px"></iframe>

Does nothing:

<embed src="https://raw.githubusercontent.com/HariSekhon/HariSekhon/main/knowledge.md" width="100%" height="500px" />

-->

### DevOps Code

[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=DevOps-Bash-tools&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/DevOps-Bash-tools)
[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=DevOps-Python-tools&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/DevOps-Python-tools)
[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=DevOps-Perl-tools&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/DevOps-Perl-tools)
[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=DevOps-Golang-tools&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/DevOps-Golang-tools)

<!--
[![Gist Card](https://github-readme-stats.vercel.app/api/gist?id=f8f551332440f1ca8897ff010e363e03)](https://gist.github.com/HariSekhon/f8f551332440f1ca8897ff010e363e03)
-->

### Containerization

[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=Kubernetes-configs&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/Kubernetes-configs)
[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=Dockerfiles&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/Dockerfiles)

### CI/CD

[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=GitHub-Actions&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/GitHub-Actions)
[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=Jenkins&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/Jenkins)

### DBA - SQL

[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=SQL-scripts&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/SQL-scripts)

### DevOps Reloaded

[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=Nagios-Plugins&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/Nagios-Plugins)
[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=HAProxy-configs&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/HAProxy-configs)
[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=Terraform&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/Terraform)
[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=Packer-templates&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/Packer-templates)
[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=Nagios-Plugin-Kafka&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/Nagios-Plugin-Kafka)

### Templates

[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=Templates&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/Templates)
[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=Template-repo&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/Template-repo)

### Misc

[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=Spotify-tools&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/Spotify-tools)
[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=HariSekhon&repo=Spotify-playlists&theme=ambient_gradient&description_lines_count=3)](https://github.com/HariSekhon/Spotify-playlists)

The rest of my original source repos are
[here](https://github.com/HariSekhon?tab=repositories&q=&type=source&language=&sort=stargazers).

Pre-built Docker images are available on my [DockerHub](https://hub.docker.com/u/harisekhon/).

<!-- 1x1 pixel counter to record hits -->
![](https://hit.yhype.me/github/profile?user_id=2211051)

<!-- OTHER_REPOS_END -->
