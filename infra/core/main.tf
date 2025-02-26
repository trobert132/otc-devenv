locals {
  prefix = "${var.owner}"
  tags = {
    Owner   = var.owner
    Managed_By = "terraform"
  }
}

module "key" {
  source = "./key"
  prefix = local.prefix
}

module "vpc" {
  source = "./vpc"
  prefix = local.prefix
  tags = local.tags
}

module "natgw" {
  source = "./natgw"
  prefix = local.prefix
  vpc_id = module.vpc.vpc_id
  network_id = module.vpc.network_id
  cidr = module.vpc.cidr
}

#module "bastion" {
#  source = "./bastion"
#  prefix = local.prefix
#  tags = local.tags
#  vpc_id = module.vpc.vpc_id
#  subnet_id = module.vpc.subnet_id
#  network_id = module.vpc.network_id
#  az = "eu-nl-01"
#  key_name = module.key.key_name
#}

module "cce" {
  source = "./cluster"
  prefix = local.prefix
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
  #eni_subnet_id = module.vpc.eni_subnet_id
  #eni_subnet_cidr = module.vpc.eni_subnet_cidr
  node_flavor = "c4.xlarge.2"
  key_name = module.key.key_name
  scale_enabled = true
  node_os = "Ubuntu 22.04"
}

#module "dns" {
#  source = "./dns"
#  domain = "tothr.hu."
#  email = "trobert132@gmail.com"
#  sub_domain = "rnd-grafana"
#  elb_ip = "80.158.92.170"
#}

#module "ecs" {
#  source = "./ecs"
#  key_name = module.key.key_name
#  vpc_id     = module.vpc.vpc_id
#  subnet_id  = module.vpc.subnet_id
#  security_groups = module.ecs.security_group_ids
#  node_config = {
#    flavor      = "c4.2xlarge.2"
#    image_id    = "7ef4c508-5f38-4630-ad3a-d9125175eafa" # Standard_Ubuntu_24.04_amd64_uefi_prev
#    volume_type = "SSD"
#    disk_type   = "SYS"
#    size        = 20
#  }
#}

module "iam" {
  source = "./iam"
  domain_id = var.domain_id
}