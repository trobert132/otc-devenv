variable "key_name" {}
variable "az" {}
variable "tags" {}
#variable "prefix" {}
variable "owner" {
  type = string
  default = "tothr"
}
variable "vpc_id" {}
variable "network_id" {}
variable "subnet_id" {}
