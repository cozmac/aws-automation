resource "aws_key_pair" "ssh_key" {
  key_name   = "my-ssh-key"
  public_key = "${file(var.ssh_public_key)}"
}

resource "aws_instance" "ec2instance" {
  count                       = "${length(var.availability_zones)}"
  ami                         = "${var.amis[count.index]}"
  instance_type               = "${var.instance_types[count.index]}"
  availability_zone           = "${var.availability_zones[count.index]}"
  subnet_id                   = "${var.subnet_ids[count.index]}"
  key_name                    = "${aws_key_pair.ssh_key.id}"
  associate_public_ip_address = "${var.hasPublicIp}"
  vpc_security_group_ids      = ["${var.security_group_id}"]
}

resource "null_resource" "installHttpd" {
  count      = "${length(var.availability_zones)}"
  depends_on = ["aws_instance.ec2instance"]

  provisioner "file" {
    source      = "${path.module}/../../userdata/httpd.conf"
    destination = "/tmp/httpd.conf"

    connection {
      type        = "${var.connectionType}"
      user        = "${var.username}"
      host        = "${aws_instance.ec2instance.*.public_ip[count.index]}"
      port        = "${var.connectionPort}"
      private_key = "${file(var.ssh_private_key)}"
    }
  }

  provisioner "remote-exec" {
    script = "${path.module}/../../userdata/http.sh"

    connection {
      type        = "${var.connectionType}"
      user        = "${var.username}"
      host        = "${aws_instance.ec2instance.*.public_ip[count.index]}"
      port        = "${var.connectionPort}"
      private_key = "${file(var.ssh_private_key)}"
    }
  }
}

resource "null_resource" "cron" {
  depends_on = ["null_resource.installHttpd"]

  provisioner "local-exec" {
    command = "service cron start"
  }

  provisioner "local-exec" {
    command = "crontab -l | { cat; echo '*/1 * * * * ${path.module}/../../userdata/parseAccessLog.sh ${aws_instance.ec2instance.*.public_ip[0]} ${aws_instance.ec2instance.*.public_ip[1]} ${aws_instance.ec2instance.*.public_ip[2]} ';} | crontab - "
  }
}
