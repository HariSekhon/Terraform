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

# You can also create a customized Terragrunt scaffold boilerplate terragrunt.hcl template like so:
#
#   terragrunt scaffold <module>
#
# eg.
#
#   terragrunt scaffold github.com/gruntwork-io/terragrunt-infrastructure-modules-example//modules/mysql
#
# XXX: Beware this will overwrite without warning any terragrunt.hcl file in the current directory
#
# It will find the latest tag release and create a tagged source entry and the inputs{} entries for the specific module

# Terragrunt finds the path to this terragrunt.hcl config file via this order of precedence:
#
#   --terragrunt-config
#   $TERRAGRUNT_CONFIG
#   $PWD

terraform {
  # source is path to Terraform config or modules
  #
  # the double slash before //app denotes a sub-directory relative to the root of the repo / package:
  #
  #   https://developer.hashicorp.com/terraform/language/modules/sources#modules-in-package-sub-directories
  #
  # source follows the same syntax as Terraform modules (file, git) except not Terraform registry
  #
  #   https://www.terraform.io/docs/modules/sources.html
  #
  source = "github.com:HariSekhon/Terraform.git//app?ref=v0.0.1"
  #
  # Registry Sources
  #
  #   tfr:/// === $TG_TF_DEFAULT_REGISTRY_HOST if environment variable is set
  #     or
  #   tfr:/// === tfr://registry.terraform.io/ - for Terraform
  #     or
  #   tfr:/// === tfr://registry.opentofu.org/ - for Opentofu
  #
  # for private registries define TG_TF_REGISTRY_TOKEN environment variable with the registry API token
  #
  #source = "tfr:///terraform-aws-modules/vpc/aws?version=3.5.0"

  # avoid having to remember to provide -var-file=... args every time to Terraform by specifying them like so
  extra_arguments "common_vars" {
    #commands = ["plan", "apply"]
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      # must use get_terragrunt_dir() because it executes in a temporary directory which will break relative paths,
      # while absolute paths are not portable to other machines eg. colleagues machines or CI/CD systems
      "-var-file=${get_terragrunt_dir()}/../first.tfvars",
      "-var-file=${get_terragrunt_dir()}/../another.tfvars",
      # cannot contain whitespace, if you need whitespace separated arguments split them
      "-var", "bucket=example.bucket.name"
    ]
    # pass a map of environment variables to each terraform command
    #env_vars = []
  }
  extra_arguments "retry_lock" {
    commands = get_terraform_commands_that_need_locking()
    arguments = [
      # keep retrying to acquire lock for 20 minutes to avoid unnecessary CI/CD failures
      "-lock-timeout=20m"

      # you could also just disableConcurrentBuilds() in Jenkins eg.
      #
      #     https://github.com/HariSekhon/Jenkins/blob/master/vars/terraformPipeline.groovy
      #        OR
      #     https://github.com/HariSekhon/Jenkins/blob/master/vars/terragruntPipeline.groovy
      #
    ]
  }
  extra_arguments "conditional_vars" {
    commands = [
      "apply",
      "import",
      "plan",
      "push",
      "refresh"
    ]

    # fails if this file isn't found
    required_var_files = [
      "${get_parent_terragrunt_dir()}/terraform.tfvars"
    ]

    # ignores if these files aren't found
    optional_var_files = [
      "${get_parent_terragrunt_dir()}/${get_env("TF_VAR_env", "dev")}.tfvars",
      "${get_parent_terragrunt_dir()}/${get_env("TF_VAR_region", "eu-west-2")}.tfvars",
      "${get_terragrunt_dir()}/${get_env("TF_VAR_env", "dev")}.tfvars",
      "${get_terragrunt_dir()}/${get_env("TF_VAR_region", "eu-west-2")}.tfvars"
    ]
  }

  # https://terragrunt.gruntwork.io/docs/features/hooks/
  #
  # can have multiple before_hook or after_hook or different names, they'll execute in the order given
  # hooks are run from the module directory except for terragrunt-read-config and init-from-module which are run from terragrunt.hcl directory
  before_hook "before_hook" {
    commands     = ["apply", "plan"]  # commands for which the hook should run
    execute      = ["tflint"]         # command to execute
    #working_dir  =
  }
  before_hook "before_hook2" {
    commands     = ["apply", "plan"]
    execute      = ["echo", "Running Terraform"]
  }
  after_hook "after_hook" {
    commands     = ["apply", "plan"]
    execute      = ["echo", "Finished running Terraform"]  # outputs regardless of whether Terraform fails
    run_on_error = true  # run even if previous hooks failed
  }
  error_hook "error_hook" {
    on_errors = [".*"]
    execute = ["echo", "A hook failed"]  # executes after each 'before_hook' and 'after_hook' if their errors match on_errors regex
  }
  retryable_errors = [
    "(?s).*Error installing provider.*tcp.*connection reset by peer.*",
    "(?s).*ssh_exchange_identification.*Connection closed by remote host.*"
  ]
  retry_max_attempts = 5         # default: 3
  retry_sleep_interval_sec = 30  # default: 5
}

# source the provider or backend config from a parent directory's terragrunt.hcl:
include "root" {
  path = find_in_parent_folders()
}

# ============================================================================ #


# each input becomes an 'export TF_VAR_...' environment variable passed to Terraform
inputs = {
  instance_count = 10
  instance_type  = "m4.large"
}

# ============================================================================ #

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

# automatically generates buckets and DynamoDB table for locking
# - use 'generate' instead of 'remote_state' if you don't want this automated management of remote state resources
remote_state {
  # use this to disable generating the backend resources in CI/CD for validate-all checks
  # if TERRAGRUNT_DISABLE_INIT is set to any value other than "false"
  #disable_init = tobool(get_env("TERRAGRUNT_DISABLE_INIT", "false"))
  backend = "s3"
  # generate a backend.tf file with this config below
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"  # overwrites only if it was generated by Terragrunt. Other options are: overwrite, skip, error
  }
  config = {
    # creates the S3 bucket if not exists, with versioning enabled, server-side encryption and access logging
    #         or GCS bucket if not exists, with versioning enabled
    #
    #   https://terragrunt.gruntwork.io/docs/features/keep-your-remote-state-configuration-dry/
    #
    bucket = "my-terraform-state"

    # will expand to the path of the including terragrunt.hcl file in a sub-directory
    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    # creates the DynamoDB table if not exists, with LockID primary key
    dynamodb_table = "my-lock-table"

    # GCS settings:
    #skip_bucket_versioning = false
    #enable_bucket_policy_only = true  # enforce uniform-level access
    #encryption_key = "GOOGLE_ENCRYPTION_KEY"

    #disable_bucket_update = false  # do not update the bucket settings to match here

    # to control usage of S3 compatible object stores, see
    #
    #   https://terragrunt.gruntwork.io/docs/features/keep-your-remote-state-configuration-dry/#s3-specific-remote-state-settings
  }
}

# variables to pass to the module, same as TF_VAR_<name>
# TF_VAR_* takes precedence over these inputs
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

  # can compose variables eg.
  x = 2
  y = 40
  answer = local.x + local.y

  # use variables from another config file
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  region      = local.common_vars.region
  # or HCL - this is more expensive due to full parse of HCL file and potentially expensive computation in it via run_cmd()
  computed_vars = read_terragrunt_config(find_in_parent_folders("computed.hcl"))
}

# specify module dependencies of the backend-app
dependencies {
  paths = ["../vpc", "../mysql", "../redis"]
}
# specify module dependencies of the frontend-app

# this is to get outputs from this module
dependency "vpc" {
  config_path = "../vpc"
  # if the dependent module hasn't been applied yet, just pass these mock outputs instead of erroring out
  #mock_outputs = {
  #  vpc_id = "temporary-dummy-id"
  #  network_cidr = "10.0.0.0/16"
  #}
  # only use above mocks for the validate command
  #mock_outputs_allowed_terraform_commands = ["validate"]
}

# and use them here
inputs {
  vpc_id = dependency.vpc.outputs.vpc_id
  cidr = dependency.vpc.outputs.network_cidr
}

# get outputs from multiple modules
dependency "mysql" {
  config_path = "../mysql"
}

dependency "redis" {
  config_path = "../redis"
}

inputs = {
  mysql_url = dependency.mysql.outputs.domain
  redis_url = dependency.redis.outputs.domain
}
