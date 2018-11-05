data "template_file" "user-data" {
  template = "${file("${path.module}/user-data.tpl")}"
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

resource "aws_instance" "ec2" {
  ami = "ami-9887c6e7"
  instance_type = "t2.micro"
  key_name = "case-study"
  subnet_id = "subnet-086f3ed6742f38a16"
  vpc_security_group_ids = ["sg-03e9111b3bb9f8b40"]
  user_data               = "${data.template_cloudinit_config.user-data.rendered}"
  tags                    = {
    Name = "${var.candidate}-instance"
  }
}
