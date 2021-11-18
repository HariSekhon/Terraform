variable "region" {
  type = string
}

variable "docker_image" {
  type = string
}

variable "vpc_subnet_ids" {
  type = list(string)
}
variable "vpc_security_group_ids" {
  type = list(string)
}
