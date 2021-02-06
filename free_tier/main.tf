terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

# Create a VPC
#resource "aws_vpc" "Lab-AppTest" {
#  cidr_block = "172.31.0.0/16"
#}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20200907"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals {
  vpc_id = "vpc-2c3c9c47"
}

resource "aws_instance" "web1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = ["Tomcat - Backend"]
  key_name = "jboss"
  tags = {
    Name = "Tomcat01"
  }
}

resource "aws_instance" "web2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = ["Tomcat - Backend"]
  key_name = "jboss"

  tags = {
    Name = "Tomcat02"
  }
}