#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: [% DATE  # 2020-02-03 13:37:32 +0000 (Mon, 03 Feb 2020) %]
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
#                               P r o v i d e r s
# ============================================================================ #

# ~> only allows last number (patch) to increment

terraform {

  required_version = ">= 0.13"

  required_providers {
    # XXX: delete as necessary

    # 0.13+
    # https://registry.terraform.io/providers/hashicorp/aws/latest/docs
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }

    # https://registry.terraform.io/providers/hashicorp/google/latest/docs
    google = {
      source  = "hashicorp/google"
      version = "~> 3.40.0"
    }

    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
    azure = {
      source  = "hashicorp/azurerm"
      version = "~> 2.28.0"
    }

    # https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs
    cloudflare = {
      source = "cloudflare/cloudflare"
    }

    # https://registry.terraform.io/providers/integrations/github/latest/docs
    github = {
      source  = "integrations/github"
      version = "~> 4.24.1"
    }

    # https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source
    external = {
      source  = "hashicorp/external"
      version = "~> 2.2.0"
    }

  }

}

# ============================================================================ #
#                            Configure the Providers
# ============================================================================ #

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  # set here in 0.12, set in required_providers in 0.13
  #version = "~> 3.7.0"
  profile = "default"
  region  = var.region # eg. eu-west-2, gets this from variables.tf default or tfvars or TFC variables
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = var.project
  region  = var.region # eg. europe-west2
}

# choose this over the default one in any resource by adding this to the resource block: provider = google.europe
provider "google" {
  alias   = "europe" # to use this provider as an override on a resource-by-resource basis
  project = var.project
  region  = europe-west2
}

provider "google-beta" {
  project = var.project
  region  = var.region
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
provider "azurerm" {
  # set here in 0.12, set in required_providers in 0.13
  #version = "~> 2.28.0"
  features {}
}

# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs
provider "cloudflare" {
  email   = var.cloudflare_email   # set these in terraform.tfvars and don't commit it
  api_key = var.cloudflare_api_key # requires global api key, api tokens don't work
}

provider "http" {}

# https://registry.terraform.io/providers/integrations/github/latest/docs
provider "github" {
  #organization = "myorg" # higher precedence than owner, see doc link above
  owner = "HariSekhon" # user or organization
  # throttle to avoid hitting GitHub API rate limits with long 1 hour back-offs causing hours of hanging
  #
  #   https://github.com/integrations/terraform-provider-github/issues/1153
  #
  # calculated from 15,000 reqs/hour for GitHub Enterprise - 15000 / 3600 = 4 or 5 reqs per second => 200ms throttle
  #
  #read_delay_ms  = 200 # ms
  #write_delay_ms = 200 # ms
}

# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs
#provider "kubernetes" {}

# https://registry.terraform.io/providers/hashicorp/helm/latest/docs
#provider "helm" {}
