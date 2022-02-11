# AWS provider bug:
#
#   https://github.com/hashicorp/terraform-provider-aws/issues/2044
#
# if you change the launch template or anything that requires recreating the compute environment,
# you must first taint the queues to have them removed first, otherwise they will cause the compute destroy to error out
# as they only get in-place update instead of recreate plans otherwise
#
# Workaround - for each queue:
#
#   terraform taint module.aws_batch.aws_batch_job_queue.myqueue
#
# taint all queues:
#
#   terraform state list | grep -E '^module\.aws-batch\.aws_batch_job_queue\.' | while read -r name; do terraform taint "$name"; done
#
# or newer 'terraform apply -replace'
#
#   terraform apply $(terraform state list | grep -E '^module\.aws-batch\.aws_batch_job_queue\.' | while read -r name; do echo " -replace=$name"; done)


resource "aws_batch_job_queue" "myqueue" {
  name     = "myqueue" # XXX: Edit
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    aws_batch_compute_environment.mycompute.arn
  ]
}
