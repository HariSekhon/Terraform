#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2021-05-12 16:55:25 +0100 (Wed, 12 May 2021)
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
#        C l o u d f l a r e   F i r e w a l l   -   G o C a r d l e s s
# ============================================================================ #

locals {
  # https://developer.gocardless.com/api-reference/#overview-approved-ip-addresses
  gocardless_IPs = [
    "35.204.73.47",
    "35.204.191.250",
    "35.204.214.181"
  ]
}

resource "cloudflare_filter" "gocardless" {
  zone_id     = var.zone_id
  description = "GoCardless IPs"
  expression  = "( ip.src in { ${join("\n", local.gocardless_IPs)} } )"
}

resource "cloudflare_firewall_rule" "gocardless" {
  zone_id     = var.zone_id
  description = "GoCardless"
  filter_id   = cloudflare_filter.gocardless.id
  action      = "allow"
  priority    = 5530
}
