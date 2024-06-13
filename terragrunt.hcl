#
#  Author: Hari Sekhon
#  Date: 2024-06-11 11:06:48 +0200 (Tue, 11 Jun 2024)
#
#  vim:ts=2:sts=2:sw=2:et:filetype=terraform
#
#  https///github.com/HariSekhon/Terraform
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# ============================================================================ #
#                              T e r r a g r u n t
# ============================================================================ #

terraform {
  # avoid having to remember to provide -var-file=... args every time to Terraform by specifying them like so
  extra_arguments "common_vars" {
    #commands = ["plan", "apply"]
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      # must use get_terragrunt_dir() because it executes in a temporary directory which will break relative paths, while absolute paths are not portable to other machines eg. colleagues or CI/CD systems
      "-var-file=${get_terragrunt_dir()}/../first.tfvars",
      "-var-file=${get_terragrunt_dir()}/../another.tfvars"
    ]
  }
}

# source the provider or backend config from a parent directory's terragrunt.hcl:
include "root" {
  path = find_in_parent_folders()
}

# Terragrunt finds the path to its config file via this order of precedence:
#
#   --terragrunt-config
#   $TERRAGRUNT_CONFIG
#   $PWD

# ============================================================================ #

terraform {
	# source your remote module with a couple variables, so you can reuse the code with only this tiny stub
  source =
    # the double slash before //app denotes a sub-directory relative to the root of the package:
    #
    #   https://developer.hashicorp.com/terraform/language/modules/sources#modules-in-package-sub-directories
    #
    "github.com:HariSekhon/Terraform.git//app?ref=v0.0.1"
}
# each input becomes an 'export TF_VAR_...' environment variable passed to Terraform
inputs = {
  instance_count = 10
  instance_type  = "m4.large"
}

# ============================================================================ #

# tfr:/// == tfr://registry.terraform.io/

terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=3.5.0"
}

# generate a provider.tf file with the below contents
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}

remote_state {
  backend = "s3"
  # generate a backend.tf file with this config below
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "my-terraform-state"

    # will expand to the path of the including terragrunt.hcl file in a sub-directory
    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
}

# variables to pass to the module
inputs = {
  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
