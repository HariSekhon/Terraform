variable "cluster_name" {
  type = string
}

variable "region" {
  type = string
}

# to enable users/groups other than the cluster creator owner to access it
variable "map_roles" {
  type    = list(object({ rolearn = string, username = string, groups = list(string) }))
  default = []
}
