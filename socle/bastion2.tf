resource "template_file" "bootstrap2" {
    template = "${file("files/bootstrap2.sh")}"
}

resource "aws_instance" "bastion2" {
  ami                         = "ami-405f7226" 
  associate_public_ip_address = true
  instance_type               = "m3.medium"
  subnet_id                   = "${aws_subnet.zone_transverse.id}"
  vpc_security_group_ids      = ["${aws_security_group.allow_ssh_from_any.id}"]
  key_name                    = "${aws_key_pair.hackathon.key_name}"
  user_data		      = "${template_file.bootstrap.rendered}"

  tags {
    Name  = "bastion2"
    Owner = "nikko"
  }
}
