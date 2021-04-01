#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2021-04-01 11:10:59 +0100 (Thu, 01 Apr 2021)
#
#  https://github.com/HariSekhon/Terraform-templates
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# ============================================================================ #
#                             G C P   B u c k e t s
# ============================================================================ #

                                # XXX: edit
resource "google_storage_bucket" "mybucket" {
                                                   # XXX: edit
  name                        = "${var.project_name}-mybucket"
  location                    = "EU"
  uniform_bucket_level_access = true # XXX: GCS defaults to fine-grained security otherwise, which is more likely to have a human misconfiguration data leak
}
