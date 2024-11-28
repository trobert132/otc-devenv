locals {
  prefix = "${var.owner}"
  tags = {
    Owner   = var.owner
    Managed_By = "terraform"
  }
}

output "security_group_ids" {
  value = [
    opentelekomcloud_compute_secgroup_v2.sg1.id
  ]
}

resource "opentelekomcloud_compute_secgroup_v2" "sg1" {
  name        = "${local.prefix}_sg"
  description = "Security group for AS config"
}

resource "opentelekomcloud_as_configuration_v1" "as_config" {
  scaling_configuration_name = "${local.prefix}-client"
  instance_config {
    flavor = var.node_config.flavor
    image  = var.node_config.image_id
    disk {
      size        = var.node_config.size
      volume_type = var.node_config.volume_type
      disk_type   = var.node_config.disk_type
    }
    security_groups = var.security_groups
    key_name        = var.key_name
    user_data       = file("${path.module}/userdata.txt") # able to inject specific user data
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "opentelekomcloud_as_group_v1" "as-grp1" {
  scaling_group_name       = "${local.prefix}-as-grp"
  scaling_configuration_id = opentelekomcloud_as_configuration_v1.as_config.id
  vpc_id                   = var.vpc_id
  networks {
    id = var.subnet_id
  }
  security_groups {
    id = var.security_groups[0]
  }
  
  delete_publicip                    = false
  delete_instances                   = "yes"
  lifecycle {
    create_before_destroy = true
  }
  desire_instance_number   = 0
  min_instance_number      = 0
  max_instance_number      = 0
}