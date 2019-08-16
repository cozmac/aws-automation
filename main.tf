provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "network" {
  source             = "./modules/network"
  vpc_cidr_block     = "${var.vpc_cidr_block}"
  availability_zones = "${var.availability_zones}"
  subnets_cidr_block = "${var.subnets_cidr_block}"
}

module "instances" {
  source             = "./modules/instances"
  amis               = "${var.amis}"
  availability_zones = "${var.availability_zones}"
  instance_types     = "${var.instance_types}"
  subnet_ids         = "${module.network.subnet_ids}"
  hasPublicIp        = "${var.hasPublicIp}"

  connectionType    = "${var.connectionType}"
  username          = "${var.username}"
  connectionPort    = "${var.connectionPort}"
  ssh_private_key   = "${(var.ssh_private_key)}"
  ssh_public_key    = "${(var.ssh_public_key)}"
  security_group_id = "${module.network.security_group}"
}

module "loadBalancers" {
  source             = "./modules/loadBalancers"
  lbName             = "${var.lbName}"
  load_balancer_type = "${var.load_balancer_type}"
  isInternal         = "${var.isInternal}"
  security_group_id  = ["${module.network.security_group}"]
  lbSubnets          = "${module.network.subnet_ids}"
  targetTypeLB       = "${var.targetTypeLB}"
  portLb             = "${var.portLb}"
  defaultActionLB    = "${var.defaultActionLB}"
  vpcID              = "${module.network.vpcID}"
  targetID           = "${module.instances.instance_ids}"
  number_of_targets  = "${var.number_of_targets}"
}

/*module "database" {
  source                     = "./modules/database"
  allocated_storage          = "${var.allocated_storage}"
  max_allocated_storage      = "${var.max_allocated_storage}"
  storage_type               = "${var.storage_type}"
  engine                     = "${var.engine}"
  engine_version             = "${var.engine_version}"
  instance_class             = "${var.instance_class}"
  nameDb                     = "${var.nameDb}"
  usernameDb                 = "${var.usernameDb}"
  passwordDb                 = "${var.passwordDb}"
  parameter_group_name       = "${var.parameter_group_name}"
  auto_minor_version_upgrade = "${var.auto_minor_version_upgrade}"
  portDb                     = "${var.portDb}"
  publicly_accessible        = "${var.publicly_accessible}"
  vpc_security_group_ids     = ["${module.network.security_group}"]
  subnet_ids                 = ["${module.network.subnet_ids}"]
}*/

module "dynamoDb" {
  source         = "./modules/dynamoDb"
  dynamodbparams = "${var.dynamodbparams}"
}
