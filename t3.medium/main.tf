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
resource "aws_vpc" "Lab-AppTest" {
  cidr_block = "172.31.0.0/16"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "Lab-k8s"

  ingress {
     description = "TLS from VPC"
     from_port   = 443
     to_port     = 443
     protocol    = "tcp"
     cidr_blocks = ["172.31.0.0/16"]
  }

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

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

resource "aws_instance" "Rancher01" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  security_groups = ["Tomcat - Backend"]
  key_name = "Rancher_01"
  tags = {
    Name = "Rancher"
  }
}

resource "aws_instance" "kube01" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  security_groups = ["Tomcat - Backend"]
  key_name = "Kubernets_03"

  tags = {
    Name = "k8s01"
  }
}

resource "aws_instance" "kube02" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  security_groups = ["Tomcat - Backend"]
  key_name = "Kubernets_02"

  tags = {
    Name = "k8s02"
  }
}

resource "aws_instance" "kube03" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  security_groups = ["Tomcat - Backend"]
  key_name = "Kubernets_03"

  tags = {
    Name = "k8s03"
  }
}
