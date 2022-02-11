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
#               C l o u d f l a r e   F i r e w a l l   -   V P N
# ============================================================================ #

locals {
  VPN_IPs = [
    # XXX: Edit
    "x.x.x.x"
  ]
}

resource "cloudflare_filter" "vpn" {
  zone_id     = var.zone_id
  description = "VPN IPs"
  expression  = "( ip.src in { ${join("\n", local.VPN_IPs)} } )"
}

resource "cloudflare_firewall_rule" "vpn" {
  zone_id     = var.zone_id
  description = "VPN"
  filter_id   = cloudflare_filter.vpn.id
  action      = "allow"
  priority    = 5590
}
