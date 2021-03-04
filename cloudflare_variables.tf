#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2021-03-04 18:17:02 +0000 (Thu, 04 Mar 2021)
#
#  https://github.com/HariSekhon/Terraform-templates
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# XXX: set these in terraform.tfvars

variable "cloudflare_email" {
  type = string
}

variable "cloudflare_api_key" {
  type = string
}
