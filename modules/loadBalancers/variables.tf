variable "lbName" {}

variable "load_balancer_type" {}

variable "isInternal" {}

variable "security_group_id" {
  type = "list"
}

variable "lbSubnets" {
  type = "list"
}

/////////////////////////
variable "targetTypeLB" {}

variable "portLb" {}

variable "defaultActionLB" {}

variable "vpcID" {}

variable "targetID" {
  type = "list"
}

variable number_of_targets {}
