#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: [% DATE  # 2020-08-21 10:14:10 +0100 (Fri, 21 Aug 2020) %]
#
#  https://github.com/HariSekhon/Terraform
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# XXX: set these in terraform.tfvars

# https://www.terraform.io/docs/language/values/variables.html#type-constraints

# AWS
variable "profile" {
  type    = string
  default = "default"
}

# GCP
variable "project" {
  type = string
  #default = "myproject-123456"
}

variable "vpc_name" {
  type = string
  #default = "default"
}

# AWS / GCP
#variable "region" {
#  type = string
#
#  # AWS
#  #
#  #   https://docs.aws.amazon.com/general/latest/gr/rande.html#ec2_region
#  #
#  #default = "eu-west-2"
#
#  # GCP
#  #
#  #   https://cloud.google.com/compute/docs/regions-zones#available
#  #
#  #default = "europe-west2"
#}

variable "some_secret" {
  type        = string
  description = "Description shown at CLI prompt if not auto provided via terraform.tfvars, *.auto.tfvars, TF_VAR_ etc"
  sensitive   = true # obscures in 'terraform plan' but still echo's when input prompted on CLI
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
  validation {
    condition     = can(regex("^t3\\.", var.instance_type))
    error_message = "Must be a t3 type instance."
  }
}

variable "myvar" {
  type    = string
  default = "testing"
  validation {
    condition     = length(var.myvar) > 4
    error_message = "The string must be more than 4 characters."
  }
}

variable "node_count" {
  # only accept integers/floats
  type = number
  #default = 2
}

variable "private_cidrs" {
  type = list(any)
  default = [
    "10.0.0.0/8",
    "172.16.0.0/16",
    "192.168.0.0/16"
  ]
}
