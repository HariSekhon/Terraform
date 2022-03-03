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
