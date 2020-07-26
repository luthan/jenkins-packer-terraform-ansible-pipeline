data "aws_ami" "webami" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["web-server*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

resource "aws_instance" "web_server" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.webami.id
}

output "webbox_ip_address" {
  value = aws_instance.web_server.public_ip
}
