#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: [% DATE # 2020-08-21 10:14:10 +0100 (Fri, 21 Aug 2020) %]
#
#  [% URL %]
#
#  [% LICENSE %]
#
#  [% MESSAGE %]
#
#  [% LINKEDIN %]
#

# ============================================================================ #
#                          T e r r a f o r m   M a i n
# ============================================================================ #

locals {
  var1 = "blah"
}

# define terraform resources and import modules here

# quick thing to create and tear down to test your AWS creds are working
#resource "aws_instance" "test_server" {
#  ami           = "ami-0194c3e07668a7e36"  # Ubuntu 20.04 LTS in eu-west-2
#  instance_type = "t2.micro"
#  subnet_id     = "subnet-12a3456bc789de0fa"  # need to find and populate this if no default VPC eg. when created by Control Tower
#
#  tags = {
#    Name = "TestServer"
#  }
#}

module "NAME" {
  source  = "./modules/NAME"
  project = var.project
  region  = var.region
  network = module.vpc.vpc_network
}
