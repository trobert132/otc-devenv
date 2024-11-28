data "opentelekomcloud_identity_project_v3" "current" {}

variable "owner" {
  type = string
  default = "tothr"
}

variable "azs" {
  type = list
  default = ["eu-nl-01", "eu-nl-02"]
}

#variable "metrics_version" {
#  type = string
#  default = "1.3.37"
#}

variable "autoscaler_version" {
  type = string
  default = "1.29.17"
}

variable "everest_version" {
  type = string
  default = "v1.29"
}

#variable "prefix" {}
variable "vpc_id" {}
variable "subnet_id" {}

variable "node_os" {
  type = string
  default = "Ubuntu 22.04"
}

variable "node_flavor" {
  type = string
  default = "c4.xlarge.2"
}

variable "key_name" {}

variable "cnt" {
  type = string
  default = "vpc-router"
}

variable "auth_type" {
  type = string
  default = "rbac"
}

variable "proxy_mode" {
  type = string
  default = "iptables"
}

variable "scale_enabled" {
  type = bool
  default = false
}

variable "scaling" {
  type = map(number)
  default = {
    start = 1
    min = 1
    max = 1
  }
}

variable "root_vol" {
  type = number
  default = 40
}

variable "data_vol" {
  type = number
  default = 100
}
