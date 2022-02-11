# need to use an EC2 launch template just to get a bigger disk for AWS Batch job to have working space
resource "aws_launch_template" "mytemplate" {
  name                   = "MyAWSBatchLaunchTemplate" # XXX: Edit
  update_default_version = true
  instance_type          = null # ignored by AWS Batch
  vpc_security_group_ids = var.vpc_security_group_ids
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 100 #GB
    }
  }
}
