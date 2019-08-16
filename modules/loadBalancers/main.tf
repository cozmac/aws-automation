resource "aws_lb" "principalLB" {
  name               = "${var.lbName}"
  internal           = "${var.isInternal}"
  load_balancer_type = "${var.load_balancer_type}"
  internal           = "${var.isInternal}"
  security_groups    = ["${var.security_group_id}"]
  subnets            = ["${var.lbSubnets}"]
}

resource "aws_lb_listener" "listenerLB" {
  load_balancer_arn = "${aws_lb.principalLB.arn}"
  port              = "${var.portLb}"

  default_action {
    type             = "${var.defaultActionLB}"
    target_group_arn = "${aws_lb_target_group.targetGroupLB.arn}"
  }
}

resource "aws_lb_target_group" "targetGroupLB" {
  name        = "${var.lbName}TG"
  target_type = "${var.targetTypeLB}"
  vpc_id      = "${var.vpcID}"
  port        = "${var.portLb}"
  protocol    = "HTTP"
}

resource "aws_lb_target_group_attachment" "test" {
  count            = "${var.number_of_targets}"
  target_group_arn = "${aws_lb_target_group.targetGroupLB.arn}"
  target_id        = "${var.targetID[count.index]}"
}
