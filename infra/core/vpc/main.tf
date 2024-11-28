## [NETWORK]

locals {
  prefix = "${var.owner}"
  tags = {
    Owner   = var.owner
    Managed_By = "terraform"
  }
}

resource "opentelekomcloud_vpc_v1" "this" {
  name = "${local.prefix}-vpc"
  cidr = var.vpc_cidr
  shared = true
  tags = var.tags
}

resource "opentelekomcloud_vpc_subnet_v1" "this" {
  name       = "${local.prefix}-subnet"
  cidr       = var.subnet_cidr
  vpc_id     = opentelekomcloud_vpc_v1.this.id
  gateway_ip = var.subnet_gw

  tags = var.tags
}

output "vpc_id" {
  value = opentelekomcloud_vpc_v1.this.id
}

output "subnet_id" {
  value = opentelekomcloud_vpc_subnet_v1.this.id
}

output "network_id" {
  value = opentelekomcloud_vpc_subnet_v1.this.network_id
}

output "cidr" {
  value = opentelekomcloud_vpc_subnet_v1.this.cidr
}
