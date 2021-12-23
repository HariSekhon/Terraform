#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: [% DATE # 2020-08-21 10:14:10 +0100 (Fri, 21 Aug 2020) %]
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
#                          T e r r a f o r m   M a i n
# ============================================================================ #

locals {
  region = "eu-west-2" # London
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
  region  = local.region
  network = module.vpc.vpc_network
}

module "eks" {
  source       = "../modules/eks"
  region       = local.region
  cluster_name = "mycluster"
  # https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
  # https://kubernetes.io/docs/reference/access-authn-authz/rbac/#default-roles-and-role-bindings
  map_roles = [
    {
      rolearn  = "arn:aws:iam::123456789012:group/Admins"
      username = ""
      groups   = ["cluster-admin"]
    },
    {
      rolearn  = "arn:aws:iam::123456789012:role/AWSReservedSSO_MyGroup_1234a567b890cdef",
      username = "myrole"
      groups   = []
    }
  ]
}

resource "<type>" "<name>" {
  #...
  lifecycle {
    create_before_destroy = false
    prevent_destroy       = false
    ignore_changes        = [] # list of attributes
  }
}
