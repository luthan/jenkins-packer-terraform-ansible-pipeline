resource "aws_key_pair" "jenkinskey" {
  key_name   = "jenkinskey"
  public_key = file("jenkinskey.pub")
}
