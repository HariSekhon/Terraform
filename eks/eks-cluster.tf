# https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  # https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
  # https://kubernetes.io/docs/reference/access-authn-authz/rbac/#default-roles-and-role-bindings
  map_roles = var.map_roles

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "r5.large"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      #additional_userdata           = "echo foo bar"
    }
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
