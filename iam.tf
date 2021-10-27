#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2021-02-11 13:04:18 +0000 (Thu, 11 Feb 2021)
#
#  https://github.com/HariSekhon/Terraform
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon

# ============================================================================ #
#                                     I A M
# ============================================================================ #

# =======
# GCP IAM
#
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam

resource "google_project_iam_member" "project-editors" {

  # to find the role id which doesn't quite correspond to the human names in GCP Console UI, run this:
  #
  #   gcloud projects get-iam-policy <myproject>
  #
  role = "roles/editor"

  # XXX: edit this - don't put individuals users in here please, it's hard to maintain
  member = "group:admins@mydomain.com"
}

resource "google_project_iam_member" "cloudsql-viewer" {
  role = "roles/cloudsql.viewer"
  # XXX: edit this
  member = "serviceAccount:cloud-function-sql-backup@<MYPROJECT>.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "cloudsql-client" {
  role = "roles/cloudsql.client"
  # XXX: edit this
  member = "serviceAccount:cloud-function-sql-backup@<MYPROJECT>.iam.gserviceaccount.com"
}
