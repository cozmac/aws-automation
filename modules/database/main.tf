resource "aws_db_instance" "CozmaDB" {
  allocated_storage          = "${var.allocated_storage}"
  max_allocated_storage      = "${var.max_allocated_storage}"
  storage_type               = "${var.storage_type}"
  engine                     = "${var.engine}"
  engine_version             = "${var.engine_version}"
  instance_class             = "${var.instance_class}"
  name                       = "${var.nameDb}"
  username                   = "${var.usernameDb}"
  password                   = "${var.passwordDb}"
  parameter_group_name       = "${var.parameter_group_name}"
  auto_minor_version_upgrade = "${var.auto_minor_version_upgrade}"
  port                       = "${var.portDb}"

  publicly_accessible       = "${var.publicly_accessible}"
  vpc_security_group_ids    = ["${var.vpc_security_group_ids}"]
  db_subnet_group_name      = "${aws_db_subnet_group.dbSubnetGroup.name}"
  skip_final_snapshot       = false
  final_snapshot_identifier = "cristian"
}

resource "aws_db_subnet_group" "dbSubnetGroup" {
  name       = "test"
  subnet_ids = ["${var.subnet_ids}"]

  tags = {
    Name = "My DB subnet group"
  }
}
