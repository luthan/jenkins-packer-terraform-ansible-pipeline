data "aws_ami" "jenkinsami" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["jenkins-server*"]
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

resource "aws_instance" "jenkins_server" {
  instance_type        = "t2.micro"
  ami                  = data.aws_ami.jenkinsami.id
  key_name             = aws_key_pair.jenkinskey.key_name
  iam_instance_profile = aws_iam_instance_profile.jenkins_server.name
}

output "jenkins_ip_address" {
  value = aws_instance.jenkins_server.public_ip
}
resource "aws_iam_role" "jenkins_server" {
  name               = "jenkins_server"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy" "EC2FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

data "aws_iam_policy" "S3FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "jenkins_server_ec2_policy_attachment" {
  role       = aws_iam_role.jenkins_server.name
  policy_arn = data.aws_iam_policy.EC2FullAccess.arn
}

resource "aws_iam_role_policy_attachment" "jenkins_server_s3_policy_attachment" {
  role       = aws_iam_role.jenkins_server.name
  policy_arn = data.aws_iam_policy.S3FullAccess.arn
}

resource "aws_iam_instance_profile" "jenkins_server" {
  name = "jenkins_server"
  role = aws_iam_role.jenkins_server.name
}
