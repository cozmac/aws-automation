resource "aws_vpc" "mainVpc" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "myGw" {
  vpc_id = "${aws_vpc.mainVpc.id}"
}

resource "aws_route_table" "routeTable" {
  vpc_id = "${aws_vpc.mainVpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.myGw.id}"
  }
}

resource "aws_security_group" "security_group" {
  name        = "security_group"
  description = "Security group"
  vpc_id      = "${aws_vpc.mainVpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.mainVpc.id}"
  cidr_block        = "${var.subnets_cidr_block[count.index]}"
  availability_zone = "${var.availability_zones[count.index]}"
}

resource "aws_main_route_table_association" "route_table_association" {
  vpc_id         = "${aws_vpc.mainVpc.id}"
  route_table_id = "${aws_route_table.routeTable.id}"
}
