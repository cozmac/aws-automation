variable "allocated_storage" {}

variable "max_allocated_storage" {}

variable "storage_type" {}

variable "engine" {}

variable "engine_version" {}

variable "instance_class" {}

variable "nameDb" {}

variable "usernameDb" {}

variable "passwordDb" {}

variable "parameter_group_name" {}

variable "auto_minor_version_upgrade" {}

variable "portDb" {}

variable "publicly_accessible" {}

variable "vpc_security_group_ids" {
  type = "list"
}

variable "subnet_ids" {
  type = "list"
}
