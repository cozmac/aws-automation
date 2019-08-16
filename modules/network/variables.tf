variable "vpc_cidr_block" {}

variable "subnets_cidr_block" {
  type = "list"
}

variable "availability_zones" {
  type = "list"
}
