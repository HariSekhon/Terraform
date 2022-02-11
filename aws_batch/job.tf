resource "aws_batch_job_definition" "myjob" {
  name = "MyJob" # XXX: Edit
  type = "container"
  container_properties = jsonencode(
    {
      command     = []
      environment = []
      image       = var.docker_image
      jobRoleArn  = aws_iam_role.job.arn
      linuxParameters = {
        devices = []
        tmpfs   = []
      }
      mountPoints = []
      # overridden in individual jobs, don't bother changing this
      resourceRequirements = [
        {
          type  = "VCPU"
          value = "1"
        },
        {
          type  = "MEMORY"
          value = "2048"
        },
      ]
      secrets = []
      ulimits = []
      volumes = []
    }
  )
  platform_capabilities = ["EC2"] # needed rather than Fargate to create bigger jobs, more vCPU, disk with launch templates etc
  retry_strategy {
    attempts = 1
  }
}
