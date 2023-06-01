variable "name" {
  type = string
}
variable "description" {
  type    = string
  default = ""
}
variable "visibility" {
  type    = string
  default = "private"
}
variable "topics" {
  type    = list(string)
  default = []
}
variable "pages" {
  type    = list(object({ branch = string, path = string }))
  default = []
}
# if run against a github actions library repo then don't create the client workflow resources as they will overwrite the shared workflows
variable "actions_repo" {
  type    = bool
  default = false
}
variable "codeowners" {
  type    = string
  default = ""
}
# now setting this to "admin" to use this account to run Terraform CI/CD
#variable "ci_permission" {
#  type    = string
#  default = "pull"
#}
