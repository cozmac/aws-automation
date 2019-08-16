output "subnet_ids" {
  value = ["${aws_subnet.subnets.*.id}"]
}

output "security_group" {
  value = "${aws_security_group.security_group.id}"
}

output "vpcID" {
  value = "${aws_vpc.mainVpc.id}"
}
