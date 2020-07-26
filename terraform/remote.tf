terraform {
  backend "s3" {
    bucket = "terraform-state-paulb"
    key    = "tstate"
    region = "eu-central-1"
  }
}
