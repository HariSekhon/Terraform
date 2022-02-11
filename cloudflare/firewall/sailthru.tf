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
#          C l o u d f l a r e   F i r e w a l l   -   S a i l t h r u
# ============================================================================ #

locals {
  sailthru_IPs = [
    "100.25.66.222/32",
    "136.175.24.64/30",
    "136.175.25.64/30",
    "162.208.117.0/24",
    "162.208.117.58/32",
    "163.47.180.0/23",
    "173.228.155.0/24",
    "192.64.236.0/24",
    "192.64.237.0/24",
    "192.64.238.0/24",
    "204.153.121.0/24",
    "3.143.206.16/30",
    "3.89.166.254/32",
    "44.192.201.56/30",
    "52.86.20.3/32",
    "64.34.47.128/27",
    "64.34.57.192/26",
    "65.39.215.0/24",
    "66.216.49.248/29",
    "66.216.55.248/29",
    "66.216.58.64/27"
  ]
}

resource "cloudflare_filter" "sailthru" {
  zone_id     = var.zone_id
  description = "Sailthru IPs"
  expression  = "( ip.src in { ${join("\n", local.sailthru_IPs)} } )"
}

resource "cloudflare_firewall_rule" "sailthru" {
  zone_id     = var.zone_id
  description = "Sailthru"
  filter_id   = cloudflare_filter.sailthru.id
  action      = "allow"
  priority    = 5580
}
