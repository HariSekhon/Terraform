#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2021-03-04 18:19:03 +0000 (Thu, 04 Mar 2021)
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
#           C l o u d f l a r e   F i r e w a l l   -   P i n g d o m
# ============================================================================ #

# Permit Pingdom health check probe addresses through Cloudflare Firewall to access private sites to test them

# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/firewall_rule

# requires cloudflare_locals.tf to share the zone id variable between files

# Pingdom source IPs:
#
#   https://my.pingdom.com/app/probes/ipv4
#
#   https://documentation.solarwinds.com/en/Success_Center/pingdom/content/topics/pingdom-probe-servers-ip-addresses.htm

data "http" "pingdom_probes_ipv4" {
  url = "https://my.pingdom.com/probes/ipv4"
}

locals {
  pingdom_IPs = data.http.pingdom_probes_ipv4.body
}

resource "cloudflare_filter" "pingdom" {
  zone_id     = var.zone_id
  description = "Pingdom IPs"
  expression  = "(ip.src in {${local.pingdom_IPs}})"
}

resource "cloudflare_firewall_rule" "pingdom" {
  zone_id     = var.czone_id
  description = "Pingdom"
  filter_id   = cloudflare_filter.pingdom.id
  action      = "allow"
  priority    = 5550
}
