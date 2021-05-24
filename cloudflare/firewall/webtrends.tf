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
#         C l o u d f l a r e   F i r e w a l l   -   W e b t r e n d s
# ============================================================================ #

locals {
  webtrends_IPs = [
    "213.123.137.249",
    "62.31.105.234"
  ]
}

resource "cloudflare_filter" "webtrends" {
  zone_id     = var.zone_id
  description = "Webtrends IPs"
  expression  = "( ip.src in { ${join("\n", local.webtrends_IPs)} } )"
}

resource "cloudflare_firewall_rule" "webtrends" {
  zone_id     = var.zone_id
  description = "Webtrends"
  filter_id   = cloudflare_filter.webtrends.id
  action      = "allow"
}
