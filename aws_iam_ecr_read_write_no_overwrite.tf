#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2024-12-02 01:38:27 +0700 (Mon, 02 Dec 2024)
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
#                        AWS ECR Read Write No Overwrite
# ============================================================================ #

resource "aws_iam_policy" "ecr_read_write_no_overwrite" {
  name        = "ECRReadWriteNoOverwriteRestricted"
  description = "Policy granting read and write access to an ECR repository with no overwrite, restricted to a specific user ARN"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Allow read access
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:DescribeImages",
          "ecr:ListImages"
        ]
        Resource = "arn:aws:ecr:${var.region}:${var.account_id}:repository/${var.repository_name}"
        Condition = {
          StringEquals = {
            "aws:PrincipalArn" : var.allowed_user_arn
          }
        }
      },
      # Allow write access, but restrict overwrites
      {
        Effect = "Allow"
        Action = [
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ]
        Resource = "arn:aws:ecr:${var.region}:${var.account_id}:repository/${var.repository_name}"
        Condition = {
          StringEquals = {
            "aws:PrincipalArn" : var.allowed_user_arn
          },
          StringNotEqualsIfExists = {
            "ecr:ExistingImageTag" : "*"
          }
        }
      }
    ]
  })
}
