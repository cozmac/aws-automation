variable "region" {
  default = "eu-central-1"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "access_key" {
  default = "Your access key here"
}

variable "secret_key" {
  default = "Your secret key here"
}

variable "availability_zones" {
  type    = "list"
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "subnets_cidr_block" {
  type    = "list"
  default = ["10.0.4.0/22", "10.0.8.0/22", "10.0.12.0/22", "10.0.16.0/22"]
}

variable "amis" {
  default = ["ami-0ebe657bc328d4e82", "ami-0ebe657bc328d4e82", "ami-0ebe657bc328d4e82"]
}

variable "instance_types" {
  default = ["t2.micro", "t2.micro", "t2.micro"]
}

variable "lbName" {
  default = "PrincipalLoadBalancer"
}

variable "load_balancer_type" {
  default = "application"
}

variable "connectionType" {
  default = "ssh"
}

variable "username" {
  default = "ec2-user"
}

variable "connectionPort" {
  default = 22
}

variable "ssh_public_key" {
  default = "/root/.ssh/id_rsa.pub"
}

variable "ssh_private_key" {
  default = "/root/.ssh/id_rsa"
}

variable "hasPublicIp" {
  default = true
}

variable "isInternal" {
  default = false
}

variable "targetTypeLB" {
  default = "instance"
}

variable "portLb" {
  default = 80
}

variable "defaultActionLB" {
  default = "forward"
}

variable "number_of_targets" {
  default = 3
}

variable "dynamodbparams" {
  type = "map"

  default = {
    name      = "HTTP"
    columnOne = "IP"
    columnTwo = "TIME"
  }
}
