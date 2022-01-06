#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2021-12-23 21:15:39 +0000 (Thu, 23 Dec 2021)
#
#  https://github.com/HariSekhon/Terraform
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# replace with variables if inside module
locals {
  rules = [
    {
      port        = 80
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 22
      proto       = "tcp"
      cidr_blocks = ["1.2.3.4/32"]
    }
  ]
}

resource "aws_security_group" "my-sg" {
  name   = "my-aws-security-group"
  vpc_id = "some-vpc" # aws_vpc.my-vpc.id
  dynamic "ingress" {
    for_each = local.rules # or var.rules if inside module
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["proto"]
      cide_blocks = ingress.value["cidr_blocks"]
    }
  }
}
