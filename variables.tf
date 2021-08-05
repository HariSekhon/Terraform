#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: [% DATE  # 2020-08-21 10:14:10 +0100 (Fri, 21 Aug 2020) %]
#
#  [% URL %]
#
#  [% LICENSE %]
#
#  [% MESSAGE %]
#
#  [% LINKEDIN %]
#

# XXX: set these in terraform.tfvars

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
