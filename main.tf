provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"

}

# block to create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "terraformVPC"
  }
}

# block to fetch me all the availability zones for the region I'm in and put it in a data block
data "aws_availability_zones" "available" {
  state = "available"
}

#block to create the subnet based of created vpc
resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.sub_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Main"
  }
}

#block to  ADD ROUTE TABLE ASSOCIATION > ROUTE TABLE > INTERNET GATEWAY. BELOW \/ 
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

#block to  create route table connection vpc to open internet via internet gateway
resource "aws_route_table" "r" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "main"
  }
}

#block to create route table association linking routetable to subnets
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.r.id
}

#block to create security group allowing traffic from port 22 (SSH) and port 80(http)
resource "aws_security_group" "ingress-all-test" {
  name   = "allow-all-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }

  // Terraform removes the default rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


#block to creates ec2 instance
resource "aws_instance" "web" {
  ami                         = var.ami
  instance_type               = var.instance
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.subnet_a.id
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.ingress-all-test.id}"]

}

