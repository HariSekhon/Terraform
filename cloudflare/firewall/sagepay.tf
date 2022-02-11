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
#           C l o u d f l a r e   F i r e w a l l   -   S a g e P a y
# ============================================================================ #

locals {
  sagepay_IPs = [
    "195.170.169.0/24",
  ]
}

resource "cloudflare_filter" "sagepay" {
  zone_id     = var.zone_id
  description = "SagePay IPs"
  expression  = "( ip.src in { ${join("\n", local.sagepay_IPs)} } )"
}

resource "cloudflare_firewall_rule" "sagepay" {
  zone_id     = var.zone_id
  description = "SagePay"
  filter_id   = cloudflare_filter.sagepay.id
  action      = "allow"
  priority    = 5570
}
