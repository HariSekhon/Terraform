#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2021-03-04 18:19:03 +0000 (Thu, 04 Mar 2021)
#
#  https://github.com/HariSekhon/terraform
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# ============================================================================ #
#                              C l o u d f l a r e
# ============================================================================ #

locals {

  # obtained from the Cloudflare API:
  #
  #   cloudflare_zones.sh
  #
  # XXX: Edit
  cloudflare_zone_id = "..."

}

module "firewall" {
  source             = "./cloudflare/firewall"
  cloudflare_email   = var.cloudflare_email
  cloudflare_api_key = var.cloudflare_api_key
  zone_id            = local.cloudflare_zone_id
}
