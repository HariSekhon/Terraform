variable "name" {
  type = string
}
variable "budget" {
  type = number
}
variable "email" {
  type = string
}
variable "region" {
  type = string
}
variable "threshold_percent" {
  type    = number
  default = 80
}
