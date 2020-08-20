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