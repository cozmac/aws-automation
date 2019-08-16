variable "amis" {
  type = "list"
}

variable "instance_types" {
  type = "list"
}

variable "availability_zones" {
  type = "list"
}

variable "subnet_ids" {
  type = "list"
}

variable "hasPublicIp" {}

variable "connectionType" {}

variable "username" {}

variable "connectionPort" {}

variable "ssh_public_key" {}

variable "ssh_private_key" {}

variable "security_group_id" {}
