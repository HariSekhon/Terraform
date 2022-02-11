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
#        Cloudflare Firewall - Webtrends Optimize (not Webtrends proper)
# ============================================================================ #

# Webtrends Optimize was sold by Webtrends to a smaller company - so this is not Webtrends source IPs

locals {
  webtrends_optimize_IPs = [
    "213.123.137.249",
    "62.31.105.234"
  ]
}

resource "cloudflare_filter" "webtrends-optimize" {
  zone_id     = var.zone_id
  description = "Webtrends Optimize IPs"
  expression  = "( ip.src in { ${join("\n", local.webtrends_optimize_IPs)} } )"
}

resource "cloudflare_firewall_rule" "webtrends-optimize" {
  zone_id     = var.zone_id
  description = "Webtrends Optimize"
  filter_id   = cloudflare_filter.webtrends-optimize.id
  action      = "allow"
  priority    = 5600
}
