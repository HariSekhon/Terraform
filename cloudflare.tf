#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2021-03-04 18:17:02 +0000 (Thu, 04 Mar 2021)
#
#  https://github.com/HariSekhon/Terraform
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# ============================================================================ #
#                              C l o u d f l a r e
# ============================================================================ #

# ============
# XXX: uncomment if not in provider.tf
# provider.tf:
# needs to be in main deployment dir and also in cloudflare/firewall module
#terraform {
#  required_providers {
#    cloudflare = {
#      source = "cloudflare/cloudflare"
#    }
#  }
#  required_version = ">= 0.13"
#}

# in terraform.tfvars
#provider "cloudflare" {
#  email   = var.cloudflare_email
#  api_key = var.cloudflare_api_key
#}

#provider "http" {}
# ============


# =============
# variables.tf:
# XXX: set these in terraform.tfvars
variable "cloudflare_email" {
  type = string
}
variable "cloudflare_api_key" {
  type = string
}


# ==========
# locals.tf:
locals {
  # obtained from the Cloudflare API:
  #
  #   cloudflare_zones.sh
  #
  # XXX: Edit
  cloudflare_zone_id = "..."
}


# =======
# main.tf:
module "firewall" {
  source             = "./cloudflare/firewall"
  cloudflare_email   = var.cloudflare_email
  cloudflare_api_key = var.cloudflare_api_key
  zone_id            = local.cloudflare_zone_id
}
