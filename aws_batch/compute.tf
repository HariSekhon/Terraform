data "aws_caller_identity" "current" {}

resource "aws_batch_compute_environment" "mycompute" {
  compute_environment_name = "myCompute" # XXX: Edit
  type                     = "MANAGED"
  compute_resources {
    type                = "SPOT"
    allocation_strategy = "SPOT_CAPACITY_OPTIMIZED"
    bid_percentage      = 50
    instance_type       = ["optimal"]
    min_vcpus           = 0
    max_vcpus           = 4750 # XXX: Edit
    subnets             = var.vpc_subnet_ids
    security_group_ids  = var.vpc_security_group_ids
    instance_role       = aws_iam_instance_profile.ecs_instance_role.arn
    launch_template {
      launch_template_name = aws_launch_template.mytemplate.name
      version              = aws_launch_template.mytemplate.latest_version
    }
  }
  service_role = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/batch.amazonaws.com/AWSServiceRoleForBatch"
  #depends_on   = [aws_iam_role_policy_attachment.aws_batch_service_role]
}
