#variable "prefix" {
#  type = string
#}

variable "owner" {
  type = string
  default = "tothr"
}

variable "vpc_cidr" {
  type    = string
  #default = "192.168.0.0/16"
  default = "192.168.122.0/23"
}

variable "subnet_cidr" {
  type    = string
  default = "192.168.122.0/24"
}

variable "subnet_gw" {
  type    = string
  #default = "192.168.10.10"
  default = "192.168.122.1"
}

#variable "peer_accepter_vpc_id" {
#  type = string
#  default = "94d05eb5-1ea7-4925-b592-165a6e63be89"
#}

variable "region" {
  type    = string
  default = "eu-nl"
}

variable "tags" {}
