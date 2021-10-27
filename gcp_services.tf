#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: [% DATE # 2021-07-23 10:32:00 +0100 (Fri, 23 Jul 2021) %]
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
#      T e r r a f o r m   -   G C P   S e r v i c e s   t o   E n a b l e
# ============================================================================ #

# example of automating the Cloud Functions backup with Terraform
#
# https://medium.com/better-programming/how-to-automate-google-cloud-sql-backups-2de6d3cc7d01

locals {
  # GCP enable these services
  services_to_enable = [
    "cloudscheduler.googleapis.com",
    "sqladmin.googleapis.com",
    "cloudfunctions.googleapis.com"
  ]
}

resource "google_project_service" "service" {
  for_each = toset(local.services_to_enable)
  project  = var.project_id
  service  = each.value
}
