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
#            C l o u d f l a r e   F i r e w a l l   -   R a p i d 7
# ============================================================================ #

locals {
  rapid7_IPs = [
    "35.156.166.245",
    "172.104.153.232",
    "35.158.144.37"
  ]
}

resource "cloudflare_filter" "rapid7" {
  zone_id     = var.zone_id
  description = "Rapid7 IPs"
  expression  = "( ip.src in { ${join(" ", local.rapid7_IPs)} } )"
}

resource "cloudflare_firewall_rule" "rapid7" {
  zone_id     = var.zone_id
  description = "Rapid7"
  filter_id   = cloudflare_filter.rapid7.id
  action      = "allow"
}
