#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2021-10-28 00:44:00 +0100 (Thu, 28 Oct 2021)
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
#                            D a t a   s o u r c e s
# ============================================================================ #

# Get dynamic data from outside Terraform to use elsewhere in manifests, such as finding a suitable EC2 AMI for the region

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  # TODO: add more filters here such as search for Ubuntu 20.04 LTS
}

output "AMI-id" {
  value = data.aws_ami.myAMI.id
}
