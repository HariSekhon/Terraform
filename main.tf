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

module "NAME" {
  source  = "./modules/NAME"
  project = var.project
  region  = var.region
  network = module.vpc.vpc_network
}
