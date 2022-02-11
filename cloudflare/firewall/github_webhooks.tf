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
#   C l o u d f l a r e   F i r e w a l l   -   G i t H u b   W e b h o o k s
# ============================================================================ #

# Permit GitHub Webhook addresses through Cloudflare Firewall to private sites such as Jenkins

# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/firewall_rule

# duplicates provider.tf
#provider "http" {}

# doesn't verify SSL except chain of trust according to Important notice for 0.12 at:
#
# https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/data_source
#
data "http" "github_meta" {
  url = "https://api.github.com/meta"

  request_headers = {
    Accept = "application/json"
  }
}

# verifies SSL unlike http provider but cannot return an array of IPs like I need
#data "external" "github_webhook_ips" {
#  # Error: command "curl" produced invalid JSON: json: cannot unmarshal bool into Go value of type string
#  #program = ["curl", "-sSL", "https://api.github.com/meta"]
#  # Error: command "bash" produced invalid JSON: json: cannot unmarshal object into Go value of type string
#  #program = ["bash", "-c", "curl -sSL https://api.github.com/meta | jq 'walk(if type == \"boolean\" then tostring else . end)'"]
#  # this requires map[string]string which is not suitable for a list of IPs
#}

locals {
  github_ips_data    = jsondecode(data.http.github_meta.body)
  github_webhook_IPs = local.github_ips_data.hooks
}

resource "cloudflare_filter" "github_webhooks" {
  zone_id     = var.zone_id
  description = "GitHub Webhook IPs"
  expression  = "(ip.src in { ${join("\n", local.github_webhook_IPs)} } )"
}

resource "cloudflare_firewall_rule" "github_webhooks" {
  zone_id     = var.zone_id
  description = "GitHub Webhooks"
  filter_id   = cloudflare_filter.github_webhooks.id
  action      = "allow"
  priority    = 5520
}
