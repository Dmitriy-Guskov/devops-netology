# main.tf


provider "aws" {
  profile = "default"
#  region = "us-west-2"
  region  = var.aws_region
}

data "aws_ami" "ubuntu" {

    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-impish-21.10-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

data "aws_caller_identity" "current" {}

resource "aws_instance" "app_server" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}
