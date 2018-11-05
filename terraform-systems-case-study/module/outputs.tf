output "public_ip" {
  value = "${aws_instance.ec2.public_ip}"
}

output "key_name" {
  value = "${aws_instance.ec2.key_name}"
}

output "dns_name" {
  value = "${aws_elb.elb.dns_name}"
}
