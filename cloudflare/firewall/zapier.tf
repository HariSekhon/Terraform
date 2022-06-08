#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2021-03-22 20:19:11 +0000 (Mon, 22 Mar 2021)
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
#            C l o u d f l a r e   F i r e w a l l   -   Z a p i e r
# ============================================================================ #

# Zapier apparently hasn't heard of NAT GWs so uses all dynamic IP addresses from AWS us-east-1 :-(
#
# Looks like Zapier is coming from IP addresses that aren't found in any AWS IP range in the API (as fetched by aws_ip_ranges.sh in https://github.com/HariSekhon/DevOps-Bash-tools repo)

# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/firewall_rule

# duplicates provider.tf
#provider "http" {}

# doesn't verify SSL except chain of trust according to Important notice for 0.12 at:
#
# https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/data_source
#
data "http" "aws_ip_ranges" {
  url = "https://ip-ranges.amazonaws.com/ip-ranges.json"

  request_headers = {
    Accept = "application/json"
  }
}

locals {
  aws_ip_ranges_data = jsondecode(data.http.aws_ip_ranges.body)
  aws_IPs            = local.aws_ip_ranges_data.prefixes[*]
  aws_us_east_1_IPs = [
    for x in local.aws_IPs :
    x.ip_prefix if x.region == "us-east-1" &&
    x.service == "EC2"
  ]
}

resource "cloudflare_filter" "aws_us-east-1-ec2" {
  zone_id     = var.zone_id
  description = "AWS us-east-1 EC2 IPs"
  expression  = "(ip.src in { ${join("\n", local.aws_us_east_1_IPs)} } )" # and http.host eq \"MY.DOMAIN.COM\" and http.request.uri.path matches \"^/MY/PATH/\" and ssl )"
}

resource "cloudflare_firewall_rule" "aws_us-east-1-ec2" {
  zone_id     = var.zone_id
  description = "Zapier / AWS us-east-1 EC2"
  filter_id   = cloudflare_filter.aws_us-east-1-ec2.id
  action      = "allow"
  priority    = 5610
}

#output "aws_us-east-1_IPs" {
#  #value = local.aws_IPs
#  value = local.aws_us_east_1_IPs
#}
