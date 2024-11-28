variable "ak_sk_security_token" {
  type        = string
  description = "Security Token for temporary AK/SK"
}
variable "domain_name" {
  type = string
}

variable "project_name" {
  type    = string
  default = "eu-nl_tothr"
}

variable "owner" {
  type    = string
  default = "tothr"
}

variable "region" {
  type    = string
  default = "eu-nl"
}

