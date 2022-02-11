resource "aws_iam_policy" "aws-batch-submitter" {
  name        = "AWSBatchSubmitter"
  description = "Allows Job to submit further AWS batch jobs"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "batch:SubmitJob",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# default by AWS, can't configure this
#resource "aws_iam_role" "aws_batch_service_role" {
#  name      = "AWSServiceRoleForBatch"
#  path      = "/aws-service-role/batch.amazonaws.com/"
#  managed_policy_arns = ["arn:aws:iam::aws:policy/aws-service-role/BatchServiceRolePolicy"]
#  assume_role_policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Action = "sts:AssumeRole"
#        Effect = "Allow"
#        Sid    = ""
#        Principal = {
#          Service = "batch.amazonaws.com"
#        }
#      },
#    ]
#  })
#}

resource "aws_iam_role" "ecs_instance_role" {
  name                = "ecsInstanceRole"
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role" "job" {
  name = "MyJob" # XXX: Edit
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    aws_iam_policy.aws-batch-submitter.arn
  ]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "s3.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_instance_role" {
  name = "ecsInstanceRole"
  role = aws_iam_role.ecs_instance_role.name
}


# default by AWS, can't configure this
#resource "aws_iam_role_policy_attachment" "aws_batch_service_role" {
#  #role       = aws_iam_role.aws_batch_service_role.name
#  role       = "AWSServiceRoleForBatch"
#  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
#}
