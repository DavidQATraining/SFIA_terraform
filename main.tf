provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"

}

resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "terraformVPC"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.sub_cidr_block
  availability_zones = data.aws_availability_zones.available.names[]

  tags = {
    Name = "Main"
  }
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance
  key_name      = var.key_name
}

