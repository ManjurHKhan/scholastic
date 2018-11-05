provider "aws" {
    region = "us-east-1"
    profile = "default"
}



resource "aws_instance" "ec2" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  tags                    = {
    Name = "${var.candidate}-instance"
  }
}

data "template_file" "user-data" {
  template = "${file("${path.module}/module/user-data.tpl")}"
}

data "template_cloudinit_config" "user-data" {
  gzip          = true
  base64_encode = true
  #cloud-init template
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.user-data.rendered}"
  }
}

resource "aws_elb" "elb" {
  name               = "${var.candidate}-elb"
  subnets            = ["${var.subnet_id}"]
  security_groups    = ["${var.vpc_security_group_ids}"]
  # availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 5
    target              = "TCP:80"
    interval            = 30
  }

  instances                   = ["${aws_instance.ec2.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 300
  connection_draining         = true
  connection_draining_timeout = 30

  tags {
    Name = "${var.candidate}-elb"
  }
}