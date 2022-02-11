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
#         C l o u d f l a r e   F i r e w a l l   -   M a i l C h i m p
# ============================================================================ #

locals {
  # https://mailchimp.com/about/ips/
  mailchimp_IPs = [
    "205.201.128.0/20",
    "198.2.128.0/18 ",
    "148.105.0.0/16"
  ]
}

resource "cloudflare_filter" "mailchimp" {
  zone_id     = var.zone_id
  description = "MailChimp IPs"
  expression  = "( ip.src in { ${join("\n", local.mailchimp_IPs)} } )"
}

resource "cloudflare_firewall_rule" "mailchimp" {
  zone_id     = var.zone_id
  description = "MailChimp"
  filter_id   = cloudflare_filter.mailchimp.id
  action      = "allow"
  priority    = 5540
}
