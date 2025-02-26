

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "node_config" {
  description = "Configuration for the ECS instances"
  type = object({
    flavor      = string
    size        = number
    image_id    = string
    volume_type = string
    disk_type   = string
  })
  default = {
    flavor      = "c4.2xlarge.2"
    size        = 20
    image_id    = "7ef4c508-5f38-4630-ad3a-d9125175eafa" # Standard_Ubuntu_24.04_amd64_uefi_prev
    volume_type = "SSD"
    disk_type   = "SYS"
  }
}

variable "key_name" {
  description = "The key pair to use for the ECS instances"
  type        = string
}

variable "security_groups" {
  description = "The security groups to associate with the ECS instances"
  type        = list
  default = []
}

variable "availability_zone" {
  description = "The availability zone where the ECS instances will be created"
  type        = string
  default = "eu-nl-01"
}

variable "network_id" {
  description = "The network ID to attach the ECS instances to"
  type        = list
  default = []
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = ""
}
