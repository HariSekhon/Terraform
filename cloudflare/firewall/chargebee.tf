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
#         C l o u d f l a r e   F i r e w a l l   -   C h a r g e B e e
# ============================================================================ #

locals {
  # ChargeBee's NAT gateways - one of the few services without any online IP source documentation
  #                            or even an online API to fetch these from so have to be hardcoded
  chargebee_IPs = [
    "18.210.240.138",
    "18.232.249.243",
    "3.209.65.25",
    "3.215.11.205",
    "3.228.118.137",
    "3.229.12.56",
    "3.230.149.90",
    "3.231.198.174",
    "3.231.48.173",
    "3.233.249.52",
    "34.195.242.184",
    "34.206.183.55",
    "35.168.199.245",
    "52.203.173.152",
    "52.205.125.34",
    "52.45.227.101",
    "54.158.181.196",
    "54.163.233.122",
    "54.166.107.32",
    "54.84.202.184"
  ]
}

resource "cloudflare_filter" "chargebee" {
  zone_id     = var.zone_id
  description = "ChargeBee IPs"
  expression  = "( ip.src in { ${join("\n", local.chargebee_IPs)} } )"
}

resource "cloudflare_firewall_rule" "chargebee" {
  zone_id     = var.zone_id
  description = "ChargeBee"
  filter_id   = cloudflare_filter.chargebee.id
  action      = "allow"
  priority    = 5510
}
